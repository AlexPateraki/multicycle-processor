--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:37:05 04/02/2019
-- Design Name:   
-- Module Name:   /home/mitsos/Documents/Semester4/HPY312/Lab4/Lab4/MultiCycleProcessorTopLevel_Test.vhd
-- Project Name:  Lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MultiCycleProcessorTopLevel
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MultiCycleProcessorTopLevel_Test IS
END MultiCycleProcessorTopLevel_Test;
 
ARCHITECTURE behavior OF MultiCycleProcessorTopLevel_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MultiCycleProcessorTopLevel
    PORT(
         Reset : IN  std_logic;
         Clock : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clock : std_logic := '0';

   -- Clock period definitions
   constant Clock_period : time := 30 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MultiCycleProcessorTopLevel PORT MAP (
          Reset => Reset,
          Clock => Clock
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Reset<='1';
		wait for Clock_period;
		wait for 20 ns;
		Reset<='0';
		wait for Clock_period;

      wait for Clock_period*100;

      -- insert stimulus here 

      wait;
   end process;

END;
