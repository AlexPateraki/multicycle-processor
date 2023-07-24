----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:18:16 03/04/2019 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           PC_LdEn : in  STD_LOGIC;
			  epc_sel : in STD_LOGIC;
			  EPC : in STD_LOGIC_VECTOR (31 downto 0);
           Reset : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

Component Adder32bit is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal PCImmed : std_logic_vector(31 downto 0);
signal PC4 : std_logic_vector(31 downto 0);

Component Mux4t1_32bitOut is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           In2 : in  STD_LOGIC_VECTOR (31 downto 0);
           In3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;
signal PC_next : std_logic_vector(31 downto 0);

Component Mux2t1_32bitOut is
	Port (  In0 : in  STD_LOGIC_VECTOR(31 downto 0);
           In1 : in  STD_LOGIC_VECTOR(31 downto 0);
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(31 downto 0));
end component;
signal PC_EPC : std_logic_vector(31 downto 0);

Component PC_Module is
    Port ( PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Addr_In : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end component;
signal temp_PC :  STD_LOGIC_VECTOR (31 downto 0);
begin

mux_EpcPc : Mux2t1_32bitOut port map (temp_PC,EPC, epc_sel,PC_EPC);

PCInc4 : Adder32bit  port map (PC_EPC ,x"00000004", PC4);

ImmedAdd : Adder32bit port map(PC4,PC_Immed,PCImmed);

mux : Mux4t1_32bitOut port map (PC4,PCImmed,x"00000030",x"00000040",PC_sel,PC_next);

PC_comp : PC_Module port map (PC_LdEN,Reset,PC_next,temp_PC,Clock);

PC<=temp_PC;
end Behavioral;

