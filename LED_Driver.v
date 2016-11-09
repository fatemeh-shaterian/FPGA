`timescale 1ns / 1ps

module LED_Driver(
	input [15:0] i_data ,
	input i_clk,
	output reg o_LEDdata,
	output reg o_LEDlatch
	);
	
	reg[15:0] temp ;
	reg[4:0] i;
	initial 
	begin
		i = 5'b00000;
		o_LEDlatch = 1'b1;
		temp = 16'b0;
	end

		
	always @(negedge i_clk)
	begin
		temp <= {i_data[7:0],i_data[15:8]};
		
		if(i==16)
		begin
			//i_enable = 1'b0;
			i = 0;			
			o_LEDlatch = 1'b0;
			o_LEDdata <=1'b 0;
		end	
		//if ( i < 16)
		else
		begin
			i = i+1;
			//i_enable = 1'b1;
			o_LEDdata <= temp[0];
			temp <= temp >> 1;			
			o_LEDlatch = 1'b1;			
		end		
	end
endmodule
