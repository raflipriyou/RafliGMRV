module instruction_type_s(
	input			iCLK,
	input	 [31:0]	iIR,
	input	 [31:0]	iREG_OUT1,
	input	 [31:0]	iREG_OUT2,
	output [4:0] 	oRD,
	output [4:0] 	oRS1,
	output [4:0] 	oRS2,
	output [31:0]	oREG_IN,
	
	output			oRAM_CE,
	//output 			oRAM_RD,
	output 			oRAM_WR,
	output [31:0]	oRAM_ADDR,
	input  [31:0]	iRAM_DATA,
	output [31:0]	oRAM_DATA
	
	);
	
	wire [2:0] func3;
	wire [4:0] imm5;
	wire [6:0] imm7;
	wire [11:0] imm12;
	wire [31:0] alu_in1,alu_in2,alu_out, ram_address,ram_data_rd;
	wire [31:0] ram_data_byte_wr,ram_data_half_wr,ram_data_word_wr;
	wire [15:0] ram_data_half;
	
	assign oRD = 5'h00;
	assign oRS1 = iIR[19:15];
	assign oRS2 = iIR[24:20];
	assign imm5 = iIR[11:7];
	assign imm7 = iIR[31:25];
	assign imm12 = {imm7,imm5};
	assign func3 = iIR[14:12];
	
	assign alu_in1 = iREG_OUT1;
	assign alu_in2 = iREG_OUT2;
	
	assign oRAM_CE = 1;
	//assign oRAM_RD = 0;
	assign oRAM_WR = 1;
	assign ram_address = alu_in1 + imm12;
	assign oRAM_ADDR = ram_address;
	assign ram_data_rd = iRAM_DATA;

	
	assign ram_data_byte_wr = 	(ram_address[1:0] == 2'b00) ? (alu_in2[7:0] | (ram_data_rd & 32'hffffff00)):
								(ram_address[1:0] == 2'b01) ? ((alu_in2[7:0]<<8) | (ram_data_rd & 32'hffff00ff)):
								(ram_address[1:0] == 2'b10) ? ((alu_in2[7:0]<<16) | (ram_data_rd & 32'hff00ffff)):
								(ram_address[1:0] == 2'b11) ? ((alu_in2[7:0]<<24) | (ram_data_rd & 32'h00ffffff)): 32'h00;
									
	assign ram_data_half_wr = 	(ram_address[1] == 1'b0) ? ((alu_in2[15:0]) | (ram_data_rd & 32'hffff0000)):
								(ram_address[1] == 1'b1) ? ((alu_in2[15:0]<<16) | (ram_data_rd & 32'h0000ffff)): 32'h00;
										
	assign ram_data_word_wr = alu_in2;
									
	assign oRAM_DATA =		(func3=={3'h0}) ?   ram_data_byte_wr :	// Store Byte
							(func3=={3'h1}) ?   ram_data_half_wr :	// Store Half
							(func3=={3'h2}) ?   ram_data_word_wr :	// Store Word
							32'h00000000 ;
	
	assign oREG_IN = 32'h0;
	
	always @(posedge iCLK)
	begin
		// if(iIR[6:0]==7'h23)
		// 	begin
		// 		//$display("INSRUCTION TYPE S -> rd: 0x%x, rs1: 0x%x, rs2: 0x%x",oRD, oRS1, oRS2);
		// 		//$display("INSRUCTION TYPE S -> alu_in1: 0x%x, alu_in2: 0x%x, imm12: 0x%x, ram_address: 0x%x, ram_data_rd: 0x%x, oRAM_DATA: 0x%x",alu_in1, alu_in2, imm12, ram_address, ram_data_rd, oRAM_DATA);
		// 	end
		//$display("data masuk s = 0x%x", iRAM_DATA);
		//$display("data keluar s = 0x%x", oRAM_DATA);
	end
	
endmodule