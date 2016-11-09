`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:16:52 11/03/2016
// Design Name:   deBounce
// Module Name:   C:/Users/Fatemeh/Documents/ISEproject/hw1/debounceTb.v
// Project Name:  hw1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: deBounce
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module debounceTb;

	// Inputs
	reg i_reset;
	reg i_clk;
	wire[7:0] pc;
	reg temp;
	// Outputs
	wire o_resetPc;

	// Instantiate the Unit Under Test (UUT)
	deBounce uut (
		.i_reset(i_reset), 
		.i_clk(i_clk), 
		.o_resetPc(o_resetPc)
	);
	
	
	//////
	setPc uut1 (
		.i_reset(temp), 
		.i_incPc(o_resetPc), 
		.i_pcIn(pc), 
		.o_pcOut(pc)
	);

	initial begin
		// Initialize Inputs
		i_reset = 1;
		i_clk = 0;
		temp = 0;
		//pc = 8'b0;
		#9 i_reset = 0;
		#20 i_reset = 1;
		#19 i_reset = 0;
		#36 i_reset = 1;
		#17 i_reset = 0;
		#63 i_reset = 1;
		#63 i_reset = 0;
		#30 i_reset = 1;
		#37 i_reset = 0;
		#58 i_reset = 1;
		#65 i_reset = 0;
		#20 i_reset = 1;
		#70 temp = 1;
		#20 temp = 0;
		
	end

		always 
			#5 i_clk = ~i_clk; 
      
endmodule

