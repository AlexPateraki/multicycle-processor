----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:42:48 02/20/2019 
-- Design Name: 
-- Module Name:    OneBitReg - Behavioral 
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

entity OneBitReg is
    Port ( Din : in  STD_LOGIC;
           Wea : in  STD_LOGIC;
           Dout : out  STD_LOGIC;
			  Clock : in STD_LOGIC);
end OneBitReg;

architecture Behavioral of OneBitReg is
component Mux2t1 is
    Port ( In0 : in  STD_LOGIC;
           In1 : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC);
end component;

component DFlipFlop is
    Port ( D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NotQ : out  STD_LOGIC;
           Clock : in  STD_LOGIC);
end component;

signal DFFOut : STD_LOGIC;
signal muxOut : STD_LOGIC;
signal DFFnotQ : STD_LOGIC;
begin

mux : Mux2t1 port map (DFFOut,Din,Wea,muxOut);
DFF : DFlipFlop port map (muxOut,DFFOut,DFFnotQ,Clock);

Dout<=DFFOut;

end Behavioral;

