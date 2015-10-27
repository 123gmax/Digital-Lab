----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 02:47:07 PM
-- Design Name: 
-- Module Name: decryptionLoopCore_V1 - Behavioral
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

entity decryptionLoopCore_V1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           memorySourceSelector : in STD_LOGIC;
           keySelector : in STD_LOGIC_VECTOR (1 downto 0);
           cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
           WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
           WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end decryptionLoopCore_V1;

architecture Behavioral of decryptionLoopCore_V1 is
    component addRoundKey is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               wordIn : in STD_LOGIC_VECTOR (31 downto 0);
               keyIn : in STD_LOGIC_VECTOR (31 downto 0);
               wordOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component memoryUnit is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               SELB : in STD_LOGIC;
               wordAIn : in STD_LOGIC_VECTOR (31 downto 0);
               wordBin : in STD_LOGIC_VECTOR (31 downto 0);
               wordOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component invShiftRows is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               blockIn : in STD_LOGIC_VECTOR (127 downto 0);
               blockOut : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    component invSubByte is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               byteIn : in STD_LOGIC_VECTOR(7 downto 0);
               byteOut : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component invMixColumn is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               wordIn : in STD_LOGIC_VECTOR (31 downto 0);
               wordOut : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal mu0_Out, mu1_Out, mu2_Out, mu3_Out, mu4_Out, mu5_Out : STD_LOGIC_VECTOR(31 downto 0);
    signal invSubBytes_In, invSubBytes_Out, addRoundKey_KeyIn, addRoundKey_Out : STD_LOGIC_VECTOR(31 downto 0);
    signal invShiftRows_In, invShiftRows_Out : STD_LOGIC_VECTOR(127 downto 0);
    signal ZERO_BIT : STD_LOGIC := '0';
    signal ZERO_WORD : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); 
    
begin

    ZERO_BIT <= '0';
    ZERO_WORD <= (others => '0');

    mu0: memoryUnit port map( CLK => CLK,
                              RESET => RESET,
                              SELB => ZERO_BIT,
                              wordAIn => WORD_IN,
                              wordBIn => ZERO_WORD,
                              wordOut => mu0_Out);
                              
    mu1: memoryUnit port map( CLK => CLK,
                              RESET => RESET,
                              SELB => ZERO_BIT,
                              wordAIn => mu0_Out,
                              wordBIn => ZERO_WORD,
                              wordOut => mu1_Out);
                                  
    mu2: memoryUnit port map( CLK => CLK,
                              RESET => RESET,
                              SELB => ZERO_BIT,
                              wordAIn => mu1_Out,
                              wordBIn => ZERO_WORD,
                              wordOut => mu2_Out);
                              
    invShiftRows_In <= mu2_Out & mu1_Out & mu0_Out & WORD_IN;
    
    invShiftRows0: invShiftRows port map( CLK => CLK,
                                          RESET => RESET,
                                          blockIn => invShiftRows_In,
                                          blockOut => invShiftRows_Out);
                                     
     mu3: memoryUnit port map( CLK => CLK,
                               RESET => RESET,
                               SELB => memorySourceSelector,
                               wordAIn => invShiftRows_Out(31 downto 0),
                               wordBIn => invShiftRows_Out(31 downto 0),
                               wordOut => mu3_Out);
                               
     mu4: memoryUnit port map( CLK => CLK,
                               RESET => RESET,
                               SELB => memorySourceSelector,
                               wordAIn => mu3_Out,
                               wordBIn => invShiftRows_Out(63 downto 32),
                               wordOut => mu4_Out);
                               
     mu5: memoryUnit port map( CLK => CLK,
                               RESET => RESET,
                               SELB => memorySourceSelector,
                               wordAIn => mu4_Out,
                               wordBIn => invShiftRows_Out(95 downto 64),
                               wordOut => mu5_Out);
                               
     invSubBytes_In <= invShiftRows_Out(127 downto 96) when (memorySourceSelector = '1')
                       else mu5_Out;

     invSubBytes0: invSubByte port map( CLK => CLK,
                                        RESET => RESET,
                                        byteIn => invSubBytes_In(7 downto 0),
                                        byteOut => invSubBytes_Out(7 downto 0));
                                      
     invSubBytes1: invSubByte port map( CLK => CLK,
                                        RESET => RESET,
                                        byteIn => invSubBytes_In(15 downto 8),
                                        byteOut => invSubBytes_Out(15 downto 8));
   
     invSubBytes2: invSubByte port map( CLK => CLK,
                                        RESET => RESET,
                                        byteIn => invSubBytes_In(23 downto 16),
                                        byteOut => invSubBytes_Out(23 downto 16));
   
     invSubBytes3: invSubByte port map( CLK => CLK,
                                        RESET => RESET,
                                        byteIn => invSubBytes_In(31 downto 24),
                                        byteOut => invSubBytes_Out(31 downto 24));
                                       
     addRoundKeySelector: process(cipherKey, keySelector)
     begin
         case keySelector is
             when "11" => addRoundKey_KeyIn <= cipherKey(127 downto 96);
             when "10" => addRoundKey_KeyIn <= cipherKey(95 downto 64);
             when "01" => addRoundKey_KeyIn <= cipherKey(63 downto 32);
             when "00" => addRoundKey_KeyIn <= cipherKey(31 downto 0);
             when others => addRoundKey_KeyIn <= (others => '0');
         end case;
     end process;
    
     addRoundKey0: addRoundKey port map( CLK => CLK,
                                         RESET => RESET,
                                         wordIn => invSubBytes_Out,
                                         keyIn => addRoundKey_KeyIn,
                                         wordOut => addRoundKey_Out);
                                       
     invMixColumn0: invMixColumn port map( CLK => CLK,
                                           RESET => RESET,
                                           wordIn => addRoundKey_Out,
                                           wordOut => WORD_OUT);
end Behavioral;
