
module instruction_type_r(
	input				iCLK,
	input	 [31:0]	iIR,
	input	 [31:0]	iREG_OUT1,
	input	 [31:0]	iREG_OUT2,
	output [4:0] 	oRD,
	output [4:0] 	oRS1,
	output [4:0] 	oRS2,
	output [31:0]	oREG_IN
	);
	
	
	wire [2:0] func3;
	wire [6:0] func7;
	wire [9:0] func37;
	wire [31:0] alu_in1,alu_in2,alu_out,slt_wire,sltu_wire;
	
	assign oRD = iIR[11:7];
	assign oRS1 = iIR[19:15];
	assign oRS2 = iIR[24:20];
	assign func3 = iIR[14:12];
	assign func7 = iIR[31:25];
	
	assign alu_in1 = iREG_OUT1;
	assign alu_in2 = iREG_OUT2;
		
	assign func37 = {func3,func7};
	assign alu_out = (func37=={3'h0,7'h00}) ?   alu_in1 + alu_in2 :									// add
						  (func37=={3'h0,7'h20}) ?   alu_in1 - alu_in2 :									// sub
						  (func37=={3'h4,7'h00}) ?   alu_in1 ^ alu_in2 : 									// xor
						  (func37=={3'h6,7'h00}) ?   alu_in1 | alu_in2 :									// or
						  (func37=={3'h7,7'h00}) ?   alu_in1 & alu_in2 :									// and
						  (func37=={3'h1,7'h00}) ?   alu_in1 << alu_in2 :									// sll (shift left logical)
						  (func37=={3'h5,7'h00}) ?   alu_in1 >> alu_in2 :									// srl (shift right logical)
						  (func37=={3'h5,7'h20}) ?   alu_in1 >>> alu_in2 :									// sra (shift right arithmetic)
						  (func37=={3'h2,7'h00}) ?   $signed(alu_in1) < $signed(alu_in2) ? 1 : 0 :	// slt (set less than, signed)
						  (func37=={3'h3,7'h00}) ?   alu_in1 < alu_in2 ? 1 : 0 :							// sltu (set less than, unsigned)
						  32'h00000000 ;
	
	assign oREG_IN = alu_out;
	
	always @(posedge iCLK)
	begin
		//if(iIR[6:0]==7'h33)
		//	$display("INSRUCTION TYPE R -> alu_in1: 0x%x, alu_in2: 0x%x, alu_out: 0x%x",alu_in1, alu_in2, alu_out);
	end
	
endmodule
