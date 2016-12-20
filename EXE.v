`timescale 1ns / 1ps

module EXE(i_data1,i_data2,i_aluOp,o_res,pc,o_write,o_exe_v1_branchResult
,i_zeroFlag,zeroFlag,i_carryFlag,carryFlag,i_signFlag,signFlag,i_overflowFlag,overflowFlag);
	input[7:0] i_data1,i_data2;
	input[8:0] i_aluOp;
	output reg[7:0] o_res;
	input[7:0] pc;
	output reg o_write;
	output reg o_exe_v1_branchResult;
	input i_zeroFlag;
	input i_carryFlag;
	input i_signFlag;
	input i_overflowFlag;
	output reg zeroFlag;
	output reg carryFlag;
	output reg signFlag;
	output reg overflowFlag;
	
	
	
	reg[7:0] tempPc;
	
	reg[15:0] rotateTemp;
	wire zeroIndexPc;
	assign zeroIndexPc = pc[0];
	
	reg[7:0] zero;
	reg [7:0] idataCopy;
	wire [3:0] aluOp_1;
	assign aluOp_1 = i_aluOp[8:5];	
	////////////////////////////////////////////////////////
	always @(*)
	begin 
		case(aluOp_1)
			0:														//JE
				begin
					if(i_zeroFlag == 1)
						o_exe_v1_branchResult = 1;
					else 
						o_exe_v1_branchResult = 0;					
				end
			1:														//JB
				begin 
					if(i_carryFlag == 1)
						o_exe_v1_branchResult = 1;
					else
						o_exe_v1_branchResult = 0;
				end
			2:														//JA
				begin 
					if(i_carryFlag == 0 && i_zeroFlag == 0)
						o_exe_v1_branchResult = 1;
					else
						o_exe_v1_branchResult = 0;
				end
			3:														//JL
				begin 
					if(i_signFlag != i_overflowFlag)
						o_exe_v1_branchResult = 1;
					else
						o_exe_v1_branchResult = 0;
				end
			4:														//JG
				begin 
					if( (i_signFlag == i_overflowFlag) && (i_zeroFlag == 0) )
						o_exe_v1_branchResult = 1;
					else
						o_exe_v1_branchResult = 0;
				end		
			5:														//JMP
				begin 				
						o_exe_v1_branchResult = 1;				
				end
			default: 
				o_exe_v1_branchResult = 0;
		endcase				
	end 
	
	
	///////////////////////////////////////////////////////
	reg[7:0] temp;
	
	always@(*)// or i_data1 or i_data2)
	begin 
		case(i_aluOp)
			0:
				begin o_res = 0;							//nop
					o_write = 0;
				end
			1: 												//add
				begin 
					{carryFlag,o_res} = i_data1+i_data2;
					signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = carryFlag;
					
					o_write = 1;
				end			
			2:  												//and
				begin 
					o_res = i_data1 & i_data2;
					signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = 0;
					carryFlag = 0;
					
				end
			3:  												//sub
				begin 
					o_res = i_data1 - i_data2;
					signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = carryFlag;
				end 
			4:  												//or
			begin 
				o_res = i_data1 | i_data2;
				signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = 0;
					carryFlag = 0;
			end 
			5:  												//xor
			begin
				o_res = i_data1 ^ i_data2;			
				signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = 0;
					carryFlag = 0;
			end 
			6: o_res = i_data2;							//mov
			8: o_res = ~i_data1; 						//not
			9: 												//SAR
			begin 
				o_res = i_data1 >>> i_data2[2:0];
				if(o_res[7] == i_data1[7])
					overflowFlag = 0;
				else 
					overflowFlag = 1; 
				carryFlag = i_data1[i_data2-1];
				signFlag = o_res[7];
				if(o_res == 0)
					zeroFlag = 1;
				else
					zeroFlag = 0;				
			end 
			10: 												//SLR
			begin 
				o_res = i_data1 >> i_data2[2:0];
				if(o_res[7] == i_data1[7])
					overflowFlag = 0;
				else 
					overflowFlag = 1; 
				carryFlag = i_data1[i_data2-1];
				signFlag = o_res[7];
				if(o_res == 0)
					zeroFlag = 1;
				else
					zeroFlag = 0;	
			end 
			11: 												//SAL
			begin 
				o_res = i_data1<<<i_data2[2:0];
				if(o_res[7] == i_data1[7])
					overflowFlag = 0;
				else 
					overflowFlag = 1; // or remaind last value
				carryFlag = i_data1[8 - i_data2];
				signFlag = o_res[7];
				if(o_res == 0)
					zeroFlag = 1;
				else
					zeroFlag = 0;	
			end 
			12: 												//SLL
			begin 
				o_res = i_data1<<i_data2[2:0];
				if(o_res[7] == i_data1[7])
					overflowFlag = 0;
				else 
					overflowFlag = 1; // or remaind last value
				carryFlag = i_data1[8 - i_data2];
				signFlag = o_res[7];
				if(o_res == 0)
					zeroFlag = 1;
				else
					zeroFlag = 0;	
				
			end 
			13: 												//ROL
				begin
					rotateTemp = {i_data1,i_data1}<< i_data2[2:0];
					o_res = rotateTemp[15:8];
					if(idataCopy[7] == i_data1[7])
					begin 
						overflowFlag = 0;
					end
					else
						overflowFlag = 1;
					carryFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else 
						zeroFlag = 0;
					signFlag = o_res[7];
				end
				
				
				
			14:												//ROR
				begin 
				/*
					zero = 8'b00000000;
					idataCopy = i_data1;
					zero = zero + idataCopy[(i_data2[2:0] - 1): 0];
					idataCopy = i_data1 >> i_data2[2:0];
					zero = zero << (8-i_data2[2:0]);
					o_res = idataCopy + zero;
					*/
					rotateTemp = {i_data1,i_data1}>> i_data2[2:0];
					o_res = rotateTemp[7:0];
					if(idataCopy[7] == i_data1[7])
					begin 
						overflowFlag = 0;
					end
					else
						overflowFlag = 1;
					carryFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else 
						zeroFlag = 0;
					signFlag = o_res[7];
					
					
					
				end
			15:
				begin 
					{carryFlag, o_res} = i_data1 + 1;			//inc
					signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = carryFlag;
				end
			16:
				begin 
					{carryFlag,o_res} = i_data1 - 1;			//dec			
					signFlag = o_res[7];
					if(o_res == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = carryFlag;
				end
			18: 
			begin 
				o_res = i_data1;									//showR
				o_write = 0;
			end
			//19:; 													//showR seg
			20:														//CMP
			begin 
					temp = i_data1 - i_data2;
					o_res = i_data1;
					signFlag = temp[7];
					if(temp == 0)
						zeroFlag = 1;
					else
						zeroFlag = 0;
					overflowFlag = carryFlag;
				end 
			
			196: 
				o_res = i_data1;
				
			default: o_res = 8'b00000011;
		endcase		
	end
endmodule
