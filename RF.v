`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:59 11/09/2016 
// Design Name: 
// Module Name:    RF 
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
module RF(i_addr1,i_addr2,i_addrwr,i_rw,i_dataIn,i_clk,o_data1,o_data2); //i_rw - 0 read 1 write

input [2:0] i_addr1,i_addr2,i_addrRw;
input [8:0] data_in;
input i_clk;
input i_rw; // who have to give this input??????????????????????????

output reg [7:0] o_data1;
output reg [7:0] o_data2;


reg [7:0] r0;
reg [7:0] r1;
reg [7:0] r2;
reg [7:0] r3;
reg [7:0] r4;
reg [7:0] r5;
reg [7:0] r6;
reg [7:0] r7;

initial
begin
	r0 = 8'b0;
	r1 = 8'b0;
	r2 = 8'b0;
	r3 = 8'b0;
	r4 = 8'b0;
	r5 = 8'b0;
	r6 = 8'b0;
	r7 = 8'b0;
end

always@(i_addr1 or i_addr2)
begin
	if(i_rw == 0)
	begin
		case (i_addr1)
			0: o_data1 = r0;
			1: o_data1 = r1;
			2: o_data1 = r2;
			3: o_data1 = r3;
			4: o_data1 = r4;
			5: o_data1 = r5;
			6: o_data1 = r6;
			7: o_data1 = r7;
		endcase
		
		case (i_addr2)
			0: o_data2 = r0;
			1: o_data2 = r1;
			2: o_data2 = r2;
			3: o_data2 = r3;
			4: o_data2 = r4;
			5: o_data2 = r5;
			6: o_data2 = r6;
			7: o_data2 = r7;
		endcase
	end
end

always @(i_clk)
begin 
	if(i_rw == 1)
	begin 
	case (i_addrRw)
		0: r0 = i_dataIn;
		1: r1 = i_dataIn;
		2: r2 = i_dataIn;
		3: r3 = i_dataIn;
		4: r4 = i_dataIn;
		5: r5 = i_dataIn;
		6: r6 = i_dataIn;
		7: r7 = i_dataIn;
	endcase
		
	end
end
endmodule
