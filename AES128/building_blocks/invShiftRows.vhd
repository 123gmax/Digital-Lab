----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2015 03:27:35 PM
-- Design Name: 
-- Module Name: invShiftRows - Behavioral
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

entity invShiftRows is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           blockIn : in STD_LOGIC_VECTOR (127 downto 0);
           blockOut : out STD_LOGIC_VECTOR (127 downto 0));
end invShiftRows;

architecture Behavioral of invShiftRows is

begin
    process(CLK, RESET, blockIn)
    begin
        if RESET = '1' then
            blockOut <= (others => '0');
        elsif rising_edge(CLK) then
            blockOut(127 downto 120) <= blockIn(127 downto 120); --Block[0] = Block[0]
            blockOut(119 downto 112) <= blockIn(23 downto 16);   --Block[1] = Block[13]
            blockOut(111 downto 104) <= blockIn(47 downto 40);   --Block[2] = Block[10]
            blockOut(103 downto 96)  <= blockIn(71 downto 64);   --Block[3] = Block[7]
            
            blockOut(95 downto 88)   <= blockIn(95 downto 88);   --Block[4] = Block[4]
            blockOut(87 downto 80)   <= blockIn(119 downto 112); --Block[5] = Block[1]
            blockOut(79 downto 72)   <= blockIn(15 downto 8);    --Block[6] = Block[14]
            blockOut(71 downto 64)   <= blockIn(39 downto 32);   --Block[7] = Block[11]
            
            blockOut(63 downto 56)   <= blockIn(63 downto 56);   --Block[8] = Block[8]
            blockOut(55 downto 48)   <= blockIn(87 downto 80);   --Block[9] = Block[5]
            blockOut(47 downto 40)   <= blockIn(111 downto 104); --Block[10] = Block[2]
            blockOut(39 downto 32)   <= blockIn(7 downto 0);     --Block[11] = Block[15]
         
            blockOut(31 downto 24)   <= blockIn(31 downto 24);   --Block[12] = Block[12]
            blockOut(23 downto 16)   <= blockIn(55 downto 48);   --Block[13] = Block[9]
            blockOut(15 downto 8)    <= blockIn(79 downto 72);   --Block[14] = Block[6]
            blockOut(7 downto 0)     <= blockIn(103 downto 96);  --Block[15] = Block[3]
        end if;
    end process;
end Behavioral;
