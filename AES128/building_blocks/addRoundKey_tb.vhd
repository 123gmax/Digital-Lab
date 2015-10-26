----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 04:05:50 PM
-- Design Name: 
-- Module Name: addRoundKey_tb - Behavioral
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

entity addRoundKey_tb is
end addRoundKey_tb;

architecture Behavioral of addRoundKey_tb is
    component addRoundKey is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           wordIn : in STD_LOGIC_VECTOR (31 downto 0);
           keyIn : in STD_LOGIC_VECTOR (31 downto 0);
           wordOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    constant clk_period : time := 2ns;
    
    signal CLK, RESET : STD_LOGIC := '0';
    signal wordIn, keyIn, wordOut : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    uut: addRoundKey port map( CLK => CLK,
                               RESET => RESET,
                               wordIn => wordIn,
                               keyIn => keyIn,
                               wordOut => wordOut);
                               
   clk_process: process
   begin
    CLK <= '1';
    wait for clk_period/2;
    CLK <= '0';
    wait for clk_period/2;
   end process;
   
   --Inputs taken from http://kavaliro.com/wp-content/uploads/2014/03/AES.pdf
   stim_process: process
   begin
    wait for 5*clk_period;
    wordIn <= x"54776F20";
    keyIn <= x"54686174";
    wait for clk_period;
    wordIn <= x"4F6E6520";
    keyIn <= x"73206D79";
    wait for 5*clk_period;
   end process;
end Behavioral;
