`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:14 10/17/2016 
// Design Name: 
// Module Name:    piso_led 
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
module piso_led(
	input [15:0] led_in,
	input clk,
	output reg out,
	output reg Latch
	);

reg [15:0] temp ;
reg [4:0] counter;
initial
begin
 counter=5'b0;
 Latch=1;
 temp=16'b0;

end
always@(negedge clk)

begin
   temp<={led_in[7:0],led_in[15:8]};

if(counter==16)
 begin 
   counter=0;
	Latch=0;
	out<=1'b 0;
 end
 else
 begin
	out <= temp[0];
	temp <= temp >> 1'b1;
	Latch=1;
	counter=counter+1;
 end
 
end
endmodule 