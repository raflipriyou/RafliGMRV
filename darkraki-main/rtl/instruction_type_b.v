
module instruction_type_b(
	input				iCLK,
	input	 [31:0]	iIR,
	input	 [31:0]	iREG_OUT1,
	input	 [31:0]	iREG_OUT2,
	output [4:0] 	oRS1,
	output [4:0] 	oRS2,
	output [31:0]  oPCBR
	);
	
	wire [4:0] imm5;
	wire [2:0] func3;
	wire [6:0] imm7;
	wire signed	[31:0] imm12;
	wire [31:0] alu_in1,alu_in2,alu_out;

	// wire imm5a, imm7a;
	// wire [3:0] imm5b;
	// wire [5:0] imm7b;
	
	//decode instruction
	// assign imm5a  = iIR[4:1];
	// assign imm5b  = iIR[11];
	// assign imm5  = {imm5a, imm5b};
	assign imm5  = iIR[11:7];

	assign func3 = iIR[14:12];
	assign oRS1  = iIR[19:15];
	assign oRS2  = iIR[24:20];

	// assign imm7a  = iIR[12];
	// assign imm7b  = iIR[10:5];
	// assign imm7	  = {imm7a, imm7b};
	assign imm7  = iIR[31:25];
	
	assign alu_in1 = iREG_OUT1;
	assign alu_in2 = iREG_OUT2;
		
	assign imm12 = {{20{iIR[31]}},iIR[7],iIR[30:25],iIR[11:8],1'b0};
	assign alu_out = (func3=={3'h0}) ? (alu_in1==alu_in2) ? imm12 : 32'h0 :	// beq
						  (func3=={3'h1}) ? (alu_in1!=alu_in2) ? imm12 : 32'h0 :	// bne
						  (func3=={3'h4}) ? (alu_in1<alu_in2) ? imm12 : 32'h0 :	// blt
						  (func3=={3'h5}) ? (alu_in1>=alu_in2) ? imm12 : 32'h0 :	// bge
						  (func3=={3'h6}) ? (alu_in1<alu_in2) ? imm12 : 32'h0 :	// bltu
						  (func3=={3'h7}) ? (alu_in1>=alu_in2) ? imm12 : 32'h0 :	// bgeu
						  32'h0;
	
	assign oPCBR = alu_out;
	
	always @(posedge iCLK)
	begin
		//if(iIR[6:0]==7'h33)
		//	$display("INSRUCTION TYPE R -> alu_in1: 0x%x, alu_in2: 0x%x, alu_out: 0x%x",alu_in1, alu_in2, alu_out);
	end
	
endmodule
