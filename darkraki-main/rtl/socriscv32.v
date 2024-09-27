`include "/home/raflipriyou/darkraki-main/rtl/riscv_32i_ia.v"
`include "/home/raflipriyou/darkraki-main/rtl/memory_rom.v"
`include "/home/raflipriyou/darkraki-main/rtl/memory_ram.v"
`include "/home/raflipriyou/darkraki-main/rtl/darkuart.v"

module socriscv32(
	input						iRST,
	input						iCLK,
	
	//input [1:0]			iMode,
	//input [7:0]			iSW,
	output [31:0] 	oREG32,
	input [31:0] iROM_DATA,
	input [31:0] iRAM_DATA,

	input		UART_RXD,
	input		UART_TXD,

	output		DEBUG
	);

	wire rom_ce,rom_rd,ram_ce,ram_rd,ram_wr;
	wire [31:0] rom_address,ram_address, datao;
	wire [31:0] rom_data,ram_read_data,ram_write_data;

	wire finishreq, irq;


	memory_rom u1 (
		.iROM_CLK(iCLK),						// input clock
		.iROM_ADDR(rom_address), 		// ROM Address
		.oROM_DATA(rom_data), 			// ROM Data
		.iROM_RD(rom_rd), 					// Read Enable
		.iROM_CE(rom_ce)      			// Chip Enable
	);

	memory_ram u2 (
		.iRAM_CLK(iCLK),						// input clock
		.iRAM_CE(ram_ce),     			// input Chip Enable
		.iRAM_RD(ram_rd), 					// input Read Enable
		.iRAM_WR(ram_wr), 					// input Write Enable
		.iRAM_ADDR(ram_address), 		// input Address
		.oRAM_DATA(ram_read_data), 	// output RAM Data
		.iRAM_DATA(ram_write_data) 	// input RAM Data
	);

	riscv_32i_ia core0(
		.iCLK(iCLK),
		.iRST(iRST),
		
		.oROM_CE(rom_ce),
		.oROM_RD(rom_rd),
		.oROM_ADDR(rom_address),
		.iROM_DATA(rom_data),
		
		.oRAM_CE(ram_ce),
		.oRAM_RD(ram_rd),
		.oRAM_WR(ram_wr),
		.oRAM_ADDR(ram_address),
		.iRAM_DATA(ram_read_data),
		.oRAM_DATA(ram_write_data)
	);
	// darkuart masih cukup ngasal ini, harus dicek lagi!!!
	darkuart u11(
		.CLK(iCLK),
		.RES(iRST),

		.RD(rom_rd),
		.WR(ram_wr),
		.BE(),

		.DATAI(ram_read_data),
		.DATAO(datao),

		.FINISH_REQ(finishreq),
		.DEBUG(UART_TXD),
		.IRQ(irq),

		.RXD(UART_RXD),
		.TXD(UART_TXD)
	);

endmodule
