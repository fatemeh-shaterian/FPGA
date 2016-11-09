`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:52 11/09/2016 
// Design Name: 
// Module Name:    EXE 
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
module EXE(i_data1,i_data2,i_aluOp,o_res);
	input[7:0] i_data1,i_data2;
	input[8:0] i_aluOp;
	output reg[7:0] o_res;
	
	always@(i_data1 or i_data2 or i_aluOp)
	begin 
		if(i_aluOp == 000000001) // add 
		begin 
			o_res = i_data1+i_data2;
		end
		if(i_aluOp == 000000000) // nop
		begin 
		end
		if(i_aluOp == 000000010) // show
		begin 
			o_res = i_data1;
		end
	end


endmodule
