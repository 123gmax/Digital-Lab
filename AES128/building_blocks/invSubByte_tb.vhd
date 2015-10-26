----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 10:49:35 PM
-- Design Name: 
-- Module Name: invSubByte_tb - Behavioral
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

entity invSubByte_tb is
end invSubByte_tb;

architecture Behavioral of invSubByte_tb is
    component invSubByte is
        Port ( byteIn : in STD_LOGIC_VECTOR(7 downto 0);
               byteOut : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    constant clk_period : time := 2ns;
    signal CLK, RESET : STD_LOGIC := '0';
    signal byteIn, byteOut : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    uut: invSubByte port map( CLK => CLK,
                              RESET => RESET,
                              byteIn => byteIn,
                              byteOut => byteOut);
                              
    clk_process: process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;
    
    stim_process: process
    begin
        byteIn <= x"05";
        wait for clk_period;
        byteIn <= x"70";
        wait for clk_period;
        RESET <= '1';
        byteIn <= x"80";
        wait for clk_period;
        RESET <= '0';
        wait for clk_period;
    end process;


end Behavioral;
