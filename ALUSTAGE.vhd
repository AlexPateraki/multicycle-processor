----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:52:23 03/05/2019 
-- Design Name: 
-- Module Name:    ALUSTAGE - Behavioral 
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

entity ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Zero : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is
Component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

Component Mux2t1_32bitOut is
    Port ( In0 : in  STD_LOGIC_Vector(31 downto 0);
           In1 : in  STD_LOGIC_Vector(31 downto 0);
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC_Vector(31 downto 0));
end component;
signal mux_out : std_logic_vector(31 downto 0);

begin

mux : Mux2t1_32bitOut port map (RF_B,Immed,ALU_Bin_sel,mux_out);

ALU_comp : ALU port map (RF_A,mux_out,ALU_func,ALU_out,Zero);

end Behavioral;

