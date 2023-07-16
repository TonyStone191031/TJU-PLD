`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 23:40:49
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
    input clk,
	input rst,
	input [1:0] state_input,  //选择时钟的工作状态
	input secset, //选择设置的是sec
	input minset, //选择设置的是min
	input hourset, //选择设置的是hour
	input [5:0] timenum,    //选择设置的时间
	output [7:0] seg,
	output [7:0] an
    );

wire clk_1hz;
wire clk_1k;

wire[5:0] num;
wire[1:0] state;
wire sec_enable, min_enable, hour_enable;

wire[3:0] BCDH, BCDL;
wire[5:0] count;
wire[3:0] Q;
wire sec60sig, min60sig;
wire[5:0]sec, min, hour;
wire[3:0]secH, secL, minH, minL, hourH, hourL;

wire[5:0]min_out;


clock_divided_100M cd100M(.clk(clk),.rst(rst),.clk_1hz(clk_1hz));
clock_divided_100k cd100k(.clk(clk),.rst(rst),.clk_1k(clk_1k));

setting_hourminsec set(.state_input(state_input),.secset(secset),.minset(minset),.hourset(hourset),.timenum(timenum),.num(num),.state(state),.sec_enable(sec_enable),.min_enable(min_enable),.hour_enable(hour_enable));

count_sec sec60(.clk(clk),.clksec(clk_1hz),.rst(rst),.state(state),.num(num),.sec_enable(sec_enable),.count(sec),.sec60sig(sec60sig));
count_min min60(.clk(clk),.sec60sig(sec60sig),.rst(rst),.state(state),.num(num),.min_enable(min_enable),.count(min),.min60sig(min60sig));
count_hour hour24(.clk(clk),.min60sig(min60sig),.rst(rst),.state(state),.num(num),.hour_enable(hour_enable),.count(hour));

Hex2BCD sectrans(.Hex(sec),.BCDH(secH),.BCDL(secL));
Hex2BCD mintrans(.Hex(min),.BCDH(minH),.BCDL(minL));
Hex2BCD hourtrans(.Hex(hour),.BCDH(hourH),.BCDL(hourL));

control ctrl(.clk_1k(clk_1k),.rst(rst),.secH(secH),.secL(secL),.minH(minH),.minL(minL),.hourH(hourH),.hourL(hourL),.Q(Q),.AN(an));
segment7_decoder seg7(.Q(Q),.segment(seg));

endmodule
