----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2015 06:05:13 PM
-- Design Name: 
-- Module Name: air_traffic_control - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity air_traffic_control is
    Port ( PLANE_TYPE : in STD_LOGIC_VECTOR (2 downto 0);
           REQ : in STD_LOGIC;
           CLK : in STD_LOGIC;
           GRANTED : out STD_LOGIC;
           DENIED : out STD_LOGIC);
end air_traffic_control;

architecture Behavioral of air_traffic_control is
    signal clk_1ms : STD_LOGIC := '0';
    signal jet_type : STD_LOGIC := '0';
    signal clk_count : integer range 0 to 50000 := 0; 
    signal current_state : integer range 0 to 4 := 0;
    signal next_state : integer range 0 to 4 := 0;
    signal timer_3s : integer range 0 to 3000 := 0;
    signal timer_heavy : integer range -10000 to 10000 := 0;
    constant c_3s : integer := 3000;
    constant c_7s : integer := 7000;
    
begin

--Clock divider process
   process(CLK)
   begin
       if (rising_edge(CLK)) then
         if(clk_count > 50000) then
            clk_count <= 0;
            clk_1ms <= not clk_1ms;
         else
            clk_count <= clk_count+1;
         end if;
       end if;
   end process;
--    clk_1ms <= CLK; --This should be used for simulation purposes instead of the clock divider process.

--Jet classification process
    process(PLANE_TYPE)
    begin
        case PLANE_TYPE is
            when "001" | "011" | "111" => jet_type <= '1'; --Heavy Jet: 1, 3, 7
            when others => jet_type <= '0';             --Light Jet
        end case;
    end process;

--Runway State Process
    process(clk_1ms)
    begin
        if(rising_edge(clk_1ms)) then
            case current_state is
                when 0 => --RUNWAY READY
                    if(REQ = '1') then
                        timer_3s <= c_3s;
                        if(jet_type = '1') then
                            next_state <= 3;
                        else
                            next_state <= 2;
                        end if;
                    end if;
                when 1 => -- HEAVY TURBULENCE DELAY
                    if(REQ = '1') then
                        timer_3s <= c_3s;
                        if(jet_type = '1') then
                            next_state <= 3;
                        else
                            next_state <= 4;
                        end if;
                    else
                        if(timer_heavy > 0) then
                            timer_heavy <= timer_heavy - 1;
                        else
                            next_state <= 0;
                        end if;
                    end if;
                when 2 => --LIGHT TAKE_OFF
                    if(timer_3s > 0) then
                        timer_3s <= timer_3s - 1;
                    else
                        next_state <= 0;
                    end if;
                when 3 => --HEAVY TAKE-OFF
                    if(timer_3s > 0) then
                        timer_3s <= timer_3s - 1;
                    else
                        timer_heavy <= c_7s;
                        next_state <= 1;
                    end if;
                when 4 => --DENIED
                    if(timer_3s > 0) then
                        timer_3s <= timer_3s - 1;
                    else
                        timer_heavy <= timer_heavy - c_3s;
                        if(timer_heavy > 0) then
                            next_state <= 1;
                        else
                            next_state <= 0;
                        end if;
                    end if;
            end case;
        end if;
    end process;

--State transition process
    process(CLK)
    begin
        if(rising_edge(CLK)) then
            current_state <= next_state;
        end if;
    end process;

--Output during certain FSM states.
    process(current_state)
    begin
        if(current_state = 4) then
            DENIED <= '1';
            GRANTED <= '0';
        elsif ((current_state = 2) OR (current_state = 3)) then
            DENIED <= '0';
            GRANTED <= '1';
        else
            DENIED <= '0';
            GRANTED <= '0';
        end if;
    end process;
end Behavioral;
