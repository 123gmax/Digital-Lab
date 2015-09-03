library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_4_bit is
    Port(   CLK         : in STD_LOGIC;
            direction   : in STD_LOGIC;
            auto        : in STD_LOGIC;
            tick        : in STD_LOGIC;
            load        : in STD_LOGIC;
            load_input  : in STD_LOGIC_VECTOR(3 downto 0);
            output      : out STD_LOGIC_VECTOR(3 downto 0) := (others => '0')
        );
end counter_4_bit;

architecture Behavioral of counter_4_bit is
    signal clk_divider : unsigned(31 downto 0) := (others => '0');
    signal clk_1s : STD_LOGIC := '0';
    signal count : unsigned(3 downto 0) := (others => '0');
begin
    process(CLK) begin
        if (rising_edge(CLK)) then
            clk_divider <= clk_divider + 1;
--            if(clk_divider >= 1) then -- Use this clock divider for simulation purposes
              if(clk_divider >= 50000000) then -- The new clock's frequency will be 1s. Therefore: two 0.5s H/L periods.
                clk_1s <= NOT clk_1s;
                clk_divider <= (others => '0');
            end if;
        end if;
    end process;

    process(clk_1s, load, tick) begin
        if(rising_edge(clk_1s) AND (auto = '1')) then
            if(direction = '1') then
                count <= count + 1;
            else
                count <= count - 1;
            end if;
        end if;
        if(rising_edge(tick) AND (auto = '0')) then
            if(direction = '1') then
                count <= count + 1;
            else
                count <= count - 1;
            end if;
        end if;
        if(rising_edge(load)) then
            count <= unsigned(load_input);
        end if;
    end process;
    output <= std_logic_vector(count);
end Behavioral;