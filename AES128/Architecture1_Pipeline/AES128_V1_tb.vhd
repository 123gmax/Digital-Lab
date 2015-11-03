----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2015 10:58:56 AM
-- Design Name: 
-- Module Name: AES128_V1_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity AES128_V1_tb is
end AES128_V1_tb;

architecture Behavioral of AES128_V1_tb is
    component AES128_V1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           READY_TO_DECRYPT : out STD_LOGIC;
           WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
           WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    constant clk_period : time := 2ns;
    
    signal CLK, RESET, ENABLE, READY_TO_DECRYPT : STD_LOGIC := '0';
    signal WORD_IN, WORD_OUT : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    
begin
    uut: AES128_V1 port map( CLK => CLK,
                             RESET => RESET,
                             ENABLE => ENABLE,
                             READY_TO_DECRYPT => READY_TO_DECRYPT,
                             WORD_IN => WORD_IN,
                             WORD_OUT => WORD_OUT);
                             
     clk_process: process
     begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
     end process;
     
     --Source http://kavaliro.com/wp-content/uploads/2014/03/AES.pdf
     stim_process: process
        variable I : natural range 0 to 100 := 0;
     begin
        I := 0;
        RESET <= '0';
        ENABLE <= '1';
        WORD_IN <= x"54686174";
        wait for clk_period;
        WORD_IN <= x"73206D79";
        wait for clk_period;
        WORD_IN <= x"204B756E";
        wait for clk_period;
        WORD_IN <= x"67204675";
        
        while READY_TO_DECRYPT = '0' loop
            wait for clk_period;
        end loop;
        
        WORD_IN <= x"29C3505F";
        wait for clk_period;
        WORD_IN <= x"571420F6";
        wait for clk_period;
        WORD_IN <= x"402299B3";
        wait for clk_period;
        WORD_IN <= x"1A02D73A";
        wait for clk_period;
        
        --It takes 69 clock cycles for the first decrypted word to exit the pipe. 
        WORD_IN <= x"00000000";
        wait for 10*clk_period;
        WORD_IN <= x"00000001";
        wait for 10*clk_period;
        WORD_IN <= x"00000002";
        wait for 10*clk_period;
        WORD_IN <= x"00000003";
        wait for 10*clk_period;
        WORD_IN <= x"00000004";
        wait for 10*clk_period;
        WORD_IN <= x"00000005";
        wait for 10*clk_period;
        WORD_IN <= x"00000006";
        wait for 10*clk_period;
        WORD_IN <= x"00000007";
        wait for 10*clk_period;
        
     end process;

end Behavioral;
