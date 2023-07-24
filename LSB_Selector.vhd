----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:11:52 03/13/2019 
-- Design Name: 
-- Module Name:    LSB_Select - Behavioral 
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

entity LSB_Select is
    Port ( DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			  Byte_Sel : in STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end LSB_Select;

architecture Behavioral of LSB_Select is
signal output : STD_LOGIC_VECTOR (31 downto 0);

begin

process(DataIn,Byte_Sel)
begin
	if(Byte_Sel='0') then
		output<=DataIn;
	else
		output<=x"000000FF" AND DataIn;
	end if;
end process;

DataOut<=output after 5 ns;
end Behavioral;

