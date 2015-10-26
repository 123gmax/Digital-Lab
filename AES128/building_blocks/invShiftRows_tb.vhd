----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 07:54:52 PM
-- Design Name: 
-- Module Name: invShiftRows_tb - Behavioral
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

entity invShiftRows_tb is
end invShiftRows_tb;

architecture Behavioral of invShiftRows_tb is
    component invShiftRows is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           blockIn : in STD_LOGIC_VECTOR (127 downto 0);
           blockOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    constant clk_period : time := 2ns;
    signal CLK, RESET : STD_LOGIC;
    signal blockIn, blockOut : STD_LOGIC_VECTOR(127 downto 0);
begin
    uut: invShiftRows port map( CLK => CLK,
                                RESET => RESET,
                                blockIn => blockIn,
                                blockOut => blockOut);
                                
    clk_process: process
    begin
        CLK <= '1';
        wait for clk_period/2;
        CLK <= '0';
        wait for clk_period/2;
    end process;
    
    stim_process: process
    begin
        wait for 5*clk_period;
        blockIn <= x"00112233445566778899AABBCCDDEEFF";
        wait for clk_period;
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
        wait for clk_period;
        blockIn <= x"FFEEDDCCBBAA99887766554433221100";
        wait for clk_period;
        blockIn <= x"632FAFA2EB93C7209F92ABCBA0C0302B";
        wait for 5*clk_period;
    
    end process;


end Behavioral;
