
module memory_ram_mux (
	input	 [6:0]		iOpcode,
	input				CLK,
	output				RAM_WR,
	output				RAM_RD,
	
	input				i_A_RAM_CE,     	// Chip Enable
	input 				i_A_RAM_RD, 		// Read Enable
	input 				i_A_RAM_WR, 		// Write Enable
	input [31:0]		i_A_RAM_ADDR, 		// RAM Address
	output  [31:0]		o_A_RAM_DATA_RD,	// RAM Data Read
	input [31:0]		i_A_RAM_DATA_WR, 	// RAM Data Write
	
	
	input				i_B_RAM_CE,     	// Chip Enable
	input 				i_B_RAM_RD, 		// Read Enable
	input 				i_B_RAM_WR, 		// Write Enable
	input [31:0]		i_B_RAM_ADDR, 		// RAM Address
	output  [31:0]		o_B_RAM_DATA_RD,	// RAM Data Read
	input [31:0]		i_B_RAM_DATA_WR, 	// RAM Data Write

	input				i_C_RAM_CE,     	// Chip Enable
	input 				i_C_RAM_RD, 		// Read Enable
	input 				i_C_RAM_WR, 		// Write Enable
	input [31:0]		i_C_RAM_ADDR, 		// RAM Address
	output  [31:0]		o_C_RAM_DATA_RD,	// RAM Data Read
	input [31:0]		i_C_RAM_DATA_WR, 	// RAM Data Write
	
	output				o_X_RAM_CE,     	// Chip Enable
	output 				o_X_RAM_RD, 		// Read Enable
	output 				o_X_RAM_WR, 		// Write Enable
	output [31:0]		o_X_RAM_ADDR, 		// RAM Address
	input  [31:0]		i_X_RAM_DATA_RD,	// RAM Data Read
	output [31:0]		o_X_RAM_DATA_WR 	// RAM Data Write
	);

   
	assign o_X_RAM_CE = 	i_A_RAM_CE | i_B_RAM_CE	| i_C_RAM_CE;
	assign o_X_RAM_RD = 	i_A_RAM_RD | i_B_RAM_RD	| i_C_RAM_RD;
	assign o_X_RAM_WR = 	i_A_RAM_WR | i_B_RAM_WR	| i_C_RAM_WR;
	
	assign o_X_RAM_ADDR = 	(iOpcode==7'h03) ?   i_A_RAM_ADDR :
							(iOpcode==7'h23) ?   i_B_RAM_ADDR :
							(iOpcode==7'h37 | iOpcode==7'h17) ?   i_C_RAM_ADDR :
							32'h0 ;
									
	assign o_X_RAM_DATA_WR = 	(iOpcode==7'h03) ?	i_A_RAM_DATA_WR :
								(iOpcode==7'h23) ?  i_B_RAM_DATA_WR :
								(iOpcode==7'h37 | iOpcode==7'h17) ?  i_C_RAM_DATA_WR :
								32'h0 ;		  

	assign o_A_RAM_DATA_RD = (iOpcode==7'h03) ?   i_X_RAM_DATA_RD : 32'h0 ;
	assign o_B_RAM_DATA_RD = (iOpcode==7'h23) ?   i_X_RAM_DATA_RD : 32'h0 ;
	assign o_C_RAM_DATA_RD = (iOpcode==7'h37 | iOpcode==7'h17) ?   i_X_RAM_DATA_RD : 32'h0 ;
	
	assign RAM_RD = (iOpcode==7'h03) ? 1: 0 ;
	assign RAM_WR = ~RAM_RD;
	// //assign RAM_WR = (iOpcode==7'h23) ? 1: 0 ;
	// always @(posedge CLK)
	// begin
	// 	$display("data bacaan = 0x%x",i_X_RAM_DATA_RD);
	// end


endmodule


