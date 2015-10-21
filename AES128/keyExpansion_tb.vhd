----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2015 09:18:48 PM
-- Design Name: 
-- Module Name: keyExpansion_tb - Behavioral
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

entity keyExpansion_tb is
end keyExpansion_tb;

architecture Behavioral of keyExpansion_tb is
    signal CLK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal START : STD_LOGIC := '0';
    signal cipherKey : STD_LOGIC_VECTOR (127 downto 0):= (others => '0');
    signal DONE : STD_LOGIC := '0';
    signal IDLE : STD_LOGIC := '0';
    signal MUTATING : STD_LOGIC := '0'; 
    signal expandedKey : STD_LOGIC_VECTOR (1407 downto 0) := (others => '0');
    
    constant clk_period : time := 2ns;
    
    component keyExpansion
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               START : in STD_LOGIC;
               cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
               DONE : out STD_LOGIC;
               IDLE : out STD_LOGIC;
               MUTATING : out STD_LOGIC;
               expandedKey : out STD_LOGIC_VECTOR (1407 downto 0));
   end component;
    
begin
    uut: keyExpansion Port Map( CLK => CLK,
                                RESET => RESET,
                                START => START,
                                cipherKey => cipherKey,
                                DONE => DONE,
                                IDLE => IDLE,
                                MUTATING => MUTATING,
                                expandedKey => expandedKey);
    
    clock_process: process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;
    
    stim_process: process
    begin
        --Key expansion samples taken from http://www.samiam.org/key-schedule.html
        wait for 5*clk_period;
        cipherKey <= x"00000000000000000000000000000000";
        START <= '1';
        wait for clk_period;
        START <= '0';
        while DONE = '0' loop
            wait for clk_period;
        end loop;
        wait for clk_period*10;
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
        
        wait for 5*clk_period;
        cipherKey <= x"ffffffffffffffffffffffffffffffff";
        START <= '1';
        wait for clk_period;
        START <= '0';
        while DONE = '0' loop
            wait for clk_period;
        end loop;
        wait for clk_period*10;
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
                
        wait for 5*clk_period;
        cipherKey <= x"000102030405060708090a0b0c0d0e0f";
        START <= '1';
        wait for clk_period;
        START <= '0';
        while DONE = '0' loop
            wait for clk_period;
        end loop;
        wait for clk_period*10;
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
    end process;
    
end Behavioral;
