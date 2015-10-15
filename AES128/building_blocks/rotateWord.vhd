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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rotateWord is
    Port ( wordIn : in STD_LOGIC_VECTOR (31 downto 0);
           wordOut : out STD_LOGIC_VECTOR (31 downto 0));
end rotateWord;

architecture Behavioral of rotateWord is

begin
    wordOut <= wordIn(23 downto 0) & wordIn(31 downto 24);
end Behavioral;
