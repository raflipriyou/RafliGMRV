
module register_file_mux 
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
	input				CLK,
	input	[6:0]		iOpcode,
	input  [4:0]		i_A_RD,
	input  [4:0]		i_A_RS1,
	input  [4:0]		i_A_RS2,
	output [31:0]		o_A_REG_OUT1,
	output [31:0]		o_A_REG_OUT2,
	input  [31:0]		i_A_REG_IN,
	
	input  [4:0]		i_B_RD,
	input  [4:0]		i_B_RS1,
	input  [4:0]		i_B_RS2,
	output [31:0]		o_B_REG_OUT1,
	output [31:0]		o_B_REG_OUT2,
	input  [31:0]		i_B_REG_IN,
	
	input  [4:0]		i_C_RD,
	input  [4:0]		i_C_RS1,
	input  [4:0]		i_C_RS2,
	output [31:0]		o_C_REG_OUT1,
	output [31:0]		o_C_REG_OUT2,
	input  [31:0]		i_C_REG_IN,
	
	input  [4:0]		i_D_RD,
	input  [4:0]		i_D_RS1,
	input  [4:0]		i_D_RS2,
	output [31:0]		o_D_REG_OUT1,
	output [31:0]		o_D_REG_OUT2,
	input  [31:0]		i_D_REG_IN,
	
	input  [4:0]		i_E_RD,
	input  [4:0]		i_E_RS1,
	input  [4:0]		i_E_RS2,
	output [31:0]		o_E_REG_OUT1,
	output [31:0]		o_E_REG_OUT2,
	input  [31:0]		i_E_REG_IN,
	
	input  [4:0]		i_F_RD,
	input  [4:0]		i_F_RS1,
	input  [4:0]		i_F_RS2,
	output [31:0]		o_F_REG_OUT1,
	output [31:0]		o_F_REG_OUT2,
	input  [31:0]		i_F_REG_IN,
	
	output [4:0]		o_X_RD,
	output [4:0]		o_X_RS1,
	output [4:0]		o_X_RS2,
	input  [31:0]		i_X_REG_OUT1,
	input  [31:0]		i_X_REG_OUT2,
	output [31:0]		o_X_REG_IN

	);
	
	assign o_X_RD = 		(iOpcode==OPCODE_R) ?   i_A_RD :
							(iOpcode==OPCODE_I1 | iOpcode==OPCODE_I2 | iOpcode==OPCODE_I3) ?   i_B_RD :
							(iOpcode==OPCODE_S) ?   i_C_RD :
							(iOpcode==OPCODE_U1 | iOpcode==OPCODE_U2)?   i_D_RD :
							(iOpcode==OPCODE_B) ?   i_E_RD :
							(iOpcode==OPCODE_J) ?   i_F_RD :
							5'h0 ;
							
	assign o_X_RS1 = 	(iOpcode==OPCODE_R) ?   i_A_RS1 :
							(iOpcode==OPCODE_I1 | iOpcode==OPCODE_I2 | iOpcode==OPCODE_I3) ?   i_B_RS1 :
							(iOpcode==OPCODE_S) ?   i_C_RS1 :
							(iOpcode==OPCODE_U1 | iOpcode==OPCODE_U2) ?   i_D_RS1 :
							(iOpcode==OPCODE_B) ?   i_E_RS1 :
							(iOpcode==OPCODE_J) ?   i_F_RS1 :
							5'h0 ;
						  
	assign o_X_RS2 = 	(iOpcode==OPCODE_R) ?   i_A_RS2 :
							(iOpcode==OPCODE_I1 | iOpcode==OPCODE_I2 | iOpcode==OPCODE_I3) ?   i_B_RS2 :
							(iOpcode==OPCODE_S) ?   i_C_RS2 :
							(iOpcode==OPCODE_U1 | iOpcode==OPCODE_U2) ?   i_D_RS2 :
							(iOpcode==OPCODE_B) ?   i_E_RS2 :
							(iOpcode==OPCODE_J) ?   i_F_RS2 :
							5'h0 ;
						  
	assign o_A_REG_OUT1 = (iOpcode==OPCODE_R) ?   i_X_REG_OUT1 : 32'h0 ;
	assign o_B_REG_OUT1 = (iOpcode==OPCODE_I1 | iOpcode==OPCODE_I2 | iOpcode==OPCODE_I3) ?   i_X_REG_OUT1 : 32'h0 ;
	assign o_C_REG_OUT1 = (iOpcode==OPCODE_S) ?   i_X_REG_OUT1 : 32'h0 ;
	assign o_D_REG_OUT1 = (iOpcode==OPCODE_U1 | iOpcode==OPCODE_U2) ?   i_X_REG_OUT1 : 32'h0 ;
	assign o_E_REG_OUT1 = (iOpcode==OPCODE_B) ?   i_X_REG_OUT1 : 32'h0 ;
	assign o_F_REG_OUT1 = (iOpcode==OPCODE_J) ?   i_X_REG_OUT1 : 32'h0 ;
								
	assign o_A_REG_OUT2 = (iOpcode==OPCODE_R) ?   i_X_REG_OUT2 : 32'h0 ;
	assign o_B_REG_OUT2 = (iOpcode==OPCODE_I1 | iOpcode==OPCODE_I2 | iOpcode==OPCODE_I3) ?   i_X_REG_OUT2 : 32'h0 ;
	assign o_C_REG_OUT2 = (iOpcode==OPCODE_S) ?   i_X_REG_OUT2 : 32'h0 ;
	assign o_D_REG_OUT2 = (iOpcode==OPCODE_U1 | iOpcode==OPCODE_U2) ?   i_X_REG_OUT2 : 32'h0 ;
	assign o_E_REG_OUT2 = (iOpcode==OPCODE_B) ?   i_X_REG_OUT2 : 32'h0 ;
	assign o_F_REG_OUT2 = (iOpcode==OPCODE_J) ?   i_X_REG_OUT2 : 32'h0 ;
						  
	assign o_X_REG_IN = 	(iOpcode==OPCODE_R) ?   i_A_REG_IN :
								(iOpcode==OPCODE_I1 | iOpcode==OPCODE_I2 | iOpcode==OPCODE_I3) ?   i_B_REG_IN :
								(iOpcode==OPCODE_S) ?   i_C_REG_IN :
								(iOpcode==OPCODE_U1 | iOpcode==OPCODE_U2) ?   i_D_REG_IN :
								(iOpcode==OPCODE_B) ?   i_E_REG_IN :
								(iOpcode==OPCODE_J) ?   i_F_REG_IN :
								32'h0 ;
	
	always @(posedge CLK)
	begin
		$display("data di mux = 0x%x", i_X_REG_OUT2);
	end

endmodule
