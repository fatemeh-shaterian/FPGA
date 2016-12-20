`timescale 1ns / 1ps

module DEC_v1(i_inst,o_aluOp,o_in1,o_in2, o_rw , o_msb, o_aluOp_1 , o_in_1, o_isJump , o_in_2 ,o_isLoad
					,o_isStore);
input [15:0] i_inst;

output [8:0] o_aluOp ; // 9bit
output[3:0] o_aluOp_1; //4bit
output[7:0] o_in_1;		// output for address jump and load and store
///////////////////
output[2:0] o_in_2;
///////////////////
output [2:0]o_in1,o_in2;
output o_rw;
output o_msb;
output reg o_isJump;
output reg o_isLoad;

output reg o_isStore;

assign o_aluOp = i_inst[14:6];
assign o_in1 = i_inst[5:3];
assign o_in2 = i_inst[2:0];
assign o_aluOp_1 = i_inst[14:11];
assign o_in_1 = i_inst[7:0];
assign o_in_2 = i_inst[10:8];
assign o_msb = i_inst[15];



assign o_rw = 	
					(o_aluOp_1 == 4'b0110)? 1 :		//Li
					(o_aluOp_1 == 4'b1001)? 1 :		//LDip
					(o_aluOp_1 == 4'b0111)? 1 :		//LM
					(o_aluOp_1 == 4'b1000)? 0 :		//store
					(o_aluOp == 9'b000000000)? 0 : 	//nop
					(o_aluOp == 9'b000000001)? 1 :	//add
					(o_aluOp == 9'b000000010)? 1 :	//and
					(o_aluOp == 9'b000000011)? 1 :	//sub
					(o_aluOp == 9'b000000100)? 1 :	//or
					(o_aluOp == 9'b000000101)? 1 :	//xor
					(o_aluOp == 9'b000000110)? 1 :	//move
					(o_aluOp == 9'b000001000)? 1 :	//not
					(o_aluOp == 9'b000001001)? 1 :	//SAR
					(o_aluOp == 9'b000001010)? 1 :	//SLR
					(o_aluOp == 9'b000001011)? 1 :	//SAL
					(o_aluOp == 9'b000001100)? 1 :	//SLL
					(o_aluOp == 9'b000001101)? 1 :	//ROL
					(o_aluOp == 9'b000001110)? 1 :	//ROR
					(o_aluOp == 9'b000001111)? 1 :	//INC	
					(o_aluOp == 9'b000010000)? 1 :	//DEC
					(o_aluOp == 9'b000001010)? 1 :	//SLR
					(o_aluOp == 9'b000010010)? 0 :	//showr
					(o_aluOp == 9'b000010011)? 0 :	//showrSeg
					(o_aluOp == 9'b000010100)? 1 : 
					0	//CMP
					;
					
					//(o_aluOp == 9'b000010010)? 0:0;		


always @(*)
begin 
	if((o_msb == 1) && (o_aluOp_1 < 6))
		begin
			o_isJump = 1;
			o_isLoad = 0;
			o_isStore = 0;
		end
	else if((o_msb == 1) && ((o_aluOp_1 == 6)||(o_aluOp_1 == 9) || (o_aluOp_1 == 7)))
		begin
			o_isJump = 0;
			o_isLoad = 1;
			o_isStore = 0;
		end
		////////////////////
	else if ((o_msb == 1) && (o_aluOp_1 == 8))
		begin
			o_isJump = 0;
			o_isLoad = 0;
			o_isStore = 1;
		end	
	else
		begin 
			o_isJump = 0;
			o_isLoad = 0;
			o_isStore = 0;
		end
end
endmodule
