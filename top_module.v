`timescale 1ns / 1ps
module top_module(
    input i_CLK, //vasl ast be osillator 50 MHz
    output o_PSCLK, //** paye ye clk khoroji ... tama sh.Rej ha ba in clk kar mikonand
    output o_LEDData, 
    output o_LEDLatch,	 
    output o_DIPLatch,// latch ha hameh khoroji and
    input i_DIPData,	 
    output o_SEGData,
    output o_SEGLatch,
    output o_LCDData,
    output o_LCDLatch,
    output o_Eth_RST,
    input i_Eth_INT,
    output o_Eth_CS,
    output o_Eth_RD,
    output o_Eth_WR,
    output o_USB_SLOE,
    inout io_USB_IFCLK,
    output o_USB_SLRD,
    output o_USB_SLWR,
    inout [7:0] io_Data,
    inout [9:0] io_MuxEthUSB,
    output o_VGA_blue0,
    output o_VGA_blue1,
    output o_VGA_green0,
    output o_VGA_green1,
    output o_VGA_red0,
    output o_VGA_red1,
    output o_VGA_vsync,
    output o_VGA_hsync,
    input i_SW1,
    input i_SW2,
    input i_SW3,
    input i_SW4,
    output o_TXD1,
    input i_RXD1,
    output o_TXD2,
    input i_RXD2,
    output o_MMC_SCK,
    input i_MMC_DO,
    output o_MMC_DI,
    output o_MMC_CS,
    input i_SYS_RESET
    );
//////////////////////////////////////
assign o_PSCLK = ~CLK_OUT5M;
assign o_SEGData = 1'bz;
assign o_SEGLatc = 1'bz;
assign o_LCDData = 1'bz;
assign o_LCDLatch = 1'bz;
assign o_MMC_SCK	= 1'bz;
assign o_MMC_DI = 1'bz;
assign o_MMC_CS = 1'bz;
assign o_VGA_blue0 = 1'bz;
assign o_VGA_blue1 = 1'bz;
assign o_VGA_green0 = 1'bz;
assign o_VGA_green1 = 1'bz;
assign o_VGA_red0 = 1'bz;
assign o_VGA_red1 = 1'bz;
assign o_VGA_vsync = 1'bz;
assign o_VGA_hsync = 1'bz;
assign o_Eth_RST = 1'bz;
assign o_Eth_CS = 1'bz;
assign o_Eth_RD = 1'bz;
assign o_Eth_WR = 1'bz;
assign o_USB_SLOE = 1'bz;
assign io_USB_IFCLK = 1'bz;
assign o_USB_SLRD = 1'bz;
assign o_USB_SLWR = 1'bz;
assign io_Data = 8'bz;
assign io_MuxEthUSB = 10'bz;
assign o_TXD1 = 1'bz;
assign o_TXD2 = 1'bz;
assign o_SEGData = 1'bz;
assign o_SEGLatch = 1'bz;
assign o_LCDData = 1'bz;
assign o_LCDLatch = 1'bz;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
wire [15:0] inst;
wire[15:0] dipData;
wire[4:0] pushData;
/////////////////////////////////////
wire CLK_OUT5M,CLK_OUT20M,CLK_OUT50M,CLK_OUT100M;
wire o_resetPc_test,o_incPc_test;
wire[15:0] in1,in2;
assign in1 = {o_resetPc_test,o_incPc_test,14'b00000000000000};
assign in2 = {o_incPc_test,15'b000000000000000};
wire [7:0] pc;
wire[7:0] bracnPc;
wire[7:0] nextPc;

wire [8:0] dec_v1_aluOp;
wire [2:0] dec_v1_in1;
wire [2:0] dec_v1_in2;
wire [7:0] rf_v1_data1;
wire [7:0] rf_v1_data2;
wire [7:0] exe_v1_result;

//////////////////////////////
wire rw_wire;
reg [7:0]tempPc;
reg debug;
wire andTemp;
assign andTemp = rw_wire && debug;
wire isJump,msb,exe_v1_branchResult;
wire [3:0] dec_v1_aluOp_1;
reg[7:0] currentPc;
wire zeroFlagTemp1,zeroFlagTemp2
,carryFlagTemp1,carryFlagTemp2
,signFlagTemp1,signFlagTemp2
,overflowFlagTEmp1,overflowFlagTemp2;

///////////////////////////////
//////////////////////////////
wire [7:0]loadStoreData;
wire isStore;
wire [7:0]dataMemOutput;
////////////////////////////////


wire isLoad;
wire [2:0] loadStoreReg;
wire [2:0] rf_addrRW;
wire [7:0] rf_dataIn;
assign rf_addrRW = (isLoad)? loadStoreReg : dec_v1_in1;
//assign rf_dataIn = (isLoad)? ((dec_v1_aluOp_1 == 4'b0110)? bracnPc : (dec_v1_aluOp_1 == 4'b1001)? dipData[7:0] : dataMemOutput ) : exe_v1_result;
//(dec_v1_aluOp_1 == 4'b1001)? : 
assign rf_dataIn =
(isLoad && (dec_v1_aluOp_1 == 4'b0110))? bracnPc:
(isLoad && (dec_v1_aluOp_1 == 4'b1001))? dipData[7:0]:
(isLoad && (dec_v1_aluOp_1 == 4'b0111))? dataMemOutput:
exe_v1_result;





clock_generator clk_generator
(// Clock in ports
    .CLK_IN1(i_CLK),      // IN
    // Clock out ports
    .CLK_OUT5M(CLK_OUT5M),     // OUT
    .CLK_OUT20M(CLK_OUT20M),     // OUT
    .CLK_OUT50M(CLK_OUT50M),     // OUT
    .CLK_OUT100M(CLK_OUT100M));    // OUT	
	
DIP_Driver dip_driver(
	.i_clk(CLK_OUT5M),
	.i_DIPData(i_DIPData),
	.o_DIPLatch(o_DIPLatch),
	.o_Data(dipData),
	.o_pushB(pushData) //pushData[0] => s3
							//pushData[1] => s4
							//pushData[2] => s5
							//pushData[3] => s6
							//pushData[4] => s7						
	);	
	
//for hw1 change i_data to data and comment dip_driver module
LED_Driver led_driver(
	.i_data(exe_v1_result) ,														//////??????????
	//.i_data({isLoad,rf_dataIn}) ,														//////??????????
	.i_clk(CLK_OUT5M),
	.o_LEDdata(o_LEDData),
	.o_LEDlatch(o_LEDLatch)
	);	

//testing pc on 7 seg not work
seg_driver segDriver(.i_segInput({5'b0,pc}),.i_clk(CLK_OUT5M),.o_segLatch(o_SEGLatch),.o_segData(o_SEGData));

deBounce deBouncer(.i_reset(pushData[4]),.i_inc(pushData[2]),.i_clk(CLK_OUT5M),.i_pc(pc),.o_pc(pc)
,.i_isTakenJump(exe_v1_branchResult && isJump ),.i_jumpAddr(bracnPc));

IM instMem(.addra(pc),.dina(),.wea(0),.clka(CLK_OUT5M),.douta(inst));// inst

DM dataMem(.clka(CLK_OUT5M),.wea(isStore),.addra(bracnPc),.dina(loadStoreData),.douta(dataMemOutput)); //store 



DEC_v1 dec_v1(.i_inst(inst),.o_aluOp(dec_v1_aluOp),.o_in1(dec_v1_in1),.o_in2(dec_v1_in2),.o_rw(rw_wire)
, .o_msb(msb), .o_aluOp_1(dec_v1_aluOp_1) , .o_in_1(bracnPc), .o_isJump(isJump)
,.o_in_2(loadStoreReg) , .o_isLoad(isLoad) ,.o_isStore(isStore));


RF rf_v1(.i_aluOp(dec_v1_aluOp),.i_addr1(dec_v1_in1),.i_addr2(dec_v1_in2)
	,.i_addrRw(rf_addrRW)
	,.i_rw(andTemp)
	,.i_dataIn(rf_dataIn),.i_clk(CLK_OUT5M)
	,.o_data1(rf_v1_data1),.o_data2(rf_v1_data2),.pc(pc)
	
	,.i_zeroFlag(zeroFlagTemp1) , .o_zeroFlag(zeroFlagTemp2)
	,.i_carryFlag(carryFlagTemp1),.o_carryFlag(carryFlagTemp2)
	,.i_signFlag(signFlagTemp1),.o_signFlag(signFlagTemp2),
	.i_overflowFlag(overflowFlagTEmp1),.o_overflowFlag(overflowFlagTemp2)
	
	,.i_loadStoreReg(loadStoreReg),.o_loadStoreReg(loadStoreData)
	,.i_isLoad(isLoad),.i_loadType(dec_v1_aluOp_1)); //i_rw - 0 read 1 write
	
	
EXE exe_v1(.i_data1(rf_v1_data1),.i_data2(rf_v1_data2),.i_aluOp(dec_v1_aluOp)
	,.o_res(exe_v1_result),.pc(pc),.o_write(),.o_exe_v1_branchResult(exe_v1_branchResult)
	,.i_zeroFlag(zeroFlagTemp2),.zeroFlag(zeroFlagTemp1)
	,.i_carryFlag(carryFlagTemp2),.carryFlag(carryFlagTemp1)
	,.i_signFlag(signFlagTemp2),.signFlag(signFlagTemp1),
	.i_overflowFlag(overflowFlagTEmp2),.overflowFlag(overflowFlagTemp1));
	
always @(posedge CLK_OUT5M)
begin
	if(tempPc == pc)
	begin
		debug = 0;
	end 
	else 
		debug = 1;
	tempPc = pc;	
end
endmodule

//comments----------------------------------------------------------------------------------------------

//assign pc = (exe_v1_branchResult && isJump )? bracnPc : nextPc;
//wire [7:0] pcResult;
//assign pcResult = (isJump && exe_v1_branchResult) ? dec_v1_in_1 : pc ;

/*
reg[7:0] lastPc;
always @ (posedge CLK_OUT5M)
begin
	if(exe_v1_branchResult && isJump && (lastPc != nextPc))
		pc = bracnPc;
	else
		pc = nextPc;
	lastPc = pc;
end

always @ (nextPc[0])
begin 
	if(exe_v1_branchResult && isJump)
		pc = bracnPc;
	else
		pc = nextPc;
end	

seg_driver segDriver(
		.i_segInput(dipData),
		.i_clk(CLK_OUT5M),
		.o_segLatch(o_SEGLatch),
		.o_segData(o_SEGData) 
		);
		
//to put dip data to 7seg -> work correctly	
//seg_driver segDriver(.i_segInput(dipData),.i_clk(CLK_OUT5M),.o_segLatch(o_SEGLatch),.o_segData(o_SEGData));

piso_led(
	.led_in(data),
	.clk(CLK_OUT5M),
	.out(o_LEDData),
	.Latch(o_LEDLatch)
	);	
*/
