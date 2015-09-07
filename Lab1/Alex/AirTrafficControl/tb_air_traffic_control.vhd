----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/06/2015 11:59:17 AM
-- Design Name: 
-- Module Name: tb_air_traffic_control - Behavioral
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

entity tb_air_traffic_control is
end tb_air_traffic_control;

architecture Behavioral of tb_air_traffic_control is
    signal PLANE_TYPE : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal REQ, CLK, GRANTED, DENIED : STD_LOGIC := '0';
    
    component air_traffic_control is
    Port ( PLANE_TYPE : in STD_LOGIC_VECTOR (2 downto 0);
           REQ : in STD_LOGIC;
           CLK : in STD_LOGIC;
           GRANTED : out STD_LOGIC;
           DENIED : out STD_LOGIC);
    end component;
    
    constant clk_period : time :=2ns;
begin
    uut: air_traffic_control PORT MAP(
        PLANE_TYPE => PLANE_TYPE,
        REQ => REQ,
        CLK => CLK,
        GRANTED => GRANTED,
        DENIED => DENIED
    );

    clk_process: process
    begin
        CLK <= NOT CLK;
        wait for clk_period/2;
    end process;

    stimulus: process
    begin
        --Light jet Request
        PLANE_TYPE <= "000";
        REQ <= '1';
        wait for 10ns;
        REQ <= '0';
        wait for 10ns;
        
        --Heavy Jet Request during take-off
        PLANE_TYPE <= "001";
        REQ <= '1';
        wait for 10ns;
        REQ <= '0';
        wait for 10ns;
        
        --Wait for take-off to complete        
        wait for 60ns;
        --Repeat Heavy request
        REQ <= '1';
        wait for 10ns;
        REQ <= '0';
        wait for 10ns;
        
        --Wait for take-off to complete
        wait for 60ns;
        --Light jet Request
        PLANE_TYPE <= "010";
        REQ <= '1';
        wait for 10ns;
        REQ <= '0';
        wait for 10ns;
        
        --Wait for DENY to complete
        wait for 60ns;
        
        --Heavy Jet Request
        PLANE_TYPE <= "011";
        REQ <= '1';
        wait for 10ns;
        REQ <= '0';
        wait for 10ns;
    
        --Wait for Turbulence to clear
        wait for 200ns;
        
        --Light jet Request
        PLANE_TYPE <= "100";
        REQ <= '1';
        wait for 10ns;
        REQ <= '0';
        wait for 10ns;
        
        wait;    
    end process;

end Behavioral;
