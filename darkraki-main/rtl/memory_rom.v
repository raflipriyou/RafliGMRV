

module memory_rom
	#(
		parameter ROM_ORIGIN  = 32'h0,			// ROM Memory Map
		parameter ROM_LENGTH  = 32'h10000,	// ROM size 64 KB
		parameter MEM_BIT		 = 32,
		parameter MEM_SIZE	 = 1024
	)
	(
	input					iROM_CLK,				// input clock
	output [31:0]	oROM_DATA, 			// output Data
	input					iROM_CE,     		// input Chip Enable
	input 				iROM_RD, 				// input Read Enable
	input [31:0]	iROM_ADDR 			// input Address
	);

   
	reg  [31:0] mem [0:MEM_SIZE-1];	//memory size 256*4 bytes = 1KB
	wire [MEM_BIT-1:0]  tmp_addr;
	wire [31:0] tmp_data;
	wire 			is_mem_valid;
	
	assign is_mem_valid	= ((iROM_ADDR >= ROM_ORIGIN) & (iROM_ADDR < ROM_ORIGIN + ROM_LENGTH)) ? 1 : 0;
	assign tmp_addr 		= (iROM_ADDR - ROM_ORIGIN) >> 2;
	assign tmp_data 		= (iROM_CE && iROM_RD) ? mem[tmp_addr] : 32'h0;
	assign oROM_DATA 		= (is_mem_valid == 1) ? tmp_data : 32'h0;


	initial begin
	  //$readmemh("/home/raflipriyou/darkraki-main/src/darksocv.mem", mem, 0, MEM_SIZE-1);
	  //$readmemh("/home/raflipriyou/darkraki-main/rtl/memory_rom_init.hex", mem, 0, MEM_SIZE-1);
	  //$readmemh("/home/raflipriyou/darkraki-main/src/asembli/asembli.mem", mem, 0, MEM_SIZE-1);
	  $readmemh("/home/raflipriyou/darkraki-main/src/fibonacci/tester.mem", mem, 0, MEM_SIZE-1);
	end

	
	always @(posedge iROM_CLK)
	begin
		$display("ROM -> CE: %b, RD: %b, iROM_ADDR: 0x%x, oROM_DATA: 0x%x",iROM_CE, iROM_RD, iROM_ADDR, oROM_DATA);		
	end
	

endmodule


