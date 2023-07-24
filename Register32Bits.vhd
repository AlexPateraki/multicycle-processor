----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:02:51 02/20/2019 
-- Design Name: 
-- Module Name:    Register32Bits - Behavioral 
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

entity Register32Bits is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Wea : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end Register32Bits;

architecture Behavioral of Register32Bits is
Component OneBitReg is
    Port ( Din : in  STD_LOGIC;
           Wea : in  STD_LOGIC;
           Dout : out  STD_LOGIC;
			  Clock : in STD_LOGIC);
end component;
signal registerOut : STD_LOGIC_VECTOR(31 downto 0);
begin

GEN:
for i in 0 to 31 generate
OneBitRegister: OneBitReg port map (Din(i),Wea,registerOut(i),Clock);
end generate;
Dout<=registerOut after 5 ns;

end Behavioral;

