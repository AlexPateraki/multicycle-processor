----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:14 03/07/2019 
-- Design Name: 
-- Module Name:    Mux2t1_32bitOut - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2t1_32bitOut is
	Port (  In0 : in  STD_LOGIC_VECTOR(31 downto 0);
           In1 : in  STD_LOGIC_VECTOR(31 downto 0);
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(31 downto 0));
end Mux2t1_32bitOut;

architecture Behavioral of Mux2t1_32bitOut is
signal temp : STD_LOGIC_VECTOR(31 downto 0);
begin

process(S,In0,In1)
begin
	if S='0' then
		temp<=In0;
	else
		temp<=In1;
	end if;
end process;
Output <= temp after 5 ns;
end Behavioral;

