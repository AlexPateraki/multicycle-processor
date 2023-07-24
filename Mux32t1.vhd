----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:49:28 02/20/2019 
-- Design Name: 
-- Module Name:    Mux32t1 - Behavioral 
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

entity Mux32t1 is
    Port ( Din : in  STD_LOGIC_VECTOR (1023 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux32t1;

architecture Behavioral of Mux32t1 is
signal output : STD_LOGIC_VECTOR(31 downto 0);
begin

process(Ard,Din)
begin
if (Ard = "00000") then output <= Din(31 downto 0);
elsif (Ard  = "00001") then output <= Din(63 downto 32);
elsif (Ard  = "00010") then output <= Din(95 downto 64);
elsif (Ard  = "00011") then output <= Din(127 downto 96);
elsif (Ard  = "00100") then output <= Din(159 downto 128);
elsif (Ard  = "00101") then output <= Din(191 downto 160);
elsif (Ard  = "00110") then output <= Din(223 downto 192);
elsif (Ard  = "00111") then output <= Din(255 downto 224);
elsif (Ard  = "01000") then output <= Din(287 downto 256);
elsif (Ard  = "01001") then output <= Din(319 downto 288);
elsif (Ard  = "01010") then output <= Din(351 downto 320);
elsif (Ard  = "01011") then output <= Din(383 downto 352);
elsif (Ard  = "01100") then output <= Din(415 downto 384);
elsif (Ard  = "01101") then output <= Din(447 downto 416);
elsif (Ard  = "01110") then output <= Din(479 downto 448);
elsif (Ard  = "01111") then output <= Din(511 downto 480);
elsif (Ard  = "10000") then output <= Din(543 downto 512);
elsif (Ard  = "10001") then output <= Din(575 downto 544);
elsif (Ard  = "10010") then output <= Din(607 downto 576);
elsif (Ard  = "10011") then output <= Din(639 downto 608);
elsif (Ard  = "10100") then output <= Din(671 downto 640);
elsif (Ard  = "10101") then output <= Din(703 downto 672);
elsif (Ard  = "10110") then output <= Din(735 downto 704);
elsif (Ard  = "10111") then output <= Din(767 downto 736);
elsif (Ard  = "11000") then output <= Din(799 downto 768);
elsif (Ard  = "11001") then output <= Din(831 downto 800);
elsif (Ard  = "11010") then output <= Din(863 downto 832);
elsif (Ard  = "11011") then output <= Din(895 downto 864);
elsif (Ard  = "11100") then output <= Din(927 downto 896);
elsif (Ard  = "11101") then output <= Din(959 downto 928);
elsif (Ard  = "11110") then output <= Din(991 downto 960);
elsif (Ard  = "11111") then output <= Din(1023 downto 992);
else output <= Din(31 downto 0);
end if;
end process;

Dout<=output after 5 ns;
end Behavioral;

