`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:00 11/09/2016 
// Design Name: 
// Module Name:    DEC 
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
module DEC_v1(i_inst,o_aluOp,o_in1,o_in2);
input [15:0] i_inst;
output [8:0] o_aluOp ; // 9bit
output [2:0]o_in1,o_in1;

assign o_aluOp = i_inst[14:6];
assign o_in1 = i_inst[5:3];
assign o_in1 = i_inst[2:0];
endmodule
