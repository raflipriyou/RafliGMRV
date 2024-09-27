`define __3STAGE__
`define __RV32E__

`define __RESETPC__ 32'd0

`define __PERFMETER__

//`define TESTMODE

//`ifdef __HARVARD__
    //`define MLEN 13 // MEM[12:0] ->  8KBytes LENGTH = 0x2000
//`else
`define MLEN 12 // MEM[12:0] -> 4KBytes LENGTH = 0x1000
    //`define MLEN 15 // MEM[12:0] -> 32KBytes LENGTH = 0x8000 for coremark!
//`endif

`ifdef __ICARUS__
    `define SIMULATION 1
`endif

`ifndef BOARD_ID
    `define BOARD_ID 0
    `define BOARD_CK 100000000
`endif

// darkuart baudrate automtically calculated according to board clock:

`ifndef __UARTSPEED__
  `define __UARTSPEED__ 115200
`endif

`define  __BAUD__ ((`BOARD_CK/`__UARTSPEED__))

`ifdef __RV32E__
    `define RLEN 16 // harga mati harus dieksekusi
`else
    `define RLEN 32
`endif