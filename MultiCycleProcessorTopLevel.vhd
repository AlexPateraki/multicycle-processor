----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:01:21 04/02/2019 
-- Design Name: 
-- Module Name:    MultiCycleProcessorTopLevel - Behavioral 
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

entity MultiCycleProcessorTopLevel is
    Port ( Reset : in  STD_LOGIC;
           Clock : in  STD_LOGIC);
end MultiCycleProcessorTopLevel;

architecture Behavioral of MultiCycleProcessorTopLevel is

Component MultiCycleProcessorControlPath is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Func : in  STD_LOGIC_VECTOR (5 downto 0);
           Zero : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Res : in STD_LOGIC_VECTOR(31 downto 0);
			  Reset : in STD_LOGIC;
           Clock : in  STD_LOGIC;
			  -----
			  CauseReg_En : out STD_LOGIC;
			  cause_sel : out STD_LOGIC;
			  load_cause_sel : out STD_LOGIC;
			  epc_sel : out STD_LOGIC;
			  EPC_Write : out STD_LOGIC;
			  ---
           PC_sel : out  STD_LOGIC_VECTOR(1 downto 0);
           ExtImmed_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           MEM_WrEn : out  STD_LOGIC;
           Byte_Sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           ALU_Bin_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_We : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
			  PC_LdEn :out STD_LOGIC;
			  IR_En : out STD_LOGIC;
			  E_En : out STD_LOGIC;
           A_En : out STD_LOGIC;
			  B_En : out STD_LOGIC;
			  S_En : out STD_LOGIC;
			  MDR_En : out STD_LOGIC);
end component;
signal temp_ExtImmed_sel , temp_PC_sel: STD_LOGIC_VECTOR(1 downto 0);
signal temp_ALU_func : STD_LOGIC_VECTOR(3 downto 0);
signal temp_CauseReg_En, temp_cause_sel, temp_load_cause_sel, temp_epc_sel, temp_EPC_Write, temp_MEM_WrEn, temp_Byte_sel, temp_LoadStore_sel, temp_ALU_Bin_sel, temp_RF_WrData_sel, temp_RF_We, temp_RF_B_sel, temp_PC_LdEn, temp_IR_En, temp_E_En, temp_A_En, temp_B_En, temp_S_En, temp_MDR_En : STD_LOGIC;

Component MultiCycleProcessor is
    Port ( CauseReg_En : in STD_LOGIC;
			  cause_sel : in STD_LOGIC;
			  load_cause_sel : in STD_LOGIC;
			  epc_sel : in STD_LOGIC;
			  EPC_Write : in STD_LOGIC;
			  ------
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
end component;
signal temp_OpCode, temp_Func : STD_LOGIC_VECTOR(5 downto 0);
signal temp_Zero ,temp_ALU_Res: STD_LOGIC_VECTOR(31 downto 0);


begin
Control_Path : MultiCycleProcessorControlPath port map( OpCode => temp_OpCode,
																		  Func => temp_Func,
																		  Zero => temp_Zero,
																		  ALU_Res => temp_ALU_Res,
																		  Reset => Reset,
																		  Clock => Clock,
																		  CauseReg_En => temp_CauseReg_En, 
																		  cause_sel => temp_cause_sel, 
																		  load_cause_sel => temp_load_cause_sel, 
																		  epc_sel => temp_epc_sel, 
																		  EPC_Write => temp_EPC_Write, 
																		  PC_sel => temp_PC_sel,
																		  ExtImmed_sel => temp_ExtImmed_sel, 
																		  MEM_WrEn => temp_MEM_WrEn, 
																		  Byte_Sel => temp_Byte_sel,
																		  ALU_func => temp_ALU_func,
																		  ALU_Bin_sel => temp_ALU_Bin_sel,
																		  RF_WrData_sel => temp_RF_WrData_sel,
																		  RF_We => temp_RF_We,
																		  RF_B_sel => temp_RF_B_sel,
																		  PC_LdEn => temp_PC_LdEn,
																		  IR_En => temp_IR_En,
																		  E_En => temp_E_En,
																		  A_En => temp_A_En,
																		  B_En => temp_B_En,
																		  S_En => temp_S_En,
																		  MDR_En => temp_MDR_En);
																		  
Data_Path : MultiCycleProcessor port map (CauseReg_En => temp_CauseReg_En, 
														cause_sel => temp_cause_sel, 
													   load_cause_sel => temp_load_cause_sel, 
													   epc_sel => temp_epc_sel, 
													   EPC_Write => temp_EPC_Write, 
													  
													  PC_sel => temp_PC_sel, 
													  RF_B_sel => temp_RF_B_sel ,
													  PC_LdEn => temp_PC_LdEn ,
													  RF_We => temp_RF_We ,
													  ALU_Bin_sel => temp_ALU_Bin_sel ,
													  ALU_func => temp_ALU_func ,
													  Byte_sel => temp_Byte_sel,
													  MEM_WrEn => temp_MEM_WrEn ,
													  RF_WrData_sel => temp_RF_WrData_sel ,
													  ExtImmed_sel => temp_ExtImmed_sel ,
													  Reset => Reset,
													  IR_En => temp_IR_En ,
													  E_En => temp_E_En ,
													  A_En => temp_A_En ,
													  B_En => temp_B_En ,
													  S_En => temp_S_En ,
													  MDR_En => temp_MDR_En ,
													  Clock => Clock,
													  ALU_Res => temp_ALU_Res,
													  Zero => temp_Zero ,
													  OpCode => temp_OpCode ,
													  Func => temp_Func);									
end Behavioral;

