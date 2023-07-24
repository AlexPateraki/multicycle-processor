----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:44 02/13/2019 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal tempOut : STD_LOGIC_VECTOR(32 downto 0);
signal tempZero : STD_LOGIC;
signal tempOvf : STD_LOGIC;

begin

process(Op,A,B,tempOut)
begin
case Op is
	when "0000" =>
		--Add
		tempOut<=(A(31) & A) + (B(31) & B);
		if(A(31)=B(31)) then
			if(A(31)=tempOut(31)) then
				tempOvf<='0';
			else
				tempOvf<='1';
			end if;
		else
			tempOvf<='0';
		end if;
	when "0001" =>
		--Sub
		tempOut<=(A(31) & A) - (B(31) & B);
		if(A(31)/=B(31)) then
			if(A(31)=tempOut(31)) then
				tempOvf<='0';
			else
				tempOvf<='1';
			end if;
		else
			tempOvf<='0';
		end if;
--	when "0010" =>
--		--AND
--		tempOut<=('0' & A) AND ('0' & B);
--		tempOvf<='0';
	when "0011" =>
		--OR
		tempOut<=('0' & A) OR ('0' & B);
		tempOvf<='0';
	when "0100" =>
		--Not A
		tempOut<='0' & (NOT A);
		tempOvf<='0';
	when "1000" =>
		--Shift Right Arithmetic
		tempOut<='0' & (A(31) & A(31 downto 1));
		tempOvf<='0';
	when "1010" =>
		--Shift Right Logical
		tempOut<='0' & ('0' & A(31 downto 1));
		tempOvf<='0';
	when "1001" =>
		--Shift Left Logical
		tempOut<='0' & ((A(30 downto 0) & '0'));
		tempOvf<='0';
	when "1100" =>
		--Rotate A Left
		tempOut<='0' & ((A(30 downto 0) & A(31)));
		tempOvf<='0';
	when "1101" =>
		--Rotate A Right
		tempOut<='0' & ((A(0) & A(31 downto 1)));
		tempOvf<='0';
	-----------------------------
	when "0010" =>
		--Nand
		tempOut<=('0' & A) NAND ('0' & B);
		tempOvf<='0';	
	when others =>
		tempOut<=(others=>'0');
		tempOvf<='0';
	end case;
end process;

process(tempOut,tempZero,tempOvf)
begin

if(tempOut(31 downto 0)=x"00000000") then
		tempZero<='1';
	else
		tempZero<='0';
end if;
end process;

Output<=tempOut(31 downto 0) after 10 ns;
Cout<=tempOut(32) after 10 ns;
Zero<=tempZero after 10 ns;
Ovf<=tempOvf after 10 ns;

end Behavioral;

