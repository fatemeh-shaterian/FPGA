`timescale 1ns / 1ps

module DIP_Driver(
	input i_clk,
	input i_DIPData,
	output reg o_DIPLatch,
	output reg[15:0] o_Data,
	output reg[4:0] o_pushB
    );

	reg[20:0] temp ;
	reg[15:0] temp2;
	reg[4:0] temp3;
	reg[4:0] i;
	reg[4:0] i2;
	initial 
	begin
		i = 5'b00000;
		o_DIPLatch = 1'b1;
		temp = 16'b0;
		o_Data = 16'b0;
		i2 = 5'b00000;
		temp3 = 5'b00000;
	end	
	
	always @(posedge i_clk)
	begin
		if(i==21)
		begin
			i = 0;			
			o_DIPLatch = 1'b0;
			temp2 = {temp[7:0],temp[15:8]};
			for(i2=0;i2<16;i2=i2+1)
			begin
				o_Data[i2] = temp2[15-i2];				
			end
			temp3 = temp[20:16];
			o_pushB = temp3;
 			//o_Data = {temp[7:0],temp[15:8]};
			//o_Data = {temp[15:8],temp[7:0]}; wrong!!!!
		end	
		else
		begin
			temp[i] <= i_DIPData;
			i = i+1;			
			o_DIPLatch = 1'b1;			
		end		
	end
endmodule