`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:55:42 10/16/2016
// Design Name:   P2S
// Module Name:   C:/Users/Fatemeh/Documents/ISEproject/hw1/p2s_tb.v
// Project Name:  hw1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: P2S
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module p2s_tb;

	// Inputs
	reg [15:0] i_P2S;
	reg i_clk;
	reg i_enable;

	// Outputs
	wire o_P2S;

	// Instantiate the Unit Under Test (UUT)
	P2S uut (
		.i_P2S(i_P2S), 
		.i_clk(i_clk), 
		.i_enable(i_enable), 
		.o_P2S(o_P2S)
	);

	initial begin
		// Initialize Inputs
		i_P2S = 16'b 1100110011001100;;
		i_clk = 0;
		i_enable = 1;

		// Wait 100 ns for global reset to finish
		
        
		// Add stimulus here

	end
	always
	#10 i_clk = ~i_clk;  
      
endmodule

