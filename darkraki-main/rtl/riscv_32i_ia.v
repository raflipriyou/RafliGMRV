`define OPCODE_I1 7'h13

`include "/home/raflipriyou/darkraki-main/rtl/program_counter.v"
`include "/home/raflipriyou/darkraki-main/rtl/register_file.v"
`include "/home/raflipriyou/darkraki-main/rtl/register_file_mux.v"
`include "/home/raflipriyou/darkraki-main/rtl/memory_ram_mux.v"
`include "/home/raflipriyou/darkraki-main/rtl/instruction_type_r.v"
`include "/home/raflipriyou/darkraki-main/rtl/instruction_type_i.v"
`include "/home/raflipriyou/darkraki-main/rtl/instruction_type_s.v"
`include "/home/raflipriyou/darkraki-main/rtl/instruction_type_u.v"
`include "/home/raflipriyou/darkraki-main/rtl/instruction_type_b.v"
`include "/home/raflipriyou/darkraki-main/rtl/instruction_type_j.v"

module riscv_32i_ia 
	#(
		parameter OPCODE_R  = 7'h33,
		parameter OPCODE_I1 = 7'h13,
		parameter OPCODE_I2 = 7'h03,
		parameter OPCODE_I3 = 7'h67,
		parameter OPCODE_S  = 7'h23,
		parameter OPCODE_U1 = 7'h37,
		parameter OPCODE_U2 = 7'h17,
		parameter OPCODE_B  = 7'h63,
		parameter OPCODE_J  = 7'h6f
	)
	(
	input						iRST,
	input						iCLK,
	
	output					oROM_CE,
	output 					oROM_RD,	
	output [31:0] 		oROM_ADDR,
	input  [31:0]		iROM_DATA,
	
	output					oRAM_CE,
	output 					oRAM_RD,	
	output 					oRAM_WR,	
	output [31:0] 		oRAM_ADDR,
	input  [31:0]		iRAM_DATA,
	output  [31:0]		oRAM_DATA
	);
	
	// write your code here...
	integer counter;
	wire [31:0] pc,pcbr_type_i,pcbr_type_b,pcbr_type_j;
	wire [31:0]	ir;
	wire [6:0] opcode;
	
	wire [4:0] a_rd,a_rs1,a_rs2;
	wire [4:0] b_rd,b_rs1,b_rs2;
	wire [4:0] c_rd,c_rs1,c_rs2;
	wire [4:0] d_rd,d_rs1,d_rs2;
	wire [4:0] e_rd,e_rs1,e_rs2;
	wire [4:0] f_rd,f_rs1,f_rs2;
	wire [4:0] x_rd,x_rs1,x_rs2;
	
	wire [31:0] a_reg_out1,a_reg_out2,a_reg_in;
	wire [31:0] b_reg_out1,b_reg_out2,b_reg_in;
	wire [31:0] c_reg_out1,c_reg_out2,c_reg_in;
	wire [31:0] d_reg_out1,d_reg_out2,d_reg_in;
	wire [31:0] e_reg_out1,e_reg_out2,e_reg_in;
	wire [31:0] f_reg_out1,f_reg_out2,f_reg_in;
	wire [31:0] x_reg_out1,x_reg_out2,x_reg_in;
	
	wire 		a_ram_ce,a_ram_rd,a_ram_wr,b_ram_ce,b_ram_rd,b_ram_wr,c_ram_ce,c_ram_rd,c_ram_wr;
	wire [31:0] a_ram_address,b_ram_address,c_ram_address;
	wire [31:0] a_ram_data_read,a_ram_data_write,b_ram_data_read,b_ram_data_write,c_ram_data_read,c_ram_data_write;
		
	assign oROM_CE = 1;
	assign oROM_RD = 1;
	assign oRAM_WR = ram_wr;
	assign oRAM_RD = ram_rd;
	assign oROM_ADDR = pc;
	assign ir = iROM_DATA;
	assign opcode = ir[6:0];
	
	initial begin
		counter = 0;
	end
	
	always @(posedge iCLK)
	begin
		//$display("\n### STEP INFO ###");
		$display("\n#CLOCK: {\"Clock\": %0d}",counter);
		$display("===PCIR: {\"PC\": 0x%x, \"IR\": 0x%x}",pc,ir);
		counter = counter + 1;
		// if(counter == 7) begin
		// 	$finish();
		// end

		
		//if (iRST==0)
		//	begin
		//		pc = 0;
		//	end
		//else
		//	begin
		//		//pc <= pc + 4;
		//$display("PC: 0x%x, IR: 0x%x, OPCODE: 0x%x, INSTRUCTION TYPE: %s",pc,ir,opcode,(opcode==7'h33) ? "R": (opcode==7'h13) ? "I1" : (opcode==7'h03) ? "I2" : (opcode==7'h23) ? "S" : "UNDEFINDED");
		//	end
	end
	
	program_counter u1(
		.iCLK(iCLK),
		.iRST(iRST),
		.iOpcode(opcode),
		.iPCBR_I(pcbr_type_i),
		.iPCBR_B(pcbr_type_b),
		.iPCBR_J(pcbr_type_j),
		.oPC(pc)
	);
	
	
	register_file u2(
		.iCLK(iCLK),
		.iRST(iRST),
		.iRD(x_rd),
		.iRS1(x_rs1),
		.iRS2(x_rs2),
		.oREG_OUT1(x_reg_out1),
		.oREG_OUT2(x_reg_out2),
		.iREG_IN(x_reg_in)
	);

	register_file_mux u3(
		.iOpcode(opcode),
		.CLK(iCLK),
		
		// connect to instruction type r
		.i_A_RD(a_rd),
		.i_A_RS1(a_rs1),
		.i_A_RS2(a_rs2),
		.i_A_REG_IN(a_reg_in),
		.o_A_REG_OUT1(a_reg_out1),
		.o_A_REG_OUT2(a_reg_out2),
		
		// connect to instruction type i
		.i_B_RD(b_rd),
		.i_B_RS1(b_rs1),
		.i_B_RS2(5'h0),
		.i_B_REG_IN(b_reg_in),
		.o_B_REG_OUT1(b_reg_out1),
		.o_B_REG_OUT2(), //(b_reg_out2),
		
		// connect to instruction type s
		.i_C_RD(c_rd),
		.i_C_RS1(c_rs1),
		.i_C_RS2(c_rs2),
		.i_C_REG_IN(c_reg_in),
		.o_C_REG_OUT1(c_reg_out1),
		.o_C_REG_OUT2(c_reg_out2),
		
		// connect to instruction type u
		.i_D_RD(d_rd),
		.i_D_RS1(5'h0),
		.i_D_RS2(5'h0),
		.i_D_REG_IN(d_reg_in),
		.o_D_REG_OUT1(d_reg_out1),	//(d_reg_out1),
		.o_D_REG_OUT2(d_reg_out2),	//(d_reg_out2),
		
		// connect to instruction type b
		.i_E_RD(e_rd),
		.i_E_RS1(5'h0),
		.i_E_RS2(5'h0),
		.i_E_REG_IN(e_reg_in),
		.o_E_REG_OUT1(e_reg_out1),	//(d_reg_out1),
		.o_E_REG_OUT2(e_reg_out2),	//(d_reg_out2),
		
		// connect to instruction type j
		.i_F_RD(f_rd),
		.i_F_RS1(5'h0),
		.i_F_RS2(5'h0),
		.i_F_REG_IN(f_reg_in),
		.o_F_REG_OUT1(),	//(e_reg_out1),
		.o_F_REG_OUT2(),	//(e_reg_out2),
		
		// connect to Register File
		.o_X_RD(x_rd),
		.o_X_RS1(x_rs1),
		.o_X_RS2(x_rs2),
		.o_X_REG_IN(x_reg_in),
		.i_X_REG_OUT1(x_reg_out1),
		.i_X_REG_OUT2(x_reg_out2)
	);
	
	memory_ram_mux u4(
		.iOpcode(opcode),
		.CLK(iCLK),
		.RAM_WR(ram_wr),
		.RAM_RD(ram_rd),
		
		.i_A_RAM_CE(a_ram_ce),
		.i_A_RAM_RD(a_ram_rd),
		.i_A_RAM_WR(a_ram_wr),
		.i_A_RAM_ADDR(a_ram_address),
		.o_A_RAM_DATA_RD(a_ram_data_read),
		.i_A_RAM_DATA_WR(a_ram_data_write),
	
		.i_B_RAM_CE(b_ram_ce),
		.i_B_RAM_RD(b_ram_rd),
		.i_B_RAM_WR(b_ram_wr),
		.i_B_RAM_ADDR(b_ram_address),
		.o_B_RAM_DATA_RD(b_ram_data_read),
		.i_B_RAM_DATA_WR(b_ram_data_write),

		.i_C_RAM_CE(c_ram_ce),
		.i_C_RAM_RD(c_ram_rd),
		.i_C_RAM_WR(c_ram_wr),
		.i_C_RAM_ADDR(c_ram_address),
		.o_C_RAM_DATA_RD(c_ram_data_read),
		.i_C_RAM_DATA_WR(c_ram_data_write),
		
		.o_X_RAM_CE(oRAM_CE),
		.o_X_RAM_RD(oRAM_RD),
		.o_X_RAM_WR(oRAM_WR),
		.o_X_RAM_ADDR(oRAM_ADDR),
		.i_X_RAM_DATA_RD(iRAM_DATA),
		.o_X_RAM_DATA_WR(oRAM_DATA)
	);
	
	instruction_type_r u5(
		.iCLK(iCLK),
		.iIR(ir),
		
		.oRD(a_rd),
		.oRS1(a_rs1),
		.oRS2(a_rs2),
		.iREG_OUT1(a_reg_out1),
		.iREG_OUT2(a_reg_out2),		
		.oREG_IN(a_reg_in)
	);
	
	instruction_type_i u6(
		.iCLK(iCLK),
		.iIR(ir),
		
		.oRD(b_rd),
		.oRS1(b_rs1),
		.oREG_IN(b_reg_in),
		.iREG_OUT1(b_reg_out1),		
		
		
		.oRAM_CE(a_ram_ce),
		.oRAM_RD(a_ram_rd),
		.oRAM_WR(a_ram_wr),
		.oRAM_ADDR(a_ram_address),
		.iRAM_DATA(a_ram_data_read),
		
		.iPC(pc),
		.oPCBR(pcbr_type_i)
	);
	
	
	instruction_type_s u7(
		.iCLK(iCLK),
		.iIR(ir),
		
		.oRD(c_rd),
		.oRS1(c_rs1),
		.oRS2(c_rs2),
		.iREG_OUT1(c_reg_out1),
		.iREG_OUT2(c_reg_out2),		
		.oREG_IN(c_reg_in),
		
		.oRAM_CE(b_ram_ce),
		// .oRAM_RD(b_ram_rd),
		.oRAM_WR(b_ram_wr),
		.oRAM_ADDR(b_ram_address),
		.iRAM_DATA(b_ram_data_read),
		.oRAM_DATA(b_ram_data_write)
	);
	
	instruction_type_u u8(
		.iCLK(iCLK),
		.iIR(ir),
		
		.iPC(pc),
		.oRD(d_rd),
		.oREG_IN(d_reg_in),

		.oRAM_CE(c_ram_ce),
		// .oRAM_RD(b_ram_rd),
		.oRAM_WR(c_ram_wr),
		.oRAM_ADDR(c_ram_address),
		.iRAM_DATA(c_ram_data_read),
		.oRAM_DATA(c_ram_data_write)
	);
	
	instruction_type_b u9(
		.iCLK(iCLK),
		.iIR(ir),
		.oRS1(e_rs1),
		.oRS2(e_rs2),
		.iREG_OUT1(e_reg_out1),
		.iREG_OUT2(e_reg_out2),
		.oPCBR(pcbr_type_b)
	);
	
	instruction_type_j u10(
		.iCLK(iCLK),
		.iIR(ir),
		.iPC(pc),
		.oRD(f_rd),
		.oREG_IN(f_reg_in),
		.oPCBR(pcbr_type_j)
	);

endmodule

