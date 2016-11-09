`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:23:21 10/26/2016 
// Design Name: 
// Module Name:    seg_driver 
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
module seg_driver(
input [12:0] i_segInput,
input i_clk,
output reg o_segLatch,
output reg o_segData
    );
	 wire[3:0] ones;
	 wire[3:0] tens;
	 wire[3:0] hundreds;
	 wire[3:0] thousands;
	 
	 wire[6:0] ones_seg;
	 wire[6:0] tens_seg;
	 wire[6:0] hundreds_seg;
	 wire[6:0] thousands_seg;	 
	 
	 reg[8:0] ones_control;
	 reg[8:0] tens_control;
	 reg[8:0] hundreds_control;
	 reg[8:0] thousands_control;

	
	reg[15:0] temp ;
	reg[15:0] ones_outputTemp;
	reg[15:0] tens_outputTemp;
	reg[15:0] hundreds_outputTemp;
	reg[15:0] thousands_outputTemp;
	reg[4:0] i;
	reg[1:0] state;
	initial 
	begin
		i = 5'b00000;
		o_segLatch = 1'b1;
		temp = 16'b0;
		ones_control = 9'b001000000;
	   tens_control = 9'b000100000;
	   hundreds_control = 9'b000001000;
	   thousands_control = 9'b000000100;
		//ones = 4'b0;
	   //tens = 4'b0;
		//hundreds = 4'b0;
	   //thousands = 4'b0;
		state = 2'b0;
	end
	
	binToBCD binaryToBCD(.number(i_segInput), .thousands(thousands), .hundreds(hundreds), .tens(tens), .ones(ones));
	BCDToSeg BCDToSeg1(.i_BCDInput(ones),.o_segOutput(ones_seg));
	BCDToSeg BCDToSeg2(.i_BCDInput(tens),.o_segOutput(tens_seg));
	BCDToSeg BCDToSeg3(.i_BCDInput(hundreds),.o_segOutput(hundreds_seg));
	BCDToSeg BCDToSeg4(.i_BCDInput(thousands),.o_segOutput(thousands_seg));
	always @(ones or tens or hundreds or thousands)
	begin
		ones_outputTemp = {ones_seg,ones_control};
		tens_outputTemp = {tens_seg,tens_control};
		hundreds_outputTemp = {hundreds_seg,hundreds_control};
		thousands_outputTemp = {thousands_seg,thousands_control};
		//ones_outputTemp = {ones_control,ones};
		//tens_outputTemp = {tens_control,tens};
		//hundreds_outputTemp = {hundreds_control,hundreds};
		//thousands_outputTemp = {thousands_control,thousands};
		
	end
	

	always @(negedge i_clk)
	begin
		case(state)
			0: temp <= ones_outputTemp;
			1: temp <= tens_outputTemp;
			2: temp <= hundreds_outputTemp;
			3: temp <= thousands_outputTemp;
		endcase
		//temp <= 16'b1111010000100000;
		
		if(i==16)
		begin
			//i_enable = 1'b0;
			i = 0;			
			o_segLatch = 1'b0;
			o_segData <=1'b 0;
			state = state+1;
		end	
		//if ( i < 16)
		else
		begin
			i = i+1;
			//i_enable = 1'b1;
			o_segData <= temp[0];
			temp <= temp >> 1;			
			o_segLatch = 1'b1;			
		end		
	end

	 /////
	 


endmodule
