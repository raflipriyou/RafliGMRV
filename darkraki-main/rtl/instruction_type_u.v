module instruction_type_u(
	input				iCLK,
	input	 [31:0]	iIR,
	input  [31:0]  iPC,
	output [4:0] 	oRD,
	output [31:0]	oREG_IN,

	output			oRAM_CE,
	//output 			oRAM_RD,
	output 			oRAM_WR,
	output [31:0]	oRAM_ADDR,
	input  [31:0]	iRAM_DATA,
	output [31:0]	oRAM_DATA
	);
	
	wire [6:0]  opcode;
	wire [19:0] imm20;
	wire [31:0] alu_out;
	
	// decode instruction
	assign opcode 	= iIR[6:0];
	assign oRD	 	= iIR[11:7];
	assign imm20 	= iIR[31:12];
	
 
	assign alu_out =	(opcode=={7'h37}) ?   imm20 << 12 :					// lui (load upper immediate)
						(opcode=={7'h17}) ?   iPC + (imm20 << 12) :			// auipc (add upper immediate to PC)
						  32'h0 ;
	
	assign oREG_IN = alu_out;
	
	always @(posedge iCLK)
	begin
		//if(iIR[6:0]==7'h13)
			//$display("INSRUCTION TYPE I1 -> alu_in1: 0x%x, alu_in2: 0x%x, alu_out: 0x%x",alu_in1, alu_in2, alu_out);
	end
	
endmodule

