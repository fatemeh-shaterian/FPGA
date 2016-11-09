`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:08:20 11/01/2016
// Design Name:   setPc
// Module Name:   C:/Users/Fatemeh/Documents/ISEproject/hw1/setPcTest.v
// Project Name:  hw1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: setPc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module setPcTest;

	// Inputs
	reg i_reset;
	reg i_incPc;
	reg [7:0] i_pcIn;

	// Outputs
	wire [7:0] o_pcOut;

	// Instantiate the Unit Under Test (UUT)
	setPc uut (
		.i_reset(i_reset), 
		.i_incPc(i_incPc), 
		.i_pcIn(i_pcIn), 
		.o_pcOut(o_pcOut)
	);

	initial begin
		// Initialize Inputs
		i_reset = 0;
		i_incPc = 0;
		i_pcIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		i_reset = 1;
		i_incPc = 0;
		i_pcIn = 0;
		
		#10
		i_reset = 1;
		i_incPc = 1;
		i_pcIn = i_pcIn;

#10
		i_reset = 1;
		i_incPc = 0;
		i_pcIn = i_pcIn;
#10
		i_reset = 1;
		i_incPc = 1;
		i_pcIn = i_pcIn;
#10
		i_reset = 1;
		i_incPc = 0;
		i_pcIn = i_pcIn;
#10
		i_reset = 1;
		i_incPc = 1;
		i_pcIn = i_pcIn;
#10
		i_reset = 1;
		i_incPc = 0;
		i_pcIn = i_pcIn;
#10
		i_reset = 1;
		i_incPc = 1;
		i_pcIn = i_pcIn;
#10
		i_reset = 1;
		i_incPc = 0;
		i_pcIn = i_pcIn;
		

	end
      
endmodule

