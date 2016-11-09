`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:38:18 10/16/2016 
// Design Name: 
// Module Name:    top_module 
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

// tamam paye hay khoroji ra z kardim ... 
// moghe estefadeh bayad z bodan ash ra bardarim // ************************************

assign o_PSCLK = ~CLK_OUT5M;
//assign o_LEDData = 1'bz;
//assign o_LEDLatch = 1'bz;


//assign o_DIPLatch = 1'bz;

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


wire [15:0] data;
//initial data = 16'b1000111001101111;
//initial data = 16'b0000000000000000;
wire[15:0] dipData;
wire[4:0] pushData;
/////////////////////////////////////
wire CLK_OUT5M,CLK_OUT20M,CLK_OUT50M,CLK_OUT100M;
///////////////////////////////

//assign data = {pushData,11'b00000000000};
//////////
wire o_resetPc_test,o_incPc_test;
wire[15:0] in1,in2;
assign in1 = {o_resetPc_test,o_incPc_test,14'b00000000000000};
assign in2 = {o_incPc_test,15'b000000000000000};
wire[7:0] pc;
reg [7:0] pcinit;
initial pcinit = 8'b0;
//assign pc = pcinit;
//////////
wire [8:0] dec_v1_aluOp;
wire [2:0] dec_v1_in1;
wire [2:0] dec_v1_in2;

////////////

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
	.i_data(data) ,														//////??????????
	//.i_data(data) ,														//////??????????
	.i_clk(CLK_OUT5M),
	.o_LEDdata(o_LEDData),
	.o_LEDlatch(o_LEDLatch)
	);	
	
/*
seg_driver segDriver(
		.i_segInput(dipData),
		.i_clk(CLK_OUT5M),
		.o_segLatch(o_SEGLatch),
		.o_segData(o_SEGData) 
		);
	
	*/
	
//to put dip data to 7seg -> work correctly	
//seg_driver segDriver(.i_segInput(dipData),.i_clk(CLK_OUT5M),.o_segLatch(o_SEGLatch),.o_segData(o_SEGData));

//testing pc on 7 seg not work
seg_driver segDriver(.i_segInput(pc),.i_clk(CLK_OUT5M),.o_segLatch(o_SEGLatch),.o_segData(o_SEGData));


/*
piso_led(
	.led_in(data),
	.clk(CLK_OUT5M),
	.out(o_LEDData),
	.Latch(o_LEDLatch)
	);	
*/



//////

deBounce deBouncer(.i_reset(pushData[4]),.i_inc(pushData[2]),.i_clk(CLK_OUT5M),.i_pc(pc),.o_pc(pc));
//deBounce deBounceTest1_reset(.i_reset(pushData[4]),.i_clk(CLK_OUT5M),.o_resetPc(o_resetPc_test));
//deBounce deBounceTest2_debug(.i_reset(pushData[2]),.i_clk(CLK_OUT5M),.o_resetPc(o_incPc_test));
//setPc setPcTest(.i_reset(~o_resetPc_test),.i_incPc(o_incPc_test),.i_pcIn(pc),.o_pcOut(pc));
//setPc setPcTest(.i_reset(pushData[4]),.i_incPc(pushData[2]),.i_pcIn(pc),.o_pcOut(pc));
IM instMem(.addra(pc),.dina(),.wea(0),.clka(CLK_OUT5M),.douta(data));// inst

DEC_v1 dec_v1(.i_inst(data),.o_aluOp(dec_v1_aluOp),.o_in1(dec_v1_in1),.o_in2(dec_v1_in2));


////
endmodule
