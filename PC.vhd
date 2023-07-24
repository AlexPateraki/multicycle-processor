----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:52 03/04/2019 
-- Design Name: 
-- Module Name:    PC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_Module is
    Port ( PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Addr_In : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end PC_Module;

architecture Behavioral of PC_Module is
signal temp : STD_LOGIC_VECTOR (31 downto 0);
begin
Sync_process: process(Clock)
begin
	if rising_edge(Clock) then
		if(Reset='1') then
			temp<=x"00000000";
		elsif(PC_LdEn='1') then
			temp<=Addr_In;
		end if;
	end if;
end process;
PC<=temp after 5 ns;
end Behavioral;

