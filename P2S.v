`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:46:39 10/16/2016 
// Design Name: 
// Module Name:    P2S 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module P2S(
	input [15:0] i_P2S ,
	input i_clk ,
	input i_enable,
	output reg o_P2S);
	
	reg [15:0] middelWire;
	integer i;
	initial
	begin 
		middelWire = 0;
		i = 0;
		o_P2S = 1'b0;
	end
	
	always @(posedge i_clk)  
	begin
	if(i == 0)
	begin
		middelWire = i_P2S;
		i = i+1;
	end
	if(i_enable)
		begin
			o_P2S = middelWire[0];
			middelWire = middelWire >> 1;
		end
	end
	
endmodule