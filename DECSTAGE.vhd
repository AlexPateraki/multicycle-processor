----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:18:44 03/05/2019 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Inst : in  STD_LOGIC_VECTOR (31 downto 0);
           ExtImmed_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           RF_B_sel : in  STD_LOGIC;
           RF_We : in  STD_LOGIC;
           MEM_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           Data_Out1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Data_Out2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is
Component RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Wea : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end component;

Component ExtImmed is
    Port ( Immed_In16B : in  STD_LOGIC_VECTOR (15 downto 0);
           ExtImmed_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Immed_Out32B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component Mux2t1_5bitOut is
    Port ( In0 : in  STD_LOGIC_Vector(4 downto 0);
           In1 : in  STD_LOGIC_Vector(4 downto 0);
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC_Vector(4 downto 0));
end component;
signal rt : std_logic_vector(4 downto 0);

Component Mux2t1_32bitOut is
    Port ( In0 : in  STD_LOGIC_Vector(31 downto 0);
           In1 : in  STD_LOGIC_Vector(31 downto 0);
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC_Vector(31 downto 0));
end component;
signal data_write : std_logic_vector (31 downto 0); 
begin
MuxRF_B : Mux2t1_5bitOut port map (Inst(15 downto 11), Inst(20 downto 16),RF_B_sel,rt);

MuxDataWrite : Mux2t1_32bitOut port map ( MEM_Out,ALU_Out,RF_WrData_sel,data_write);

ImmedExt : ExtImmed port map (Inst(15 downto 0), ExtImmed_sel,Immed);

RF : RegisterFile port map (Inst(25 downto 21),rt,Inst(20 downto 16),RF_We,data_write,Data_Out1,Data_Out2,Clock);

end Behavioral;

