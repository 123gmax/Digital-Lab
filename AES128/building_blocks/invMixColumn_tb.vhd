----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 03:36:03 PM
-- Design Name: 
-- Module Name: invMixColumn_tb - Behavioral
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

entity invMixColumn_tb is
end invMixColumn_tb;

architecture Behavioral of invMixColumn_tb is
    component invMixColumn is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               wordIn : in STD_LOGIC_VECTOR (31 downto 0);
               wordOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    constant clk_period : time := 2ns;
    signal CLK, RESET : STD_LOGIC := '0';
    signal wordIn, wordOut : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    uut: invMixColumn port map( CLK => CLK,
                                RESET => RESET,
                                wordIn => wordIn,
                                wordOut => wordOut);
                                
    clk_process: process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;
    
    --Samples based on http://kavaliro.com/wp-content/uploads/2014/03/AES.pdf
    stim_process: process
    begin
        wait for 5* clk_period;
        wordIn <= x"BA75F47A";
        --Expected output: x"632FAFA2"
        wait for clk_period;
        wordIn <= x"84A48D32";
        --Expected output: x"EB93C720"
        wait for clk_period;
        wordIn <= x"E88D060E";
        --Expected output: x"9F92ABCB"
        wait for 5*clk_period;
    end process;
end Behavioral;
