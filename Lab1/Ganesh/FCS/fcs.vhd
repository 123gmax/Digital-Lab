library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fc_system is
port(
          flight_no : in std_logic_vector(2 downto 0);
          request:    in std_logic;
	  reset,clk : in std_logic;
	  clk_out : out std_logic;--For demo only
	  grant,denied: out std_logic
	  );
end fc_system;

architecture beh of fc_system is
type state_type is (IDLE,WBReq,WBGrant,WBOnly,Deny,Deny_t,NBReq,NBGrant);
signal state_reg,state_next : state_type;
signal load3_clk,load10_clk: std_logic;
signal clk10_cnt_reg,clk10_cnt_next: unsigned(26 downto 0);
signal clk3_cnt_reg,clk3_cnt_next:unsigned(26 downto 0);
signal clk10_reg,clk10_next: unsigned(4 downto 0);
signal clk3_reg,clk3_next: unsigned(2 downto 0);

begin
--State register logic
   process(clk,reset)
   begin
      if(reset='1') then
		 state_reg <= IDLE;
		 clk10_cnt_reg <= (others=>'0');
		 clk3_cnt_reg <= (others =>'0');
		 clk10_reg <= (others=>'0');
		 clk3_reg<=(others=>'0');
	  elsif(clk' event and clk ='1') then 
		 state_reg <= state_next;
		 clk10_cnt_reg <= clk10_cnt_next;
		 clk3_cnt_reg <= clk3_cnt_next;
		 clk10_reg <= clk10_next;
		 clk3_reg <= clk3_next;
	   end if;
   end process;
   

-- Derived clock logic
  clk10_cnt_next <= (others=>'0') when (load10_clk='1' or clk10_cnt_reg(26)='1') else--26
                    clk10_cnt_reg + 1;

  clk3_cnt_next <= (others=>'0') when (load3_clk='1' or clk3_cnt_reg(26)='1') else--26
                    clk3_cnt_reg + 1;
  
  clk10_next <= "10100" when (load10_clk ='1') else
                (others =>'0') when (clk10_reg = "00000") else
                (clk10_reg - 1) when (clk10_cnt_reg(26)='1') else
                clk10_reg;
  
  clk3_next <=  "110" when (load3_clk ='1') else
                (others => '0') when (clk3_reg ="000" ) else
                (clk3_reg - 1) when (clk3_cnt_reg(26)='1') else
                clk3_reg;  
--Demo only
process(clk10_reg(0),reset)
begin
   if(reset ='1') then
      clk_out <= '0'
    elsif(clk10_reg(1) ' event and clk10_reg(1)='1') the
      clk_out <=
   end if
end process;
          
--Next state logic and output logic
   process(state_reg,request,clk10_reg,clk3_reg)
   begin
   grant <= '0';
   denied <='0'; 
   load10_clk <='0';
   load3_clk <='0';
      case state_reg is
         when IDLE =>
            if(request ='1') then
               if(flight_no="001" or flight_no="011" or flight_no ="111") then
                  state_next <= WBReq;
               else
                  state_next <= NBReq; 
               end if;
            else
            state_next <= IDLE;
            end if;
            
         when WBReq=>
            load10_clk<='1';
            state_next <= WBGrant;
            
         when WBGrant =>
            if(clk10_reg = "01110") then --3Sec elapsed
               state_next <= WBOnly;
            else
               state_next <= WBGrant;
            end if;
            grant <= '1';
            
         when WBOnly =>
            if(request = '1') then
               if(flight_no="001" or flight_no="011" or flight_no ="111") then
                  state_next <= WBReq;
               else
                  state_next <= Deny_t;
               end if;
            elsif(clk10_reg="00000") then
               state_next <= IDLE;
            else             
               state_next <= WBOnly;
            end if;
            
         when Deny_t =>
            load3_clk <='1';
            state_next <= Deny;
            
         when Deny =>
            if(clk3_reg = "000") then
               state_next<=WBOnly;
            else
               state_next <= Deny;
            end if;
            denied <='1';
            
         when NBReq =>
            load3_clk <='1';
            load10_clk <='1'; --Demo purposr only
            state_next <= NBGrant;
         
         when NBGrant =>
            if(clk3_reg ="000") then
               state_next <= IDLE;
            else
               state_next <= NBGrant;
            end if;
            grant <= '1';                              
      end case;
   end process;            
end beh;	  
