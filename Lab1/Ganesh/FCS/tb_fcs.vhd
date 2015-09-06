library ieee;
use ieee.std_logic_1164.all;

entity tb_fcs is
end tb_fcs;

architecture beh of tb_fcs is
component fc_system
port(
          flight_no : in std_logic_vector(2 downto 0);
          request:    in std_logic;
	  reset,clk : in std_logic;
	  clk_out : out std_logic;--For demo only
	  grant,denied: out std_logic
	  );
end component;

signal flight_no_in: std_logic_vector(2 downto 0);
signal request_in,clk_in,reset_in,denied_out,grant_out,clk_out_out: std_logic;
signal clk_period: time :=10 ns;
begin
   uut:fc_system
   port map(flight_no=>flight_no_in,request=>request_in,reset=>reset_in,clk=>clk_in,clk_out=>clk_out_out,grant=>grant_out,denied=>denied_out);
   
   clock_process:process
   begin
      clk_in <= '0';
      wait for clk_period/2;
      clk_in <= not clk_in;
      wait for clk_period/2;
   end process;
   
   teset_bench:process
   begin
      flight_no_in <= "000";
      request_in<='0';
      reset_in<='1';
      wait for clk_period*5 + 5 ns;
      reset_in<='0';
      
      wait for clk_period;
      request_in<='1';
      
      wait for clk_period;
      request_in<='0';
      wait for clk_period*15;
      wait;
   end process;
end beh;
