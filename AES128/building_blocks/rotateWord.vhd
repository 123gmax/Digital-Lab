----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2015 03:17:32 PM
-- Design Name: 
-- Module Name: rotateWord - Behavioral
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

entity rotateWord is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           wordIn : in STD_LOGIC_VECTOR (31 downto 0);
           wordOut : out STD_LOGIC_VECTOR (31 downto 0));
end rotateWord;

architecture Behavioral of rotateWord is

begin
    process(CLK, RESET, wordIn)
    begin
        if RESET = '1' then
            wordOut <= (others => '0');
        elsif rising_edge(CLK) then
            wordOut <= wordIn(23 downto 0) & wordIn(31 downto 24);
        end if;
    end process;
end Behavioral;
