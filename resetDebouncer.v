`timescale 1ns / 1ps


module resetDebouncer(i_reset,i_clk,i_pcIn,o_pcOut);
input i_reset,i_clk;
input[7:0] i_pcIn;
output reg[7:0] o_pcOut;

reg [31:0] counter1_reset;
reg [31:0] counter2_reset;
reg [31:0] counter_debug;
reg flag1;
reg flag2;
initial 
begin 
	flag1=0;
	flag2=0;
	counter1_reset = 32'b0;
	counter2_reset = 32'b0;
end

always@(posedge i_clk)
begin
	//if(o_resetPc == 0)
	//	o_resetPc <= 1;
	
		
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
				flag1 = 1;
				
			end
		//	o_resetPc <= 1;	
		end
		else
		if(i_reset == 1)
		begin
			if(flag1==1)
			begin
				if(counter2_reset<500000)
					begin
						counter2_reset = counter2_reset+1;
				//		o_resetPc <= 1;
					end
				else
				begin
					counter2_reset = 0;
				//	o_resetPc <= 0;
				//	flag1=0;
					flag2=1;
				end
			end
			else
				counter1_reset = 0;
			
		end
		if(flag1 && flag2)
			begin 
				o_pcOut = 0;
				flag1 = 0;
				flag2 = 0;
			end
			else
			o_pcOut = i_pcIn;
			
end



endmodule
