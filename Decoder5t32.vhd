----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:59:19 02/20/2019 
-- Design Name: 
-- Module Name:    Decoder5t32 - Behavioral 
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

entity Decoder5t32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder5t32;

architecture Behavioral of Decoder5t32 is
signal tempOut : STD_LOGIC_VECTOR(31 downto 0);
begin

process(Awr)
begin
case Awr is

when "00000" => 
	tempOut <= "00000000000000000000000000000001";
when "00001" => 
	tempOut <= "00000000000000000000000000000010";
when "00010" =>
	tempOut <= "00000000000000000000000000000100";
when "00011" =>
	tempOut <= "00000000000000000000000000001000";
when "00100" =>
	tempOut <= "00000000000000000000000000010000";
when "00101" =>
	tempOut <= "00000000000000000000000000100000";
when "00110" =>
	tempOut <= "00000000000000000000000001000000";
when "00111" =>
	tempOut <= "00000000000000000000000010000000";
when "01000" =>
	tempOut <= "00000000000000000000000100000000";
when "01001" =>
	tempOut <= "00000000000000000000001000000000";
when "01010" =>
	tempOut <= "00000000000000000000010000000000";
when "01011" =>
	tempOut <= "00000000000000000000100000000000";
when "01100" =>
	tempOut <= "00000000000000000001000000000000";
when "01101" =>
	tempOut <= "00000000000000000010000000000000";
when "01110" =>
	tempOut <= "00000000000000000100000000000000";
when "01111" =>
	tempOut <= "00000000000000001000000000000000";
when "10000" =>
	tempOut <= "00000000000000010000000000000000";
when "10001" =>
	tempOut <= "00000000000000100000000000000000";
when "10010" =>
	tempOut <= "00000000000001000000000000000000";
when "10011" =>
	tempOut <= "00000000000010000000000000000000";
when "10100" =>
	tempOut <= "00000000000100000000000000000000";
when "10101" =>
	tempOut <= "00000000001000000000000000000000";
when "10110" =>
	tempOut <= "00000000010000000000000000000000";
when "10111" =>
	tempOut <= "00000000100000000000000000000000";
when "11000" =>
	tempOut <= "00000001000000000000000000000000";
when "11001" =>
	tempOut <= "00000010000000000000000000000000";
when "11010" =>
	tempOut <= "00000100000000000000000000000000";
when "11011" =>
	tempOut <= "00001000000000000000000000000000";
when "11100" =>
	tempOut <= "00010000000000000000000000000000";
when "11101" =>
	tempOut <= "00100000000000000000000000000000";
when "11110" =>
	tempOut <= "01000000000000000000000000000000";
when "11111" =>
	tempOut <= "10000000000000000000000000000000";
when others =>
	tempOut <="00000000000000000000000000000000";

end case;
end process;

Output<=tempOut after 5 ns;

end Behavioral;

