----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2015 07:19:02 PM
-- Design Name: 
-- Module Name: controlUnit - Behavioral
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

entity controlUnit is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           loadSourceSelector : out STD_LOGIC := '0';
           addRoundKeySelector1 : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
           addRoundKeySelector2 : out STD_LOGIC_VECTOR(1 downto 0) := (others => '0')
           );
end controlUnit;

architecture Behavioral of controlUnit is
        constant INITIAL_STATE : natural := 6;
        constant NUM_STATES : natural := 6;
begin
    
    loadSourceSelectorProcess: process(CLK, RESET, ENABLE)
        constant ENABLE_STATE : natural := 3;
        variable state : natural range 0 to NUM_STATES := INITIAL_STATE;
    begin
        if RESET = '1' then
            state := INITIAL_STATE;
        elsif rising_edge(CLK) then
            loadSourceSelector <= '0';
            if ENABLE = '1' then
                if (state = ENABLE_STATE) then
                    loadSourceSelector <= '1';
                else
                    loadSourceSelector <= '0';
                end if;
                if (state < NUM_STATES) then
                   state := state + 1;
                else
                   state := 0;
                end if;
            end if;
        end if;
    end process;
    
    addRoundKeySelectorProcess2 : process(CLK, RESET)
            variable state : natural range 0 to NUM_STATES := INITIAL_STATE;
        begin
            if RESET = '1' then
                state := INITIAL_STATE;
            elsif rising_edge(CLK) then
                addRoundKeySelector2 <= "10";  --NOTE: THIS SHOULD ALWAYS BE THE VALUE OUTPUT BY THE PREVIOUS TO INITIAL STATE. IT SHOULD BE MANUALLY UPDATED
                if ENABLE = '1' then
                    case state is
                        when 3 => addRoundKeySelector2 <= "00";
                        when 4 => addRoundKeySelector2 <= "11";
                        when 5 => addRoundKeySelector2 <= "10";
                        when 6 => addRoundKeySelector2 <= "01";
                        when others => addRoundKeySelector2 <= (others => '0');
                    end case;
                    if (state < NUM_STATES) then
                       state := state + 1;
                    else
                       state := 0;
                    end if;
                end if;
            end if;
        end process;
    
    --The initial addRoundKeySelector always has four states instead of six, since it occurs before the pipeline delay.
    addRoundKeySelectorProcess1 : process(CLK, RESET, ENABLE)
        variable state : natural range 0 to 3 := 2;
    begin
        if RESET = '1' then
            state := 3;
        elsif rising_edge(CLK) then
            addRoundKeySelector1 <= "11";  --NOTE: THIS SHOULD ALWAYS BE THE VALUE OUTPUT BY THE PREVIOUS TO INITIAL STATE. IT SHOULD BE MANUALLY UPDATED
            if ENABLE = '1' then
                case state is
                    when 3 => addRoundKeySelector1 <= "11";
                    when 2 => addRoundKeySelector1 <= "10";
                    when 1 => addRoundKeySelector1 <= "01";
                    when 0 => addRoundKeySelector1 <= "00";
                    when others => addRoundKeySelector1 <= (others => '0');
                end case;
                if (state > 0) then
                    state := state - 1;
                else
                    state := 3;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
