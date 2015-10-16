----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2015 11:51:31 AM
-- Design Name: 
-- Module Name: memoryUnit - Behavioral
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

entity memoryUnit is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           SELB : in STD_LOGIC;
           wordAIn : in STD_LOGIC_VECTOR (31 downto 0);
           wordBin : in STD_LOGIC_VECTOR (31 downto 0);
           wordOut : out STD_LOGIC_VECTOR (31 downto 0));
end memoryUnit;

architecture Behavioral of memoryUnit is

begin
    process(CLK, RESET, SELB, wordAIn, wordBin)
    begin
        if RESET = '1' then
            wordOut <= (others => '0');
        elsif rising_edge(CLK) then
            if SELB = '0' then
                wordOut <= wordAIn;
            else
                wordOut <= wordBIn;
            end if;
        end if;
    end process;

end Behavioral;
