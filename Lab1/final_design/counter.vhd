----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ganesh Hegde and Alex
-- 
-- Create Date: 09/01/2015 10:52:25 AM
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
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
end counter;

architecture beh of counter is
signal n_count:unsigned(3 downto 0);
signal p_count:unsigned(3 downto 0);
signal sum: unsigned(3 downto 0);
signal addend: unsigned(3 downto 0);
signal clk_1sec:std_logic;
signal pulse: std_logic;
signal clk_count : unsigned(26 downto 0);
begin
--Clock process
   process(clk,RESET)
   begin 
   if(RESET ='1') then
   clk_1sec <= '0';
   clk_count <= (others => '0');
   elsif (clk' event and clk ='1') then
      clk_count <= clk_count + 1;
      clk_1sec <= std_logic(clk_count(26));
   end if;
   end process;
   
--State register
   process(pulse,LOAD,VALUE)
   begin
      if(LOAD = '1') then
         p_count <= unsigned(VALUE);
      elsif(pulse' event and pulse ='1') then
         p_count <= n_count;
      end if;
   end process;
 
 --State reg clock logic
   with AUTO select
   pulse <= TICK  when '0',
            clk_1sec when others;
            
 --Next state logic
   n_count <= sum;
              
--UP/DOWN select   
   with UP select
   addend <= "1111"  when '0',
             "0001" when others;            
 
 --Adder 
   sum <= p_count + addend;
   
--Output Logic 
   COUNT <= std_logic_vector(p_count);
   
end beh;
