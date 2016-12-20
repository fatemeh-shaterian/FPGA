`timescale 1ns / 1ps
module RF(i_aluOp,i_addr1,i_addr2,i_addrRw,i_rw,i_dataIn,i_clk,o_data1,o_data2,pc
, i_zeroFlag , o_zeroFlag ,i_carryFlag,o_carryFlag,i_signFlag,o_signFlag,i_overflowFlag,o_overflowFlag
,i_loadStoreReg , o_loadStoreReg 
,i_isLoad,i_loadType); 

//i_rw - 0 read 1 write
input [2:0] i_addr1,i_addr2,i_addrRw;
input [8:0] i_aluOp;
input [7:0] i_dataIn;
input i_clk;
input i_rw;
input[7:0] pc;
input i_zeroFlag;
input i_carryFlag;
input i_signFlag;
input i_overflowFlag;

output reg [7:0] o_data1;
output reg [7:0] o_data2;
output o_zeroFlag;
output o_carryFlag;
output o_signFlag;
output o_overflowFlag;
///////////////////////////////////
input [2:0]i_loadStoreReg;
output reg [7:0] o_loadStoreReg;
input i_isLoad;
input i_loadType;


reg [7:0]rf[7:0] ;
//flags
	reg zeroFlag;
	reg carryFlag;
	reg signFlag;
	reg overflowFlag;
////

assign o_zeroFlag = zeroFlag;


initial
begin
	rf[0] = 4;
	rf[1] = 9;
	rf[2] = 11;
	rf[3] = 3;
	rf[4] = 3;
	rf[5] = 5;
	rf[6] = 6;
	rf[7] = 7;
end
initial 
begin 
	zeroFlag = 0;
	carryFlag= 0;
	signFlag=0;
	overflowFlag=0;
end


////////////////////////////////////
//assign o_loadStoreReg = rf[i_loadStoreReg];
//////////////////////////////////

always@(*)//i_addr1 or i_addr2)
begin
	o_data1 = rf[i_addr1];
	// for shift and rotatet
	if((i_aluOp>8) && (i_aluOp<15)) 
		o_data2 = {5'b00000,i_addr2};
	else
		o_data2 = rf[i_addr2];	
	o_loadStoreReg = rf[i_loadStoreReg];
end

always @(posedge i_clk)
begin 
	if(i_rw == 1)
	begin 	
		rf[i_addrRw] = i_dataIn ;
		zeroFlag = i_zeroFlag;
		
	end
	else if(i_isLoad)
	begin 
		rf[i_addrRw] = i_dataIn ;
	end
	else 
	begin 
		rf[i_addrRw] = rf[i_addrRw];
	end
end	
endmodule
