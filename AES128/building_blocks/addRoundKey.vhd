----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2015 03:22:58 PM
-- Design Name: 
-- Module Name: addRoundKey - Behavioral
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

entity addRoundKey is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           wordIn : in STD_LOGIC_VECTOR (31 downto 0);
           keyIn : in STD_LOGIC_VECTOR (31 downto 0);
           wordOut : out STD_LOGIC_VECTOR (31 downto 0));
end addRoundKey;

architecture Behavioral of addRoundKey is

begin
    process(CLK, RESET, wordIn, keyIn)
    begin
        if RESET = '1' then
            wordOut <= (others => '0');
        elsif rising_edge(CLK) then
            wordOut <= wordIn XOR keyIn;
        end if;
    end process;
end Behavioral;
