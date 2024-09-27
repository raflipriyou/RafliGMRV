/*
 * Copyright (c) 2018, Marcelo Samsoniuk
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * 
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * 
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 */

//`timescale 1ns / 1ps
`include "/home/raflipriyou/darkraki-main/rtl/conf.vh"
`include "/home/raflipriyou/darkraki-main/rtl/socriscv32.v"

// clock and reset logic

`define BOARD_CK 100000000

module darksimv;

    reg CLK = 0;
    reg RES = 1;
    //reg [31:0] iROM_DATA,iRAM_DATA;

    // initial while(1) #(500e6/`BOARD_CK) CLK = !CLK; // clock generator w/ freq defined by config.vh

    integer i, a;
    
    initial
    begin
`ifdef __ICARUS__
        $dumpfile("darksocv.vcd");
        $dumpvars();
        // iROM_DATA = 32'h0;
	    // iRAM_DATA = 32'h0;
    `ifdef __REGDUMP__
        for(i=0;i!=`RLEN;i=i+1)
        begin
            $dumpvars(0,soc0.core0.REGS[i]);
        end
    `endif
`endif

        $display("reset---- (startup)");
        // #100    RES = 0;
        for (a = 0; a <450; a = a+1 ) begin
			if(a == 10)
            begin
                RES = 0;
            end
            CLK=0;
			#1;
			CLK=1;	
			#1;	
		end

    end

    wire TX;
    wire RX = 1;

    socriscv32 soc0
    (
        .iCLK(CLK),
        .iRST(|RES),
        .UART_RXD(RX),
        .UART_TXD(TX)
    );

endmodule
