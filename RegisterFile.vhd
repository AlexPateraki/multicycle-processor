----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:57:56 02/20/2019 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
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

entity RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Wea : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end RegisterFile;

architecture Behavioral of RegisterFile is

Component Decoder5t32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal tempWea : STD_LOGIC_VECTOR(31 downto 0);
signal decOut :STD_LOGIC_VECTOR(31 downto 0);

Component Mux32t1 is
    Port ( Din : in  STD_LOGIC_VECTOR (1023 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal tempMuxDin : STD_LOGIC_VECTOR(1023 downto 0);

Component Register32Bits is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Wea : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end component;

begin

Dec : Decoder5t32 port map (Awr,decOut);

tempWea(0)<=('0' and decOut(0)) after 2 ns;
tempWea(1)<=(Wea and decOut(1)) after 2 ns;
tempWea(2)<=(Wea and decOut(2)) after 2 ns;
tempWea(3)<=(Wea and decOut(3)) after 2 ns;
tempWea(4)<=(Wea and decOut(4)) after 2 ns;
tempWea(5)<=(Wea and decOut(5)) after 2 ns;
tempWea(6)<=(Wea and decOut(6)) after 2 ns;
tempWea(7)<=(Wea and decOut(7)) after 2 ns;
tempWea(8)<=(Wea and decOut(8)) after 2 ns;
tempWea(9)<=(Wea and decOut(9)) after 2 ns;
tempWea(10)<=(Wea and decOut(10)) after 2 ns;
tempWea(11)<=(Wea and decOut(11)) after 2 ns;
tempWea(12)<=(Wea and decOut(12)) after 2 ns;
tempWea(13)<=(Wea and decOut(13)) after 2 ns;
tempWea(14)<=(Wea and decOut(14)) after 2 ns;
tempWea(15)<=(Wea and decOut(15)) after 2 ns;
tempWea(16)<=(Wea and decOut(16)) after 2 ns;
tempWea(17)<=(Wea and decOut(17)) after 2 ns;
tempWea(18)<=(Wea and decOut(18)) after 2 ns;
tempWea(19)<=(Wea and decOut(19)) after 2 ns;
tempWea(20)<=(Wea and decOut(20)) after 2 ns;
tempWea(21)<=(Wea and decOut(21)) after 2 ns;
tempWea(22)<=(Wea and decOut(22)) after 2 ns;
tempWea(23)<=(Wea and decOut(23)) after 2 ns;
tempWea(24)<=(Wea and decOut(24)) after 2 ns;
tempWea(25)<=(Wea and decOut(25)) after 2 ns;
tempWea(26)<=(Wea and decOut(26)) after 2 ns;
tempWea(27)<=(Wea and decOut(27)) after 2 ns;
tempWea(28)<=(Wea and decOut(28)) after 2 ns;
tempWea(29)<=(Wea and decOut(29)) after 2 ns;
tempWea(30)<=(Wea and decOut(30)) after 2 ns;
tempWea(31)<=(Wea and decOut(31)) after 2 ns;

GEN:
for i in 0 to 31 generate
Registers: Register32Bits port map (Din,tempWea(i),tempMuxDin(i*32+31 downto i*32),Clock);
end generate;

Mux1 : Mux32t1 port map (tempMuxDin,Ard1,Dout1);
Mux2 : Mux32t1 port map (tempMuxDin,Ard2,Dout2);
end Behavioral;

