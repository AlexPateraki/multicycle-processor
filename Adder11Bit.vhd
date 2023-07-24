----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:21 03/06/2019 
-- Design Name: 
-- Module Name:    Adder11Bit - Behavioral 
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

entity Adder11Bit is
	Port ( In0 : in  STD_LOGIC_VECTOR (10 downto 0);
           In1 : in  STD_LOGIC_VECTOR (10 downto 0);
           Output : out  STD_LOGIC_VECTOR (10 downto 0));
end Adder11Bit;

architecture Behavioral of Adder11Bit is
begin

Output<=std_logic_vector(unsigned(In0) + unsigned(In1)) after 5 ns;

end Behavioral;

