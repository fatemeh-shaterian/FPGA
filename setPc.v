`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:18 10/30/2016 
// Design Name: 
// Module Name:    setPc 
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
module setPc(i_reset,i_incPc,i_pcIn,o_pcOut);
input i_reset,i_incPc;
input [7:0] i_pcIn;
output reg[7:0]o_pcOut;

initial o_pcOut = 0;

always@(negedge i_incPc)// or posedge i_reset)
begin
	

	if (i_incPc == 0)
		o_pcOut <= i_pcIn +1 ;
	
	if(i_reset == 1)
		o_pcOut <= 0;
	//it goes there
	
end

endmodule
