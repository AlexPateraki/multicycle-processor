----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:10:29 02/20/2019 
-- Design Name: 
-- Module Name:    DFlipFlop - Behavioral 
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

entity DFlipFlop is
    Port ( D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NotQ : out  STD_LOGIC;
           Clock : in  STD_LOGIC);
end DFlipFlop;

architecture Behavioral of DFlipFlop is
type state_type is (S0,S1);
signal state,next_state : state_type;

begin

sync_proc:process(Clock)
begin
	if rising_edge(Clock) then
		state<=next_state;
	end if;
end process;

next_state_dec:process(D)
begin
if(D='0') then 
	next_state<=S0;
else
	next_state<=S1;
end if;
end process;

output_dec: process(state)
begin
case state is
	when S0 =>
		Q<='0';
		NotQ<='1';
	when S1 =>
		Q<='1';
		NotQ<='0';
end case;
end process;	


end Behavioral;

