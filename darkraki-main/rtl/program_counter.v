module program_counter
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
	input				iCLK,
	input				iRST,
	input	 [6:0]	iOpcode,
	input  [31:0] 	iPCBR_I,
	input  [31:0] 	iPCBR_B,
	input  [31:0] 	iPCBR_J,
	output [31:0] 	oPC
	);

	reg  [31:0] pc;
	wire [31:0] pcbranch,pc_next;
	
	initial
	begin
		pc = 0;
	end
	
	assign pcbranch = (iOpcode==OPCODE_I3) ? iPCBR_I:
							(iOpcode==OPCODE_B) ? iPCBR_B:
							(iOpcode==OPCODE_J) ? iPCBR_J:
							32'h0;
							
	assign oPC = pc;	

	// coba make if kalo pcbranch ngak 0, maka harus dihold dulu kayaknya
	// write code here	...	
	assign pc_next = 	(pcbranch==0) ? pc + 4:
							pc + pcbranch;
	
	always @(posedge iCLK or negedge iRST)
	begin
		if (iRST==0)
			begin
				pc = 0;
				$finish(); //kalo mau berenti make iRST =1 diuncomment aja
				//lalu untuk clocknya diedit di darksimv di folder sim
			end
		else
			begin
				pc <= pc_next;
				//$display("pc: 0x%x, pcbranch: 0x%x, pc_next: 0x%x",pc,pcbranch,pc_next);
				//$display("PC: 0x%x, IR: 0x%x, OPCODE: 0x%x, INSTRUCTION TYPE: %s",pc,ir,opcode,(opcode==7'h33) ? "R": (opcode==7'h13) ? "I1" : (opcode==7'h03) ? "I2" : (opcode==7'h23) ? "S" : "UNDEFINDED");
			end
	end


endmodule


