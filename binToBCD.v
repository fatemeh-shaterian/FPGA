`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:00 10/26/2016 
// Design Name: 
// Module Name:    binToBCD 
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
module binToBCD(number, thousands, hundreds, tens, ones);
 input  [12:0] number;
   output reg [3:0] thousands;
   output reg [3:0] hundreds;
   output reg [3:0] tens;
   output reg [3:0] ones;
   
   // Internal variable for storing bits
   reg [28:0] shift;
   integer i;
   
   always @(number)
   begin
      // Clear previous number and store new number in shift register
      shift[28:13] = 0;
      shift[12:0] = number;
      
      // Loop eight times
      for (i=0; i<13; i=i+1) 
	  begin
         if (shift[16:13] >= 5)
            shift[16:13] = shift[16:13] + 3;
            
         if (shift[20:17] >= 5)
            shift[20:17] = shift[20:17] + 3;
            
         if (shift[24:21] >= 5)
            shift[24:21] = shift[24:21] + 3;
			
		 if (shift[28:25] >= 5)
			shift[28:25] = shift[28:25] + 3;
	  	
         
         // Shift entire register left once
         shift = shift << 1;
      end
      
      // Push decimal numbers to output
	  thousands= shift[28:25];
      hundreds = shift[24:21];
      tens     = shift[20:17];
      ones     = shift[16:13];
   end
 
endmodule
