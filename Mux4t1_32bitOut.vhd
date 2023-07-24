----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:32 04/03/2019 
-- Design Name: 
-- Module Name:    Mux4t1_32bitOut - Behavioral 
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

entity Mux4t1_32bitOut is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           In2 : in  STD_LOGIC_VECTOR (31 downto 0);
           In3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux4t1_32bitOut;

architecture Behavioral of Mux4t1_32bitOut is
signal temp : STD_LOGIC_VECTOR(31 downto 0);
begin

process(Sel,In0,In1,In2,In3)
begin
	if Sel="00" then
		temp<=In0;
	elsif(Sel="01") then
		temp<=In1;
	elsif(Sel="10") then
		temp<=In2;
	else
		temp<=In3;
	end if;
end process;
Output <= temp after 5 ns;
end Behavioral;

