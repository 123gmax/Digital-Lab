----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 08:22:22 PM
-- Design Name: 
-- Module Name: decryptionLoopCore_V1_tb - Behavioral
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

entity decryptionLoopCore_V1_tb is
end decryptionLoopCore_V1_tb;

architecture Behavioral of decryptionLoopCore_V1_tb is
    component decryptionLoopCore_V1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           memorySourceSelector : in STD_LOGIC;
           keySelector : in STD_LOGIC_VECTOR (1 downto 0);
           cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
           WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
           WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component controlUnit is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               ENABLE : in STD_LOGIC;
               loadSourceSelector : out STD_LOGIC;
               addRoundKeySelector1 : out STD_LOGIC_VECTOR(1 downto 0);
               addRoundKeySelector2 : out STD_LOGIC_VECTOR(1 downto 0)
               );
    end component;
    
    constant clk_period : time := 2ns;
    signal CLK, RESET, ENABLE, memorySourceSelector : STD_LOGIC := '0';
    signal keySelector : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal cipherKey : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
    signal WORD_IN, WORD_OUT : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    ENABLE <= '1';
    uut: decryptionLoopCore_V1 port map( CLK => CLK,
                                         RESET => RESET,
                                         memorySourceSelector => memorySourceSelector,
                                         keySelector => keySelector,
                                         cipherKey => cipherKey,
                                         WORD_IN => WORD_IN,
                                         WORD_OUT => WORD_OUT);
    
    controlUnit0: controlUnit port map( CLK => CLK,
                                        RESET => RESET,
                                        ENABLE => ENABLE,
                                        loadSourceSelector => memorySourceSelector,
                                        addRoundKeySelector1 => open,
                                        addRoundKeySelector2 => keySelector); 
               
     clk_process: process
     begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;
    
    --Source http://kavaliro.com/wp-content/uploads/2014/03/AES.pdf decrypt ROUND 10
    stim_process: process
    begin
        --Wait for one clk_period to synchronize the control unit.
        --During this clk_period, the first addRoundKey would occur.
        wait for clk_period;
        cipherKey <= x"BFE2BF904559FAB2A16480B4F7F1CBD8";
        WORD_IN <= x"013E8EA7";
        wait for clk_period;
        WORD_IN <= x"3AB004BC";
        wait for clk_period;
        WORD_IN <= x"8CE23D4D";
        wait for clk_period;
        WORD_IN <= x"2133B81C";
        wait for clk_period;
        WORD_IN <= (others => '0');
    end process;


end Behavioral;
