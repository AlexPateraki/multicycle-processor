----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:23 04/01/2019 
-- Design Name: 
-- Module Name:    MultiCycleProcessorControlPath - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiCycleProcessorControlPath is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Func : in  STD_LOGIC_VECTOR (5 downto 0);
           Zero : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Res : in STD_LOGIC_VECTOR(31 downto 0);
			  Reset : in STD_LOGIC;
           Clock : in  STD_LOGIC;
			  --ALU
			  CauseReg_En : out STD_LOGIC;
			  cause_sel : out STD_LOGIC;
			  load_cause_sel : out STD_LOGIC;
			  epc_sel : out STD_LOGIC;
			  EPC_Write : out STD_LOGIC;
			  --
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
end MultiCycleProcessorControlPath;

architecture Behavioral of MultiCycleProcessorControlPath is
type state_type is (InstF, Dec, R_type, li, lui, addi, nandi, ori, b, beq, bne, lb, lw, sb, sw, MDR_lb, MDR_lw, load_ALU,load_MDR, store, Illegal_Addr, Illegal_Instr, jump_epc);
signal state, next_state : state_type; 

signal temp_CauseReg_En, temp_cause_sel, temp_load_cause_sel, temp_epc_sel, temp_EPC_Write, temp_MEM_WrEn ,temp_Byte_Sel , temp_ALU_Bin_sel ,temp_RF_WrData_sel ,temp_RF_We ,temp_RF_B_sel ,temp_PC_LdEn ,temp_IR_En ,temp_E_En ,temp_A_En ,temp_B_En ,temp_S_En ,temp_MDR_En : STD_LOGIC;
signal temp_ALU_func : STD_LOGIC_VECTOR(3 downto 0);
signal  temp_PC_sel, temp_ExtImmed_sel : STD_LOGIC_VECTOR(1 downto 0);
begin
	SYNC_PROC : process (Clock)
	begin
		 if rising_edge(Clock) then
			 if (Reset = '1') then
				state <= InstF;
			 else
				state <= next_state;
			end if;
		 end if;
end process; 

NEXT_STATE_DECODE : process (state,OpCode,ALU_Res,Func)
begin
	 next_state <= InstF;
	 case (state) is
		 when InstF =>
			next_state <= Dec;
		 when Dec =>
			case(OpCode) is 
				when "100000"=>
					if(Func="110000" or Func="110001" or Func="110010" or Func="110100" or Func="110011" or Func="111000" or Func="111001" or Func="111010" or Func="111100" or Func="111101" or Func="000000") then
						next_state <= R_type;
					else 
						next_state <= Illegal_Instr;
					end if;
				when "111000" =>
					next_state <= li;
				when "111001" =>
					next_state <= lui;
				when "110000" => 
					next_state <= addi;
				when "110010" => 
					next_state <= nandi;
				when "110011" => 
					next_state <= ori;
				when "111111" => 
					next_state <= b;
				when "000000" => 
					next_state <= beq;
				when "000001" => 
					next_state <= bne;
				when "000011" => 
					next_state <= lb;
				when "000111" => 
					next_state <= sb;
				when "001111" => 
					next_state <= lw;
				when "011111" => 
					next_state <= sw;
				when "000010" =>
					next_state <= jump_epc;
				when others =>
					next_state <= Illegal_Instr;
					---Wrong OpCode
			end case;
		 when R_type =>
			next_state <= load_ALU;
		 when li =>
			next_state <= load_ALU;
		 when lui =>
			next_state <= load_ALU;
		 when addi =>
			next_state <= load_ALU;
		 when nandi =>
			next_state <= load_ALU;
		 when ori =>
			next_state <= load_ALU;
		 when b =>
			next_state <= InstF;
		 when beq =>
			next_state <= InstF;
		 when bne =>
			next_state <= InstF;
		 when lw =>
			if(ALU_Res>=x"00000400") then
				next_state <= Illegal_Addr;
			else
				next_state <= MDR_lw;
			end if;
		 when lb =>
			if(ALU_Res>=x"00000400") then
				next_state <= Illegal_Addr;
			else
				next_state <= MDR_lb;
			end if;
		 when sw =>
			if(ALU_Res>=x"00000400") then
				next_state <= Illegal_Addr;
			else
				next_state <= store;
			end if;
		 when sb =>
			if(ALU_Res>=x"00000400") then
				next_state <= Illegal_Addr;
			else
				next_state <= store;
			end if;
		 when MDR_lb =>
			next_state <= load_MDR;
		 when MDR_lw =>
			next_state <= load_MDR;
		 when load_ALU =>
			next_state <= InstF;
		 when load_MDR =>
			next_state <= InstF;
		 when store =>
			next_state <= InstF;
		 when Illegal_Addr =>
			next_state <= InstF;
		 when jump_epc =>
			next_state <= InstF;
		 when others =>
			next_state <= InstF;
	 end case;
end process;

OUTPUT_DECODE : process (state,Zero)
begin
	case (state) is
		when InstF=>
			  temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
																		  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '1';--d
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '1';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
		when Dec =>
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
			  temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '1';
           temp_A_En <= '1';
			  temp_B_En <= '1';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
		when R_type=>
			  temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<= not func(5);			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= func(3 downto 0);
           temp_ALU_Bin_sel <= '0';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0';
	  when li=>
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "10";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0'; 
		 when lui=>
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "01";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '1';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0'; 
		 when addi=>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "10";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0';
		 when nandi=>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "00";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0010";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0';
		when ori=>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "00";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0011";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0';
		when b=>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			   
			  temp_PC_sel <= "01";
           temp_ExtImmed_sel <= "11";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
		when beq=>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  if(Zero=x"00000000") then 
					temp_PC_sel <= "01";
			  else
					temp_PC_sel <= "00";
			  end if;
           temp_ExtImmed_sel <= "11";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when bne=>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  if(Zero/=x"000000000") then 
					temp_PC_sel <= "01";
			  else
					temp_PC_sel <= "00";
			  end if;
           temp_ExtImmed_sel <= "11";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when sb=>
	---If Address out of range
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "10";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '1';
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '1';
			  temp_S_En <= '1';
			  temp_MDR_En <='1';
	when sw =>
	---If Address out of range
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";--d
           temp_ExtImmed_sel <= "10";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '1';
			  temp_S_En <= '1';
			  temp_MDR_En <='1';
	when store =>
			 temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '1';
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when lw=>
	---If Address out of range
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "10";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0';
	when lb=>
	---If Address out of range
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "10";
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '1';
			  temp_MDR_En <='0';
  when MDR_lb=>
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '1';
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '1';
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='1';	
	when MDR_lw=>
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
			  temp_Byte_Sel <= '0';
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';--d
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '0';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='1';
	when load_ALU =>	
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '1';
           temp_RF_We <= '1';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when load_MDR =>
				temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';
           temp_RF_We <= '1';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when Illegal_Addr =>
			  temp_CauseReg_En<='1';
			  temp_cause_sel<='1';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='1';
			  
			  temp_PC_sel <= "10";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when Illegal_Instr =>
			  temp_CauseReg_En<='1';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='1';
			  
			  temp_PC_sel <= "11";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when jump_epc =>
			  temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='1';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';
           temp_RF_We <= '0';
           temp_RF_B_sel <= '0';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	when others =>
			temp_CauseReg_En<='0';
			  temp_cause_sel<='0';
			  temp_load_cause_sel<='0';			  
			  temp_epc_sel<='0';
			  temp_EPC_Write<='0';
			  
			  temp_PC_sel <= "00";
           temp_ExtImmed_sel <= "00";--d
           temp_MEM_WrEn <= '0';
           temp_Byte_Sel <= '0';--d
           temp_ALU_func <= "0000";--d
           temp_ALU_Bin_sel <= '0';--d
           temp_RF_WrData_sel <= '0';
           temp_RF_We <= '0';
           temp_RF_B_sel <= '1';
			  temp_PC_LdEn <= '1';
			  temp_IR_En <= '0';
			  temp_E_En <= '0';
           temp_A_En <= '0';
			  temp_B_En <= '0';
			  temp_S_En <= '0';
			  temp_MDR_En <='0';
	end case;
end process; 
CauseReg_En <= temp_CauseReg_En after 2 ns;
cause_sel <= temp_cause_sel after 2 ns;
load_cause_sel <= temp_load_cause_sel after 2 ns;
epc_sel <=temp_epc_sel after 2 ns;
EPC_Write <= temp_EPC_Write after 2 ns;

PC_sel <= temp_PC_sel after 2 ns;
ExtImmed_sel <= temp_ExtImmed_sel after 2 ns;
MEM_WrEn <= temp_MEM_WrEn after 2 ns;
Byte_Sel <= temp_Byte_Sel after 2 ns;
ALU_func <= temp_ALU_func after 2 ns;
ALU_Bin_sel <= temp_ALU_Bin_sel after 2 ns;
RF_WrData_sel <= temp_RF_WrData_sel after 2 ns;
RF_We <= temp_RF_We after 2 ns;
RF_B_sel <= temp_RF_B_sel after 2 ns;
PC_LdEn <= temp_PC_LdEn after 2 ns;
IR_En <= temp_IR_En after 2 ns;
E_En <= temp_E_En after 2 ns;
A_En <= temp_A_En after 2 ns;
B_En <= temp_B_En after 2 ns;
S_En <= temp_S_En after 2 ns;
MDR_En <= temp_MDR_En after 2 ns;

end Behavioral;

