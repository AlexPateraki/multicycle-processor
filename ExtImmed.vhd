----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:41:45 03/05/2019 
-- Design Name: 
-- Module Name:    ExtImmed - Behavioral 
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

entity ExtImmed is
    Port ( Immed_In16B : in  STD_LOGIC_VECTOR (15 downto 0);
           ExtImmed_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Immed_Out32B : out  STD_LOGIC_VECTOR (31 downto 0));
end ExtImmed;

architecture Behavioral of ExtImmed is
signal temp : STD_LOGIC_VECTOR(31 downto 0);
signal temp18 : STD_LOGIC_VECTOR(17 downto 0);
begin
process(ExtImmed_sel,Immed_In16B,temp18)
begin
case ExtImmed_sel is
	when "00" =>
		--Zero Extend
		temp<=std_logic_vector(resize(unsigned(Immed_In16B),Immed_Out32B'length));
	when "01" => 
		--Sll16
		temp<= Immed_In16B & (15 downto 0 => '0');
	when "10" =>
		--Sign Extend
		temp<=std_logic_vector(resize(signed(Immed_In16B),Immed_Out32B'length));
	when others =>
		--Sign extend && sll2
		temp18 <=Immed_In16B & (1 downto 0 => '0');
		temp<=std_logic_vector(resize(signed(temp18),Immed_Out32B'length));
end case;
end process;

Immed_Out32B<=temp after 5 ns;
end Behavioral;

