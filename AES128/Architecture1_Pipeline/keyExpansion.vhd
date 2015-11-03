----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2015 03:25:04 PM
-- Design Name: 
-- Module Name: keyExpansion - Behavioral
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

entity keyExpansion is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
           DONE : out STD_LOGIC;
           IDLE : out STD_LOGIC;
           MUTATING : out STD_LOGIC;
           expandedKey : out STD_LOGIC_VECTOR (1407 downto 0));
           
    function rCon (expansionRound : in natural)
    return STD_LOGIC_VECTOR is
    begin
        case expansionRound is
            when 0 => return x"8D";
            when 1 => return x"01";
            when 2 => return x"02";
            when 3 => return x"04";
            when 4 => return x"08";
            when 5 => return x"10";
            when 6 => return x"20";
            when 7 => return x"40";
            when 8 => return x"80";
            when 9 => return x"1B";
            when 10 => return x"36";
            when others =>  return x"00";
        end case;
    end rCon;
    
    function subByte(signal byteIn : in STD_LOGIC_VECTOR(7 downto 0))
    return STD_LOGIC_VECTOR is
    begin
        case byteIn is
            when x"00" => return x"63";
            when x"01" => return x"7C";
            when x"02" => return x"77";
            when x"03" => return x"7B";
            when x"04" => return x"F2";
            when x"05" => return x"6B";
            when x"06" => return x"6F";
            when x"07" => return x"C5";
            when x"08" => return x"30";
            when x"09" => return x"01";
            when x"0A" => return x"67";
            when x"0B" => return x"2B";
            when x"0C" => return x"FE";
            when x"0D" => return x"D7";
            when x"0E" => return x"AB";
            when x"0F" => return x"76";
            when x"10" => return x"CA";
            when x"11" => return x"82";
            when x"12" => return x"C9";
            when x"13" => return x"7D";
            when x"14" => return x"FA";
            when x"15" => return x"59";
            when x"16" => return x"47";
            when x"17" => return x"F0";
            when x"18" => return x"AD";
            when x"19" => return x"D4";
            when x"1A" => return x"A2";
            when x"1B" => return x"AF";
            when x"1C" => return x"9C";
            when x"1D" => return x"A4";
            when x"1E" => return x"72";
            when x"1F" => return x"C0";
            when x"20" => return x"B7";
            when x"21" => return x"FD";
            when x"22" => return x"93";
            when x"23" => return x"26";
            when x"24" => return x"36";
            when x"25" => return x"3F";
            when x"26" => return x"F7";
            when x"27" => return x"CC";
            when x"28" => return x"34";
            when x"29" => return x"A5";
            when x"2A" => return x"E5";
            when x"2B" => return x"F1";
            when x"2C" => return x"71";
            when x"2D" => return x"D8";
            when x"2E" => return x"31";
            when x"2F" => return x"15";
            when x"30" => return x"04";
            when x"31" => return x"C7";
            when x"32" => return x"23";
            when x"33" => return x"C3";
            when x"34" => return x"18";
            when x"35" => return x"96";
            when x"36" => return x"05";
            when x"37" => return x"9A";
            when x"38" => return x"07";
            when x"39" => return x"12";
            when x"3A" => return x"80";
            when x"3B" => return x"E2";
            when x"3C" => return x"EB";
            when x"3D" => return x"27";
            when x"3E" => return x"B2";
            when x"3F" => return x"75";
            when x"40" => return x"09";
            when x"41" => return x"83";
            when x"42" => return x"2C";
            when x"43" => return x"1A";
            when x"44" => return x"1B";
            when x"45" => return x"6E";
            when x"46" => return x"5A";
            when x"47" => return x"A0";
            when x"48" => return x"52";
            when x"49" => return x"3B";
            when x"4A" => return x"D6";
            when x"4B" => return x"B3";
            when x"4C" => return x"29";
            when x"4D" => return x"E3";
            when x"4E" => return x"2F";
            when x"4F" => return x"84";
            when x"50" => return x"53";
            when x"51" => return x"D1";
            when x"52" => return x"00";
            when x"53" => return x"ED";
            when x"54" => return x"20";
            when x"55" => return x"FC";
            when x"56" => return x"B1";
            when x"57" => return x"5B";
            when x"58" => return x"6A";
            when x"59" => return x"CB";
            when x"5A" => return x"BE";
            when x"5B" => return x"39";
            when x"5C" => return x"4A";
            when x"5D" => return x"4C";
            when x"5E" => return x"58";
            when x"5F" => return x"CF";
            when x"60" => return x"D0";
            when x"61" => return x"EF";
            when x"62" => return x"AA";
            when x"63" => return x"FB";
            when x"64" => return x"43";
            when x"65" => return x"4D";
            when x"66" => return x"33";
            when x"67" => return x"85";
            when x"68" => return x"45";
            when x"69" => return x"F9";
            when x"6A" => return x"02";
            when x"6B" => return x"7F";
            when x"6C" => return x"50";
            when x"6D" => return x"3C";
            when x"6E" => return x"9F";
            when x"6F" => return x"A8";
            when x"70" => return x"51";
            when x"71" => return x"A3";
            when x"72" => return x"40";
            when x"73" => return x"8F";
            when x"74" => return x"92";
            when x"75" => return x"9D";
            when x"76" => return x"38";
            when x"77" => return x"F5";
            when x"78" => return x"BC";
            when x"79" => return x"B6";
            when x"7A" => return x"DA";
            when x"7B" => return x"21";
            when x"7C" => return x"10";
            when x"7D" => return x"FF";
            when x"7E" => return x"F3";
            when x"7F" => return x"D2";
            when x"80" => return x"CD";
            when x"81" => return x"0C";
            when x"82" => return x"13";
            when x"83" => return x"EC";
            when x"84" => return x"5F";
            when x"85" => return x"97";
            when x"86" => return x"44";
            when x"87" => return x"17";
            when x"88" => return x"C4";
            when x"89" => return x"A7";
            when x"8A" => return x"7E";
            when x"8B" => return x"3D";
            when x"8C" => return x"64";
            when x"8D" => return x"5D";
            when x"8E" => return x"19";
            when x"8F" => return x"73";
            when x"90" => return x"60";
            when x"91" => return x"81";
            when x"92" => return x"4F";
            when x"93" => return x"DC";
            when x"94" => return x"22";
            when x"95" => return x"2A";
            when x"96" => return x"90";
            when x"97" => return x"88";
            when x"98" => return x"46";
            when x"99" => return x"EE";
            when x"9A" => return x"B8";
            when x"9B" => return x"14";
            when x"9C" => return x"DE";
            when x"9D" => return x"5E";
            when x"9E" => return x"0B";
            when x"9F" => return x"DB";
            when x"A0" => return x"E0";
            when x"A1" => return x"32";
            when x"A2" => return x"3A";
            when x"A3" => return x"0A";
            when x"A4" => return x"49";
            when x"A5" => return x"06";
            when x"A6" => return x"24";
            when x"A7" => return x"5C";
            when x"A8" => return x"C2";
            when x"A9" => return x"D3";
            when x"AA" => return x"AC";
            when x"AB" => return x"62";
            when x"AC" => return x"91";
            when x"AD" => return x"95";
            when x"AE" => return x"E4";
            when x"AF" => return x"79";
            when x"B0" => return x"E7";
            when x"B1" => return x"C8";
            when x"B2" => return x"37";
            when x"B3" => return x"6D";
            when x"B4" => return x"8D";
            when x"B5" => return x"D5";
            when x"B6" => return x"4E";
            when x"B7" => return x"A9";
            when x"B8" => return x"6C";
            when x"B9" => return x"56";
            when x"BA" => return x"F4";
            when x"BB" => return x"EA";
            when x"BC" => return x"65";
            when x"BD" => return x"7A";
            when x"BE" => return x"AE";
            when x"BF" => return x"08";
            when x"C0" => return x"BA";
            when x"C1" => return x"78";
            when x"C2" => return x"25";
            when x"C3" => return x"2E";
            when x"C4" => return x"1C";
            when x"C5" => return x"A6";
            when x"C6" => return x"B4";
            when x"C7" => return x"C6";
            when x"C8" => return x"E8";
            when x"C9" => return x"DD";
            when x"CA" => return x"74";
            when x"CB" => return x"1F";
            when x"CC" => return x"4B";
            when x"CD" => return x"BD";
            when x"CE" => return x"8B";
            when x"CF" => return x"8A";
            when x"D0" => return x"70";
            when x"D1" => return x"3E";
            when x"D2" => return x"B5";
            when x"D3" => return x"66";
            when x"D4" => return x"48";
            when x"D5" => return x"03";
            when x"D6" => return x"F6";
            when x"D7" => return x"0E";
            when x"D8" => return x"61";
            when x"D9" => return x"35";
            when x"DA" => return x"57";
            when x"DB" => return x"B9";
            when x"DC" => return x"86";
            when x"DD" => return x"C1";
            when x"DE" => return x"1D";
            when x"DF" => return x"9E";
            when x"E0" => return x"E1";
            when x"E1" => return x"F8";
            when x"E2" => return x"98";
            when x"E3" => return x"11";
            when x"E4" => return x"69";
            when x"E5" => return x"D9";
            when x"E6" => return x"8E";
            when x"E7" => return x"94";
            when x"E8" => return x"9B";
            when x"E9" => return x"1E";
            when x"EA" => return x"87";
            when x"EB" => return x"E9";
            when x"EC" => return x"CE";
            when x"ED" => return x"55";
            when x"EE" => return x"28";
            when x"EF" => return x"DF";
            when x"F0" => return x"8C";
            when x"F1" => return x"A1";
            when x"F2" => return x"89";
            when x"F3" => return x"0D";
            when x"F4" => return x"BF";
            when x"F5" => return x"E6";
            when x"F6" => return x"42";
            when x"F7" => return x"68";
            when x"F8" => return x"41";
            when x"F9" => return x"99";
            when x"FA" => return x"2D";
            when x"FB" => return x"0F";
            when x"FC" => return x"B0";
            when x"FD" => return x"54";
            when x"FE" => return x"BB";
            when x"FF" => return x"16";
            when others => return x"00";
        end case;
    end subByte;
    
    function subWord (signal wordIn : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is
        variable B3, B2, B1, B0 : STD_LOGIC_VECTOR(7 downto 0);
    begin
        B3 := subByte(wordIn(31 downto 24));
        B2 := subByte(wordIn(23 downto 16));
        B1 := subByte(wordIn(15 downto 8));
        B0 := subByte(wordIn(7 downto 0));
        return B3 & B2 & B1 & B0;
    end subWord;
    
    function rotateWord (signal wordIn : STD_LOGIC_VECTOR(31 downto 0)) return STD_LOGIC_VECTOR is
    begin
        return wordIn(23 downto 0) & wordIn(31 downto 24);
    end rotateWord;
end keyExpansion;

architecture Behavioral of keyExpansion is
    type STATE_TYPE is (generatorIdle, getWord, mutateRotWord, mutateSubWord, mutateXorRcon, xorWord, generatorDone);
    signal state, nextState : STATE_TYPE := generatorIdle;
    signal expandedKeyTemp : STD_LOGIC_VECTOR(1407 downto 0);
    signal tempWord : STD_LOGIC_VECTOR(31 downto 0);
begin
    process(CLK, RESET, START)
        variable expansionRound : natural range 0 to 10;
        variable nextByte : natural range 0 to 176;
    begin
        DONE <= '0';
        IDLE <= '0';
        MUTATING <= '0';
        if RESET = '1' then
            nextState <= generatorIdle;
        elsif rising_edge(CLK) then
            case state is
                when generatorIdle =>
                    IDLE <= '1';
                    if (START = '1') then
                        expandedKeyTemp(1407 downto 1280) <= cipherKey;
                        expansionRound := 1;
                        nextByte := 16;
                        nextState <= getWord;
                    else
                        nextState <= generatorIdle;
                    end if;
                when getWord =>
                    tempWord <= expandedKeyTemp(1407 - (nextByte-4)*8 downto 1407 - nextByte*8 + 1);
                    nextState <= mutateRotWord;
                when mutateRotWord =>
                    nextState <= xorWord;
                    if (nextByte mod 16 = 0) then
                        MUTATING <= '1';
                        tempWord <= rotateWord(tempWord);
                        nextState <= mutateSubWord;
                    end if;
                when mutateSubWord =>
                    tempWord <= subWord(tempWord);
                    nextState <= mutateXorRcon;
                when mutateXorRcon =>
                    tempWord(31 downto 24) <= tempWord(31 downto 24) XOR rCon(expansionRound);
                    expansionRound := expansionRound + 1;
                    nextState <= xorWord;
                when xorWord =>
                    expandedKeyTemp(1407 - nextByte*8 downto 1407 - (nextByte + 4)*8 + 1) <= tempWord XOR expandedKeyTemp(1407 - (nextByte - 16)*8 downto 1407 - (nextByte - 12)*8 + 1);
                    nextByte := nextByte + 4;
                    if (nextByte >= 176) then
                        DONE <= '1';
                        nextState <= generatorDone;
                    else
                        nextState <= getWord;
                    end if;
                when generatorDone =>
                    nextState <= generatorDone;
                when others =>
                    nextState <= generatorIdle;
            end case;
        end if;
    end process;
    state <= nextState;
    expandedKey <= expandedKeyTemp;
end Behavioral;
