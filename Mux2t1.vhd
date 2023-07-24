----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:36:06 02/20/2019 
-- Design Name: 
-- Module Name:    Mux2t1 - Behavioral 
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

entity Mux2t1 is
    Port ( In0 : in  STD_LOGIC;
           In1 : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC);
end Mux2t1;

architecture Behavioral of Mux2t1 is

begin

process(S,In0,In1)
begin
	if S='0' then
		Output<=In0;
	else
		Output<=In1;
	end if;
end process;

end Behavioral;

