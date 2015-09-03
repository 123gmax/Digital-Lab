library ieee;
use ieee.std_logic_1164.all;

entity tb_counter is
end tb_counter;

architecture beh of tb_counter is

   component counter
       Port (
               UP:    in std_logic;
               AUTO:  in std_logic;
               LOAD:  in std_logic;
               VALUE: in std_logic_vector(3 downto 0);
               TICK:  in std_logic;
               COUNT: out std_logic_vector(3 downto 0);
               RESET: in std_logic;
               clk:  in std_logic  
             );
   end component;
   
   signal up_in,auto_in,load_in,tick_in,reset_in,clk_in : std_logic;
   signal value_in,count_out : std_logic_vector(3 downto 0);
   constant clock_period : time:= 10 ns;
   constant period_1sec : time:= 50 ns; 
   
begin
   uut:counter
       port map(UP=>up_in,AUTO=>auto_in,LOAD=>load_in,VALUE=>value_in,TICK=>tick_in,COUNT=>count_out,RESET=>reset_in,clk=>clk_in);
   
   clock_process:process
   begin
      clk_in <= '0';
      wait for clock_period/2;
      clk_in <= not clk_in;
      wait for clock_period/2;
   end process;
       
   test_bench:process
   begin
      reset_in <= '1';
      up_in <= '0';
      auto_in <='0';
      load_in <='0';
      value_in <="0000";
      tick_in <= '0';
      
      wait for 10*clock_period;
      reset_in <= '0';
      
      wait for period_1sec;
      value_in <= "1010";
      load_in <= '1';
      up_in <= '1'; --Up counter
      auto_in <='1'; --Auto count
      
      wait for period_1sec + 5 ns;
      load_in <='0';
       
      wait for 10*period_1sec;
      up_in <= '0';--Down count
      
      wait for 10*period_1sec;
      auto_in <='0';--Manual mode
      
      wait for period_1sec;
      tick_in <= not tick_in;--1
      
      wait for 2*period_1sec;
      tick_in <= not tick_in;--0
      
      wait for period_1sec*3;
      tick_in <= not tick_in;--1
      
      wait for period_1sec;
      auto_in <= '1';--Auto mode
      up_in <= '1'; -- Up count
      
      wait;
      
   end process;
         
end beh;
