`timescale 1ns / 1ps

module testBench;

	// Inputs
	reg [15:0] i_data;
	reg i_clk;
	
	
	// Outputs
	wire o_LEDdata;
	wire o_LEDlatch;

	// Instantiate the Unit Under Test (UUT)
	LED_Driver uut (
		.i_data(i_data), 
		.i_clk(i_clk), 
		.o_LEDdata(o_LEDdata), 
		.o_LEDlatch(o_LEDlatch)
	);

	initial
	begin
		// Initialize Inputs
		i_data = 16'b 0000000011111111;
		i_clk = 0;

		// Wait 100 ns for global reset to finish
		
		// Add stimulus here

	end
	always
	#10 i_clk = ~i_clk;   

      
endmodule
	
