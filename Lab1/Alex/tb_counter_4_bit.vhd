----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/01/2015 11:33:30 AM
-- Design Name: 
-- Module Name: tb_counter_4_bit - Behavioral
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

entity tb_counter_4_bit is   
end tb_counter_4_bit;

architecture Behavioral of tb_counter_4_bit is
 signal CLK, direction, auto, tick, load : STD_LOGIC := '0';
 signal load_input, output : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
 
 component counter_4_bit is
     Port(   CLK         : in STD_LOGIC;
             direction   : in STD_LOGIC;
             auto        : in STD_LOGIC;
             tick        : in STD_LOGIC;
             load        : in STD_LOGIC;
             load_input  : in STD_LOGIC_VECTOR(3 downto 0);
             output      : out STD_LOGIC_VECTOR(3 downto 0)
         );
 end component;
 
 constant clk_period : time := 2ns;
 
begin
    
    clk_process: process
    begin
        CLK <= NOT CLK;
        wait for clk_period/2;
    end process;
    
    uut: counter_4_bit PORT MAP(
        CLK => CLK,
        direction => direction,
        auto => auto,
        tick => tick,
        load => load,
        load_input => load_input,
        output => output
    );

    stimulus_process: process
    begin
        auto <= '1';
        direction <= '1';
        wait for 40ns;
        direction <= '0';
        wait for 34ns;
        
        auto <= '0';
        direction <= '1';
        wait for 1ns;
        
        for i in 0 to 3 loop
            tick <= '1';
            wait for 1ns;
            tick <= '0';
            wait for 1ns;
        end loop;
        
        direction <= '0';
        wait for 1ns;
        
        for i in 0 to 5 loop
            tick <= '1';
            wait for 1ns;
            tick <= '0';
            wait for 1ns;
        end loop;
        
        auto <= '1';
        wait for 30ns;
        load_input <= "0101";
        load <='1';
        wait for 1ns;
        load <= '0';
        wait;
    end process;
end Behavioral;
