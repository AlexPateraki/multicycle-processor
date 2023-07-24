----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:36:29 04/01/2019 
-- Design Name: 
-- Module Name:    MultiCycleProcessor - Behavioral 
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

entity MultiCycleProcessor is
    Port ( CauseReg_En : in STD_LOGIC;
			  cause_sel : in STD_LOGIC;
			  load_cause_sel : in STD_LOGIC;
			  epc_sel : in STD_LOGIC;
			  EPC_Write : in STD_LOGIC;
			  PC_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           RF_B_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_We : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Byte_sel : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
			  RF_WrData_sel : in  STD_LOGIC;
			  ExtImmed_sel : in  STD_LOGIC_VECTOR(1 downto 0);
			  Reset : in STD_LOGIC;
			  IR_En : in STD_LOGIC;
			  E_En : in STD_LOGIC;
           A_En : in STD_LOGIC;
			  B_En : in STD_LOGIC;
			  S_En : in STD_LOGIC;
			  MDR_En : in STD_LOGIC;
           Clock : in  STD_LOGIC;
			  ALU_Res : out STD_LOGIC_VECTOR(31 downto 0);
			  Zero : out  STD_LOGIC_VECTOR (31 downto 0);
           OpCode : out  STD_LOGIC_VECTOR (5 downto 0);
           Func : out  STD_LOGIC_VECTOR (5 downto 0));
end MultiCycleProcessor;

architecture Behavioral of MultiCycleProcessor is
Component ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Zero : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal Alu_Sum : STD_LOGIC_VECTOR (31 downto 0);

Component DECSTAGE is
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
end component;
signal DEC_RF_A :  STD_LOGIC_VECTOR (31 downto 0);
signal DEC_RF_B :  STD_LOGIC_VECTOR (31 downto 0);
signal temp_Immed :  STD_LOGIC_VECTOR (31 downto 0);

Component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           PC_LdEn : in  STD_LOGIC;
			  epc_sel : in STD_LOGIC;
			  EPC : in STD_LOGIC_VECTOR (31 downto 0);
           Reset : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal temp_PC : STD_LOGIC_VECTOR(31 downto 0);

Component LSB_Select is
    Port ( DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			  Byte_Sel : in STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal MDR_LSB_Out : STD_LOGIC_VECTOR (31 downto 0);
signal B_LSB_Out : STD_LOGIC_VECTOR (31 downto 0);

Component RAM is 
 port (
 clk : in std_logic;
 inst_addr : in std_logic_vector(10 downto 0);
 inst_dout : out std_logic_vector(31 downto 0);
 data_we : in std_logic;
 data_addr : in std_logic_vector(10 downto 0);
 data_din : in std_logic_vector(31 downto 0);
 data_dout : out std_logic_vector(31 downto 0));
 end component;
 signal Ram_Inst : STD_LOGIC_VECTOR(31 downto 0);
 signal Ram_Data_Out : STD_LOGIC_VECTOR(31 downto 0);
 
Component Subtractor is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal Sub_Zero : STD_LOGIC_VECTOR (31 downto 0);

Component Register32Bits is
    Port ( Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Wea : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           Clock : in  STD_LOGIC);
end component;
signal IR_Inst : STD_LOGIC_VECTOR(31 downto 0);
signal A_RF_A : STD_LOGIC_VECTOR(31 downto 0);
signal B_RF_B : STD_LOGIC_VECTOR(31 downto 0);
signal S_Sum : STD_LOGIC_VECTOR(31 downto 0);
signal MDR_Out : STD_LOGIC_VECTOR(31 downto 0);
signal epc_out : STD_LOGIC_VECTOR(31 downto 0);
signal cause_out : STD_LOGIC_VECTOR(31 downto 0);

Component Adder11Bit is
	Port ( In0 : in  STD_LOGIC_VECTOR (10 downto 0);
           In1 : in  STD_LOGIC_VECTOR (10 downto 0);
           Output : out  STD_LOGIC_VECTOR (10 downto 0));
end component;
signal temp_data_addr : STD_LOGIC_VECTOR (10 downto 0);

Component Mux2t1_32bitOut is
	Port (  In0 : in  STD_LOGIC_VECTOR(31 downto 0);
           In1 : in  STD_LOGIC_VECTOR(31 downto 0);
           S : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(31 downto 0));
end component;
signal ALU_B : STD_LOGIC_VECTOR(31 downto 0);
signal cause : STD_LOGIC_VECTOR(31 downto 0);
begin
IfSt : IfStage port map (temp_Immed, PC_sel,PC_LdEn ,epc_sel, epc_out, Reset, Clock, temp_PC);

EPC : Register32Bits port map (temp_PC, EPC_Write , epc_out, Clock);

RAM_comp : RAM port map (Clock, temp_PC(12 downto 2), Ram_Inst, MEM_WrEn, temp_data_addr, B_LSB_Out, Ram_Data_Out);

IR : Register32Bits port map (Ram_Inst,'1',IR_Inst,Clock);

Cause_Mux : Mux2t1_32bitOut port map (x"00000007",x"00000038", cause_sel, cause);

Cause_Reg : Register32Bits port map (cause, CauseReg_En, cause_out, Clock);

DecSt : DECSTAGE port map (IR_Inst,  ExtImmed_sel,  RF_B_sel, RF_We, MDR_Out, S_Sum, RF_WrData_sel, Clock, DEC_RF_A, DEC_RF_B, temp_Immed);

Sub : Subtractor port map (DEC_RF_A, DEC_RF_B, Sub_Zero);

E : Register32Bits port map (Sub_Zero, E_En, Zero, Clock);

A : Register32Bits port map ( DEC_RF_A, A_En, A_RF_A, Clock);

B : Register32Bits port map ( DEC_RF_B, B_En, B_RF_B, Clock);

Load_Cause_Mux :  Mux2t1_32bitOut port map (B_RF_B , cause_out ,load_cause_sel , ALU_B);

AluSt : ALUSTAGE port map (RF_A => A_RF_A, 
									RF_B => ALU_B, 
									Immed => temp_Immed, 
									ALU_Bin_sel => ALU_Bin_sel, 
									ALU_func => ALU_func,
									ALU_out => Alu_Sum);

S : Register32Bits port map ( Alu_Sum, S_En, S_Sum, Clock);

Adder11 :Adder11Bit port map (S_Sum(12 downto 2), "10000000000", temp_data_addr);

MDR : Register32Bits port map ( MDR_LSB_Out, MDR_En, MDR_Out, Clock);

LSB_Select_MDR : LSB_Select port map ( Ram_Data_Out, Byte_sel, MDR_LSB_Out);

B_Select_MDR : LSB_Select port map (B_RF_B, Byte_sel, B_LSB_Out);

OpCode<=IR_Inst(31 downto 26);
Func<=IR_Inst(5 downto 0);
ALU_Res <= Alu_Sum;

end Behavioral;

