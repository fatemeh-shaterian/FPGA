`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:38 10/16/2016 
// Design Name: 
// Module Name:    LED_Correction 
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
module LED_Correction ( 
	input [15:0] in ,
	output reg [15:0] out 
	);
	integer i;
						
	always @(*)
	begin 
		for (i=0;i<8;i=i+1)
		begin
			out[i+8] = in [i] ;
			out[i] 	= in[i+8] ;
 		end
	end
endmodule