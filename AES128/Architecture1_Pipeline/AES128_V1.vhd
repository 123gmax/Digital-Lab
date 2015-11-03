----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2015 01:55:45 PM
-- Design Name: 
-- Module Name: AES128_V1 - Behavioral
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

entity AES128_V1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           READY_TO_DECRYPT : out STD_LOGIC;
           WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
           WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end AES128_V1;

architecture Behavioral of AES128_V1 is
    component keyExpansion is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
           DONE : out STD_LOGIC;
           IDLE : out STD_LOGIC;
           MUTATING : out STD_LOGIC;
           expandedKey : out STD_LOGIC_VECTOR (1407 downto 0));
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
    
    component decryptionLoopCore_V1 is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               memorySourceSelector : in STD_LOGIC;
               keySelector : in STD_LOGIC_VECTOR (1 downto 0);
               cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
               WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
               WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component decryptionFinalCore_V1 is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               memorySourceSelector : in STD_LOGIC;
               keySelector : in STD_LOGIC_VECTOR (1 downto 0);
               cipherKey : in STD_LOGIC_VECTOR (127 downto 0);
               WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
               WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    
    signal keyExpansion_EN : STD_LOGIC;
    signal controlUnit_EN : STD_LOGIC;
    
    signal keyExpansion_DONE : STD_LOGIC;
    signal controlUnit_ENABLE : STD_LOGIC;
    
    signal mu1_Out, mu2_Out, mu3_out : STD_LOGIC_VECTOR(31 downto 0);
    signal cipherKey : STD_LOGIC_VECTOR(127 downto 0);
    --The expanded key and aliases to improve readability.
    --Key0 is the original key (same key as was input)
    --Key10 is the last expanded key (first used in decrption / last used in encryption)
    signal expandedKey : STD_LOGIC_VECTOR(1407 downto 0);
    alias key0 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(1407 downto 1280);
    alias key1 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(1279 downto 1152);
    alias key2 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(1151 downto 1024);
    alias key3 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(1023 downto 896);
    alias key4 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(895 downto 768);
    alias key5 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(767 downto 640);
    alias key6 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(639 downto 512);
    alias key7 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(511 downto 384);
    alias key8 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(383 downto 256);
    alias key9 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(255 downto 128);
    alias key10 : STD_LOGIC_VECTOR(127 downto 0) is expandedKey(127 downto 0);
    
    signal addRoundKey_Key10 : STD_LOGIC_VECTOR(31 downto 0);
    signal addRoundKey0_Out : STD_LOGIC_VECTOR(31 downto 0);
    
    --Control Unit output Signals
    signal loadSourceSelector : STD_LOGIC;
    signal addRoundKeySelector1, addRoundKeySelector2 : STD_LOGIC_VECTOR(1 downto 0);
    
    --Decryption loop interconnect signals.
    signal decryptLoop8_Out,
           decryptLoop7_Out,
           decryptLoop6_Out,
           decryptLoop5_Out,
           decryptLoop4_Out,
           decryptLoop3_Out,
           decryptLoop2_Out,
           decryptLoop1_Out,
           decryptLoop0_Out : STD_LOGIC_VECTOR(31 downto 0);
    
    --ZERO signals to connect to the unused ports in some of the memory units
    signal ZERO : STD_LOGIC:= '0';
    signal ZEROES : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    
begin
    ZERO <= '0';
    ZEROES <= (others => '0');
    READY_TO_DECRYPT <= controlUnit_ENABLE;

    mainProcess: process(CLK, RESET)
        variable wordCount : NATURAL range 0 to 2 := 0;
        type STATE_TYPE is (RECEIVE_KEY, EXPAND_KEY, DECRYPT);
        variable state : STATE_TYPE := RECEIVE_KEY; 
    begin
        if RESET = '1' then
            state := RECEIVE_KEY;
            wordCount := 0;
        elsif rising_edge(CLK)then
            keyExpansion_EN <= '0';
            if ENABLE = '1' then
                case state is
                    when RECEIVE_KEY =>
                        if wordCount >= 2 then
                            keyExpansion_EN <= '1';
                            state := EXPAND_KEY;
                        else
                            wordCount := wordCount + 1;
                        end if;
                    when EXPAND_KEY =>
                        if keyExpansion_DONE = '1' then
                            state := DECRYPT;
                        end if;
                    when DECRYPT =>
                        state := DECRYPT;
                    when others =>
                        state := RECEIVE_KEY;
                end case;
            end if;
        end if;
    end process;
    
    enableControlUnitLatch: process(keyExpansion_DONE, RESET)
    begin
        if RESET = '1' then
            controlUnit_Enable <= '0';
        elsif keyExpansion_DONE = '1' then
            controlUnit_Enable <= '1';
        end if;
    end process;
    
    mu1: memoryUnit port map( CLK => CLK,
                              RESET => RESET,
                              SELB => ZERO,
                              wordAIn => WORD_IN,
                              wordBIn => ZEROES,
                              wordOut => mu1_Out);
                              
    mu2: memoryUnit port map( CLK => CLK,
                              RESET => RESET,
                              SELB => ZERO,
                              wordAIn => mu1_Out,
                              wordBIn => ZEROES,
                              wordOut => mu2_Out);
                              
    mu3: memoryUnit port map( CLK => CLK,
                              RESET => RESET,
                              SELB => ZERO,
                              wordAIn => mu2_Out,
                              wordBIn => ZEROES,
                              wordOut => mu3_Out);

    cipherKey <= mu3_Out & mu2_Out & mu1_Out & WORD_IN;                                  

    keyExp: keyExpansion port map( CLK => CLK,
                                   RESET => RESET,
                                   START => keyExpansion_EN,
                                   cipherKey => cipherKey,
                                   DONE => keyExpansion_DONE,
                                   IDLE => open,
                                   MUTATING => open,
                                   expandedKey => expandedKey);
                                   
     ctrlUnit: controlUnit port map( CLK => CLK,
                                     RESET => RESET,
                                     ENABLE => controlUnit_ENABLE,
                                     loadSourceSelector => loadSourceSelector,
                                     addRoundKeySelector1 => addRoundKeySelector1,
                                     addRoundKeySelector2 => addRoundKeySelector2);
     
     --This is the selector for the word that needs to be added in the addRoundKey stage BEFORE the decryption loop.                                
     addRoundKeySelector0: process(key10, addRoundKeySelector1)
      begin
          case addRoundKeySelector1 is
              when "11" => addRoundKey_Key10 <= key10(127 downto 96);
              when "10" => addRoundKey_Key10 <= key10(95 downto 64);
              when "01" => addRoundKey_Key10 <= key10(63 downto 32);
              when "00" => addRoundKey_Key10 <= key10(31 downto 0);
              when others => addRoundKey_Key10 <= (others => '0');
          end case;
      end process;
      
      addRoundKey0: addRoundKey port map( CLK => CLK,
                                          RESET => RESET,
                                          wordIn => WORD_IN,
                                          keyIn => addRoundKey_Key10,
                                          wordOut => addRoundKey0_Out);
                                          
     --BEGIN DECRYPTION LOOP
     --The decryption loop consists of 9 iterations of the steps:
     -- 1) invertShiftRows
     -- 2) invertSubBytes
     -- 3) addRoundKey
     -- 4) invertMixColumns                                 
     decryptLoop0: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key9,
                                                   WORD_IN => addRoundKey0_Out,
                                                   WORD_OUT => decryptLoop0_out);
                                                                                        
     decryptLoop1: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key8,
                                                   WORD_IN => decryptLoop0_out,
                                                   WORD_OUT => decryptLoop1_out);
                                                                                        
     decryptLoop2: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key7,
                                                   WORD_IN => decryptLoop1_out,
                                                   WORD_OUT => decryptLoop2_out);
                                                                                        
     decryptLoop3: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key6,
                                                   WORD_IN => decryptLoop2_out,
                                                   WORD_OUT => decryptLoop3_out);
                                                                                        
     decryptLoop4: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key5,
                                                   WORD_IN => decryptLoop3_out,
                                                   WORD_OUT => decryptLoop4_out);
                                                                                        
     decryptLoop5: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key4,
                                                   WORD_IN => decryptLoop4_out,
                                                   WORD_OUT => decryptLoop5_out);
                                                                                        
     decryptLoop6: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key3,
                                                   WORD_IN => decryptLoop5_out,
                                                   WORD_OUT => decryptLoop6_out);
                                                                                        
     decryptLoop7: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key2,
                                                   WORD_IN => decryptLoop6_out,
                                                   WORD_OUT => decryptLoop7_out);
                                                                                        
     decryptLoop8: decryptionLoopCore_V1 port map( CLK => CLK,
                                                   RESET => RESET,
                                                   memorySourceSelector => loadSourceSelector,
                                                   keySelector => addRoundKeySelector2,
                                                   cipherKey => key1,
                                                   WORD_IN => decryptLoop7_out,
                                                   WORD_OUT => decryptLoop8_out);
                                                   
     decryptFinalStep: decryptionFinalCore_V1 port map( CLK => CLK,
                                                        RESET => RESET,
                                                        memorySourceSelector => loadSourceSelector,
                                                        keySelector => addRoundKeySelector2,
                                                        cipherKey => key0,
                                                        WORD_IN => decryptLoop8_out,
                                                        WORD_OUT => WORD_OUT); 
end Behavioral;
