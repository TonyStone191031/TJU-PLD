`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 23:54:46
// Design Name: 
// Module Name: count_sec
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


module count_sec(
    input clk,  //系统时钟
    input clksec,        //此模块的时钟(1Hz)
    input rst,
    input [1:0] state,  //选择时钟的工作状态, 00计时, 01或10设置, 11完成  
    input [5:0] num,    //选择设置的时间
    input sec_enable,       //设置时间的使能信号，高电平有效
    output reg[5:0] count,
	output reg sec60sig     //给counter_60min的时钟信号
);

reg [5:0]count_reg;
reg clksec_now, clksec_before;

always@(posedge clk, posedge rst)
begin
    if(rst) begin
        clksec_now <= 0;
        clksec_before <= 0;
    end
    else begin
        clksec_now <= clksec;
        clksec_before <= clksec_now;
    end
end

always@(posedge clk, posedge rst)
begin
	if(rst) begin      //复位
		count <= 0;
	end
	else if(clksec_now == 1 && clksec_before == 0) //clksec(即1Hz时钟)上升沿到来
	begin
	   if(state == 2'b00) begin        //计时
	       if(count == 59) begin
	           count <= 0;
	           sec60sig <= 1;
	       end
	       else begin
	           count <= count + 1;
	           sec60sig <= 0;
	       end	
	   end
	end
	else begin
	   if((state == 2'b01 || state == 2'b10) && sec_enable == 1) begin    //设置
	        count_reg <= num;
	   end
       else if(state == 2'b11 && sec_enable == 1) begin     //FINISH，将设置的时间输出于LED
            count <= count_reg;
       end
	end
end

endmodule
