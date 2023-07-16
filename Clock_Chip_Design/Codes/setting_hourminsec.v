`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 23:53:06
// Design Name: 
// Module Name: setting_hourminsec
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


module setting_hourminsec(
    input [1:0] state_input,      //选择时钟的工作状态, 00计时, 01或10设置, 11完成
    input secset, //选择设置的是sec
	input minset, //选择设置的是min
	input hourset, //选择设置的是hour
    input [5:0] timenum,    //设置的时间
    output wire[5:0] num,       //输出给counter_60sec或counter_60min或counter_24h
    output wire[1:0] state,      //时钟的工作状态, 00计时, 01或10设置, 11完成
    output wire sec_enable,min_enable,hour_enable
    );

//暂停的功能：只要输入的state_input为01或10后，跳过11直接回到00，就可以不设置时间而达到暂停的作用
//清零的功能直接由总复位rst负责

assign state = state_input;
assign num = timenum;
assign sec_enable = secset;
assign min_enable = minset;
assign hour_enable = hourset;

endmodule
