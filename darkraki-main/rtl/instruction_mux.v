
module instruction_mux (
	input	[6:0]		iOpcode,
	input [31:0]	iIR,
	output [31:0]  oALU_OUT

	);
	
	wire [31:0] alu_out, alu_out_type_r;
	
	assign oALU_OUT = alu_out;
	
	//case (iOpcode)
	//	7'b0110011:	//(0x33)
	//						begin
	//						alu_out = alu_out_type_r;
	//						end
		//7'b0010011:	instruction_type_i1,	(0x13)
		//7'b0000011:	instruction_type_i2,	(0x03)
		//7'b0100011:	instruction_type_s,	(0x23)
		//7'b1100011:	instruction_type_b,	(0x63)
		//7'b1101111:	instruction_type_j1,	(0x6f)
		//7'b1100111:	instruction_type_j2,	(0x67)
		//7'b0110111:	instruction_type_u,	(0x37)
		
	//	default:
	
	//endcase
	
	instruction_type_r(
		.iIR(iIR),
		.oALU_OUT(alu_out_type_r)
	);
	
endmodule
