`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:03 10/26/2016 
// Design Name: 
// Module Name:    BCDToSeg 
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
module BCDToSeg(
	input [3:0] i_BCDInput,
	output reg [6:0] o_segOutput
    );
	 always @ (i_BCDInput)
	 begin
		 case(i_BCDInput)
				0: o_segOutput <= 7'b1110111;
				1: o_segOutput <= 7'b0100100;
				2: o_segOutput <= 7'b0011111;
				3: o_segOutput <= 7'b0111110;
				4: o_segOutput <= 7'b1101100;
				5: o_segOutput <= 7'b1111010;
				6: o_segOutput <= 7'b1111011;
				7: o_segOutput <= 7'b0110100;
				8: o_segOutput <= 7'b1111111;
				9: o_segOutput <= 7'b1111110;
				
			endcase
		end


endmodule
