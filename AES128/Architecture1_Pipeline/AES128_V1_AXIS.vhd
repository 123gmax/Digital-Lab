------------------------------------------------------------------------------
-- hw_acc - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          hw_acc
-- Version:           1.00.a
-- Description:       Example Axi Streaming core (VHDL).
-- Date:              Mon Sep 15 15:41:21 2014 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------------
--
--
-- Definition of Ports
-- ACLK              : Synchronous clock
-- ARESETN           : System reset, active low
-- S_AXIS_TREADY  : Ready to accept data in
-- S_AXIS_TDATA   :  Data in 
-- S_AXIS_TLAST   : Optional data in qualifier
-- S_AXIS_TVALID  : Data in is valid
-- M_AXIS_TVALID  :  Data out is valid
-- M_AXIS_TDATA   : Data Out
-- M_AXIS_TLAST   : Optional data out qualifier
-- M_AXIS_TREADY  : Connected slave device is ready to accept data out
--
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Entity Section
------------------------------------------------------------------------------

entity myip_v1_0 is
	port 
	(
		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add or delete. 
		ACLK	: in	std_logic;
		ARESETN	: in	std_logic;
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(31 downto 0);
		S_AXIS_TLAST	: in	std_logic;
		S_AXIS_TVALID	: in	std_logic;
		M_AXIS_TVALID	: out	std_logic;
		M_AXIS_TDATA	: out	std_logic_vector(31 downto 0);
		M_AXIS_TLAST	: out	std_logic;
		M_AXIS_TREADY	: in	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);

attribute SIGIS : string; 
attribute SIGIS of ACLK : signal is "Clk"; 

end myip_v1_0;

------------------------------------------------------------------------------
-- Architecture Section
------------------------------------------------------------------------------

-- In this section, we povide an example implementation of ENTITY hw_acc
-- that does the following:
--
-- 1. Read all inputs
-- 2. Add each input to the contents of register 'sum' which
--    acts as an accumulator
-- 3. After all the inputs have been read, write out the
--    content of 'sum' into the output stream NUMBER_OF_OUTPUT_WORDS times
--
-- You will need to modify this example or implement a new architecture for
-- ENTITY hw_acc to implement your coprocessor

architecture EXAMPLE of myip_v1_0 is

   -- Total number of input data.
   constant KEY_LENGTH  : natural := 4;
   constant PIPELINE_LENGTH : natural := 69;

   type STATE_TYPE is (IDLE, READ_KEY, EXPAND_KEY, STALL, DECRYPT);

   signal state        : STATE_TYPE;

   -- Counters to store the number inputs read & outputs written
   signal nr_of_reads  : natural range 0 to KEY_LENGTH - 1;

    
    component AES128_V1 is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               ENABLE : in STD_LOGIC;
               READY_TO_DECRYPT : out STD_LOGIC;
               WORD_IN : in STD_LOGIC_VECTOR (31 downto 0);
               WORD_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal ENABLE : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal READY_TO_DECRYPT : STD_LOGIC := '0';
    
    signal decrypt_cnt : natural range 0 to PIPELINE_LENGTH - 1;
    signal stall_cycles : natural range 0 to 2 := 2;

begin
   -- CAUTION:
   -- The sequence in which data are read in and written out should be
   -- consistent with the sequence they are written and read in the
   -- driver's hw_acc.c file
   
   RESET <= not ARESETN; --AXIS reset is active low
   M_AXIS_TLAST <= '0'; --Unused
   
   aes: AES128_V1 port map( CLK => ACLK,
                            RESET => RESET,
                            ENABLE =>  ENABLE,
                            READY_TO_DECRYPT => READY_TO_DECRYPT,
                            WORD_IN => S_AXIS_TDATA,
                            WORD_OUT => M_AXIS_TDATA);
                            
    --Pro: The pipeline will not be corrupted if a clock cycle is skipped since it is active only when read and write are available.
    --Con: The pipeline must be manually flushed.
    ENABLE <= '0' when (state = IDLE) else
              '1' when (state = EXPAND_KEY or state = STALL) else
              S_AXIS_TVALID;
    
    S_AXIS_TREADY <= '1' when (state = READ_KEY or state = DECRYPT) else
                     '0';

   The_SW_accelerator : process (ACLK) is
   begin  -- process The_SW_accelerator
   
    M_AXIS_TVALID <= '0'; --Default case: output data is not valid
    
    if ACLK'event and ACLK = '1' then     -- Rising clock edge
      if ARESETN = '0' then               -- Synchronous reset (active low)
        -- CAUTION: make sure your reset polarity is consistent with the
        -- system reset polarity
        state        <= IDLE;
        nr_of_reads <= KEY_LENGTH - 1;
      else
        case state is
          when IDLE =>
            if (S_AXIS_TVALID = '1') then --Begin reading key
                state       <= READ_KEY;
                nr_of_reads <= KEY_LENGTH - 1;
            end if;
          when READ_KEY => --Read the 4 words that comprise the key
            if (S_AXIS_TVALID = '1') then
                if (nr_of_reads = 0) then
                    state <= EXPAND_KEY;
                else
                    nr_of_reads <= nr_of_reads - 1;
                end if;
            end if;
          when EXPAND_KEY => --Cycle until key expansion is done.
            if (READY_TO_DECRYPT = '1') then
                state <= STALL;
                stall_cycles <= 2;
            end if;
          when STALL => --Wait for one block cycle.
            if (stall_cycles = 0) then
                state <= DECRYPT;
                decrypt_cnt <= PIPELINE_LENGTH - 1;
            else
                stall_cycles <= stall_cycles - 1;
            end if;
          when DECRYPT =>
            if (S_AXIS_TVALID = '1') then --Output is only valid if something was pushed.
                if (decrypt_cnt = 0) then --The first decrypted word has exited the pipeline and everything following should be valid data.
                    M_AXIS_TVALID <= '1'; --The 70th rising edge AFTER the key was input marks the first valid output.
                                          --    This signal is asserted at the 69th rising edge, to be read one cycle after.
                else
                    decrypt_cnt <= decrypt_cnt - 1;
                end if;
            end if;
        end case;
      end if;
    end if;
   end process The_SW_accelerator;
end architecture EXAMPLE;
