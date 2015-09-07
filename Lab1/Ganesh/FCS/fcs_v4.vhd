library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fc_system_v4 is
port(
          flight_no : in std_logic_vector(2 downto 0);
          request:    in std_logic;
	  reset,clk : in std_logic;
	  clk3_out,clk10_out : out std_logic;--For demo only
	  grant,denied: out std_logic
	  );
end fc_system_v4;

architecture beh of fc_system_v4 is
type state_type is (IDLE,WBReq,WBGrant,WBOnly,Deny,Deny_t,NBReq,NBGrant);
signal state_reg,state_next:state_type;
signal clk3_count,clk10_count : unsigned(26 downto 0);
signal pulse3_1sec,pulse10_1sec: std_logic;
signal clk10_reg,clk10_next:unsigned(3 downto 0);
signal clk3_reg,clk3_next:unsigned(1 downto 0);
signal load10_clk,load3_clk:std_logic;
signal clk3_out_reg,clk3_out_next,clk10_out_reg,clk10_out_next:std_logic;--Demo only
signal reset3,reset10:std_logic;
begin

   process(clk,reset)
   begin 
   if(reset ='1') then
      state_reg<=IDLE;
   elsif (clk' event and clk ='1') then
      state_reg<=state_next;
   end if;
   end process;
   
 --Clock process  
   process(clk,reset3)
   begin 
   if(reset3 ='1') then
      clk3_count <= (others => '0');
   elsif (clk' event and clk ='1') then
      clk3_count <= clk3_count + 1;
   end if;
   end process;
     
   process(clk,reset10)
   begin 
   if(reset10 ='1') then
      clk10_count <= (others => '0');
   elsif (clk' event and clk ='1') then
      clk10_count <= clk10_count + 1;
   end if;
   end process;
       
   process(pulse10_1sec,load10_clk)
   begin
   if(load10_clk ='1') then 
      clk10_reg<="1010";
      clk10_out_reg<='1';  
   elsif(pulse10_1sec' event and pulse10_1sec ='1') then
      clk10_reg <= clk10_next;
      clk10_out_reg <= clk10_out_next;--Demo only
   end if;
   end process;
   
   process(pulse3_1sec,load3_clk)
   begin
   if(load3_clk ='1') then 
      clk3_reg<="11";   
      clk3_out_reg<='1';
   elsif(pulse3_1sec' event and pulse3_1sec ='1') then
      clk3_reg <= clk3_next;
      clk3_out_reg <= clk3_out_next;--Demo only
   end if;   
   end process;
   
  pulse3_1sec <= clk3_count(26);
  pulse10_1sec <= clk10_count(26);
  
  reset3 <= load3_clk or reset;
  reset10 <= load10_clk or reset;
  
  clk3_out_next <= not clk3_out_reg;
  clk10_out_next <= not clk10_out_reg;
  clk3_out<=clk3_out_reg;
  clk10_out<=clk10_out_reg;
  
  clk10_next <= (others =>'0') when (clk10_reg = "0000") else
                (clk10_reg - 1);
  
  clk3_next <=  (others => '0') when (clk3_reg ="00" ) else
                (clk3_reg - 1);  

       
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
            if(clk10_reg = "0111") then --3Sec elapsed
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
            elsif(clk10_reg="0000") then
               state_next <= IDLE;
            else             
               state_next <= WBOnly;
            end if;
            
         when Deny_t =>
            load3_clk <='1';
            state_next <= Deny;
            
         when Deny =>
            if(clk3_reg = "00") then
               state_next<=WBOnly;
            else
               state_next <= Deny;
            end if;
            denied <='1';
            
         when NBReq =>
            load3_clk <='1';
            --load10_clk <='1'; --Demo purposr only
            state_next <= NBGrant;
         
         when NBGrant =>
            if(clk3_reg ="00") then
               state_next <= IDLE;
            else
               state_next <= NBGrant;
            end if;
            grant <= '1';                              
      end case;
   end process;     
end beh;
