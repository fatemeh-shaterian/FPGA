`timescale 1ns / 1ps


module deBounce(i_reset,i_inc,i_clk,i_pc,o_pc
,i_isTakenJump,i_jumpAddr);
input i_reset,i_clk,i_inc;
input[7:0]i_pc;
output reg [7:0] o_pc;

reg [31:0] counter1_reset;
reg [31:0] counter2_reset;
reg flag1_reset;
reg flag2_reset;

reg [31:0] counter1_inc;
reg [31:0] counter2_inc;
reg flag1_inc;
reg flag2_inc;

//////////////
input i_isTakenJump;
input[7:0] i_jumpAddr;


initial 
begin 
	flag1_reset=0;
	flag2_reset=0;
	counter1_reset = 32'b0;
	counter2_reset = 32'b0;

	////////////////////////
	flag1_inc=0;
	flag2_inc=0;
	counter1_inc = 32'b0;
	counter2_inc = 32'b0;
	
end

always@(posedge i_clk)
begin
		if(i_reset == 0)
		begin
			counter2_reset = 0;
			if(counter1_reset <500000)
				begin
					counter1_reset = counter1_reset +1;					
				end
			else
			begin
				counter1_reset = 0;
				flag1_reset = 1;
			end
		end
		else
		if(i_reset == 1)
		begin
			if(flag1_reset==1)
			begin
				if(counter2_reset<500000)
				begin
					counter2_reset = counter2_reset+1;
				end
				else
				begin
					counter2_reset = 0;
					flag2_reset=1;
				end
			end
			else
				counter1_reset = 0;		
		end
		

////////////////////////////////////			

	if(i_inc == 0)
		begin
			counter2_inc = 0;
			if(counter1_inc <500000)
				begin
					counter1_inc = counter1_inc +1;					
				end
			else
			begin
				counter1_inc = 0;
				flag1_inc = 1;
			end
		end
		else
		if(i_inc == 1)
		begin
			if(flag1_inc==1)
			begin
				if(counter2_inc<500000)
				begin
					counter2_inc = counter2_inc+1;
				end
				else
				begin
					counter2_inc = 0;
					flag2_inc=1;
				end
			end
			else
				counter1_inc = 0;		
		end
		if(flag1_inc && flag2_inc)
			begin 
				if(i_isTakenJump == 1)
				begin 
					o_pc = i_jumpAddr;
				end
				else
				begin 
					o_pc = i_pc + 1;
				end
				///
				
				flag1_inc = 0;
				flag2_inc = 0;
			end
			else
			
		///////////////
		if(flag1_reset && flag2_reset)
			begin 
				o_pc = 0;
				
				///
				
				flag1_reset = 0;
				flag2_reset = 0;
			end
			else
			o_pc = i_pc;

			///			
end



endmodule
