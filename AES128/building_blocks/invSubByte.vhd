----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2015 02:54:47 PM
-- Design Name: 
-- Module Name: invSubByte - Behavioral
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

entity invSubByte is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           byteIn : in STD_LOGIC_VECTOR(7 downto 0);
           byteOut : out STD_LOGIC_VECTOR(7 downto 0));
end invSubByte;

architecture Behavioral of invSubByte is

begin
    process(CLK, RESET, byteIn)
    begin
        if RESET = '1' then
            byteOut <= (others => '0');
        elsif rising_edge(CLK) then
            case byteIn is
                when x"00" => byteOut <= x"52";
                when x"01" => byteOut <= x"09";
                when x"02" => byteOut <= x"6A";
                when x"03" => byteOut <= x"D5";
                when x"04" => byteOut <= x"30";
                when x"05" => byteOut <= x"36";
                when x"06" => byteOut <= x"A5";
                when x"07" => byteOut <= x"38";
                when x"08" => byteOut <= x"BF";
                when x"09" => byteOut <= x"40";
                when x"0A" => byteOut <= x"A3";
                when x"0B" => byteOut <= x"9E";
                when x"0C" => byteOut <= x"81";
                when x"0D" => byteOut <= x"F3";
                when x"0E" => byteOut <= x"D7";
                when x"0F" => byteOut <= x"FB";
                when x"10" => byteOut <= x"7C";
                when x"11" => byteOut <= x"E3";
                when x"12" => byteOut <= x"39";
                when x"13" => byteOut <= x"82";
                when x"14" => byteOut <= x"9B";
                when x"15" => byteOut <= x"2F";
                when x"16" => byteOut <= x"FF";
                when x"17" => byteOut <= x"87";
                when x"18" => byteOut <= x"34";
                when x"19" => byteOut <= x"8E";
                when x"1A" => byteOut <= x"43";
                when x"1B" => byteOut <= x"44";
                when x"1C" => byteOut <= x"C4";
                when x"1D" => byteOut <= x"DE";
                when x"1E" => byteOut <= x"E9";
                when x"1F" => byteOut <= x"CB";
                when x"20" => byteOut <= x"54";
                when x"21" => byteOut <= x"7B";
                when x"22" => byteOut <= x"94";
                when x"23" => byteOut <= x"32";
                when x"24" => byteOut <= x"A6";
                when x"25" => byteOut <= x"C2";
                when x"26" => byteOut <= x"23";
                when x"27" => byteOut <= x"3D";
                when x"28" => byteOut <= x"EE";
                when x"29" => byteOut <= x"4C";
                when x"2A" => byteOut <= x"95";
                when x"2B" => byteOut <= x"0B";
                when x"2C" => byteOut <= x"42";
                when x"2D" => byteOut <= x"FA";
                when x"2E" => byteOut <= x"C3";
                when x"2F" => byteOut <= x"4E";
                when x"30" => byteOut <= x"08";
                when x"31" => byteOut <= x"2E";
                when x"32" => byteOut <= x"A1";
                when x"33" => byteOut <= x"66";
                when x"34" => byteOut <= x"28";
                when x"35" => byteOut <= x"D9";
                when x"36" => byteOut <= x"24";
                when x"37" => byteOut <= x"B2";
                when x"38" => byteOut <= x"76";
                when x"39" => byteOut <= x"5B";
                when x"3A" => byteOut <= x"A2";
                when x"3B" => byteOut <= x"49";
                when x"3C" => byteOut <= x"6D";
                when x"3D" => byteOut <= x"8B";
                when x"3E" => byteOut <= x"D1";
                when x"3F" => byteOut <= x"25";
                when x"40" => byteOut <= x"72";
                when x"41" => byteOut <= x"F8";
                when x"42" => byteOut <= x"F6";
                when x"43" => byteOut <= x"64";
                when x"44" => byteOut <= x"86";
                when x"45" => byteOut <= x"68";
                when x"46" => byteOut <= x"98";
                when x"47" => byteOut <= x"16";
                when x"48" => byteOut <= x"D4";
                when x"49" => byteOut <= x"A4";
                when x"4A" => byteOut <= x"5C";
                when x"4B" => byteOut <= x"CC";
                when x"4C" => byteOut <= x"5D";
                when x"4D" => byteOut <= x"65";
                when x"4E" => byteOut <= x"B6";
                when x"4F" => byteOut <= x"92";
                when x"50" => byteOut <= x"6C";
                when x"51" => byteOut <= x"70";
                when x"52" => byteOut <= x"48";
                when x"53" => byteOut <= x"50";
                when x"54" => byteOut <= x"FD";
                when x"55" => byteOut <= x"ED";
                when x"56" => byteOut <= x"B9";
                when x"57" => byteOut <= x"DA";
                when x"58" => byteOut <= x"5E";
                when x"59" => byteOut <= x"15";
                when x"5A" => byteOut <= x"46";
                when x"5B" => byteOut <= x"57";
                when x"5C" => byteOut <= x"A7";
                when x"5D" => byteOut <= x"8D";
                when x"5E" => byteOut <= x"9D";
                when x"5F" => byteOut <= x"84";
                when x"60" => byteOut <= x"90";
                when x"61" => byteOut <= x"D8";
                when x"62" => byteOut <= x"AB";
                when x"63" => byteOut <= x"00";
                when x"64" => byteOut <= x"8C";
                when x"65" => byteOut <= x"BC";
                when x"66" => byteOut <= x"D3";
                when x"67" => byteOut <= x"0A";
                when x"68" => byteOut <= x"F7";
                when x"69" => byteOut <= x"E4";
                when x"6A" => byteOut <= x"58";
                when x"6B" => byteOut <= x"05";
                when x"6C" => byteOut <= x"B8";
                when x"6D" => byteOut <= x"B3";
                when x"6E" => byteOut <= x"45";
                when x"6F" => byteOut <= x"06";
                when x"70" => byteOut <= x"D0";
                when x"71" => byteOut <= x"2C";
                when x"72" => byteOut <= x"1E";
                when x"73" => byteOut <= x"8F";
                when x"74" => byteOut <= x"CA";
                when x"75" => byteOut <= x"3F";
                when x"76" => byteOut <= x"0F";
                when x"77" => byteOut <= x"02";
                when x"78" => byteOut <= x"C1";
                when x"79" => byteOut <= x"AF";
                when x"7A" => byteOut <= x"BD";
                when x"7B" => byteOut <= x"03";
                when x"7C" => byteOut <= x"01";
                when x"7D" => byteOut <= x"13";
                when x"7E" => byteOut <= x"8A";
                when x"7F" => byteOut <= x"6B";
                when x"80" => byteOut <= x"3A";
                when x"81" => byteOut <= x"91";
                when x"82" => byteOut <= x"11";
                when x"83" => byteOut <= x"41";
                when x"84" => byteOut <= x"4F";
                when x"85" => byteOut <= x"67";
                when x"86" => byteOut <= x"DC";
                when x"87" => byteOut <= x"EA";
                when x"88" => byteOut <= x"97";
                when x"89" => byteOut <= x"F2";
                when x"8A" => byteOut <= x"CF";
                when x"8B" => byteOut <= x"CE";
                when x"8C" => byteOut <= x"F0";
                when x"8D" => byteOut <= x"B4";
                when x"8E" => byteOut <= x"E6";
                when x"8F" => byteOut <= x"73";
                when x"90" => byteOut <= x"96";
                when x"91" => byteOut <= x"AC";
                when x"92" => byteOut <= x"74";
                when x"93" => byteOut <= x"22";
                when x"94" => byteOut <= x"E7";
                when x"95" => byteOut <= x"AD";
                when x"96" => byteOut <= x"35";
                when x"97" => byteOut <= x"85";
                when x"98" => byteOut <= x"E2";
                when x"99" => byteOut <= x"F9";
                when x"9A" => byteOut <= x"37";
                when x"9B" => byteOut <= x"E8";
                when x"9C" => byteOut <= x"1C";
                when x"9D" => byteOut <= x"75";
                when x"9E" => byteOut <= x"DF";
                when x"9F" => byteOut <= x"6E";
                when x"A0" => byteOut <= x"47";
                when x"A1" => byteOut <= x"F1";
                when x"A2" => byteOut <= x"1A";
                when x"A3" => byteOut <= x"71";
                when x"A4" => byteOut <= x"1D";
                when x"A5" => byteOut <= x"29";
                when x"A6" => byteOut <= x"C5";
                when x"A7" => byteOut <= x"89";
                when x"A8" => byteOut <= x"6F";
                when x"A9" => byteOut <= x"B7";
                when x"AA" => byteOut <= x"62";
                when x"AB" => byteOut <= x"0E";
                when x"AC" => byteOut <= x"AA";
                when x"AD" => byteOut <= x"18";
                when x"AE" => byteOut <= x"BE";
                when x"AF" => byteOut <= x"1B";
                when x"B0" => byteOut <= x"FC";
                when x"B1" => byteOut <= x"56";
                when x"B2" => byteOut <= x"3E";
                when x"B3" => byteOut <= x"4B";
                when x"B4" => byteOut <= x"C6";
                when x"B5" => byteOut <= x"D2";
                when x"B6" => byteOut <= x"79";
                when x"B7" => byteOut <= x"20";
                when x"B8" => byteOut <= x"9A";
                when x"B9" => byteOut <= x"DB";
                when x"BA" => byteOut <= x"C0";
                when x"BB" => byteOut <= x"FE";
                when x"BC" => byteOut <= x"78";
                when x"BD" => byteOut <= x"CD";
                when x"BE" => byteOut <= x"5A";
                when x"BF" => byteOut <= x"F4";
                when x"C0" => byteOut <= x"1F";
                when x"C1" => byteOut <= x"DD";
                when x"C2" => byteOut <= x"A8";
                when x"C3" => byteOut <= x"33";
                when x"C4" => byteOut <= x"88";
                when x"C5" => byteOut <= x"07";
                when x"C6" => byteOut <= x"C7";
                when x"C7" => byteOut <= x"31";
                when x"C8" => byteOut <= x"B1";
                when x"C9" => byteOut <= x"12";
                when x"CA" => byteOut <= x"10";
                when x"CB" => byteOut <= x"59";
                when x"CC" => byteOut <= x"27";
                when x"CD" => byteOut <= x"80";
                when x"CE" => byteOut <= x"EC";
                when x"CF" => byteOut <= x"5F";
                when x"D0" => byteOut <= x"60";
                when x"D1" => byteOut <= x"51";
                when x"D2" => byteOut <= x"7F";
                when x"D3" => byteOut <= x"A9";
                when x"D4" => byteOut <= x"19";
                when x"D5" => byteOut <= x"B5";
                when x"D6" => byteOut <= x"4A";
                when x"D7" => byteOut <= x"0D";
                when x"D8" => byteOut <= x"2D";
                when x"D9" => byteOut <= x"E5";
                when x"DA" => byteOut <= x"7A";
                when x"DB" => byteOut <= x"9F";
                when x"DC" => byteOut <= x"93";
                when x"DD" => byteOut <= x"C9";
                when x"DE" => byteOut <= x"9C";
                when x"DF" => byteOut <= x"EF";
                when x"E0" => byteOut <= x"A0";
                when x"E1" => byteOut <= x"E0";
                when x"E2" => byteOut <= x"3B";
                when x"E3" => byteOut <= x"4D";
                when x"E4" => byteOut <= x"AE";
                when x"E5" => byteOut <= x"2A";
                when x"E6" => byteOut <= x"F5";
                when x"E7" => byteOut <= x"B0";
                when x"E8" => byteOut <= x"C8";
                when x"E9" => byteOut <= x"EB";
                when x"EA" => byteOut <= x"BB";
                when x"EB" => byteOut <= x"3C";
                when x"EC" => byteOut <= x"83";
                when x"ED" => byteOut <= x"53";
                when x"EE" => byteOut <= x"99";
                when x"EF" => byteOut <= x"61";
                when x"F0" => byteOut <= x"17";
                when x"F1" => byteOut <= x"2B";
                when x"F2" => byteOut <= x"04";
                when x"F3" => byteOut <= x"7E";
                when x"F4" => byteOut <= x"BA";
                when x"F5" => byteOut <= x"77";
                when x"F6" => byteOut <= x"D6";
                when x"F7" => byteOut <= x"26";
                when x"F8" => byteOut <= x"E1";
                when x"F9" => byteOut <= x"69";
                when x"FA" => byteOut <= x"14";
                when x"FB" => byteOut <= x"63";
                when x"FC" => byteOut <= x"55";
                when x"FD" => byteOut <= x"21";
                when x"FE" => byteOut <= x"0C";
                when x"FF" => byteOut <= x"7D";
                when others => byteOut <= x"00";
            end case;
        end if;
    end process;
end Behavioral;
