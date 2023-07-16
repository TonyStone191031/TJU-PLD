`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/20 00:02:40
// Design Name: 
// Module Name: count_hour
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


module count_hour(
    input clk,  //系统时钟
    input min60sig,      //此模块的普通计时的触发时钟
    input rst,
    input [1:0] state,  //选择时钟的工作状态, 00计时, 01或10设置, 11完成  
    input [5:0] num,    //选择设置的时间
    input hour_enable,       //设置时间的使能信号，高电平有效
    output reg[5:0] count
    );

reg[5:0] count_reg;
reg min_now, min_before;

always@(posedge clk, posedge rst)
begin
    if(rst) begin
        min_now <= 0;
        min_before <= 0;
    end
    else begin
        min_now <= min60sig;
        min_before <= min_now;
    end
end

always@(posedge clk, posedge rst)
begin
	if(rst) begin      //复位
		count <= 0;
	end
	else if(min_now == 1 && min_before == 0)
	begin
	   if(state == 2'b00) begin        //计时
	       if(count == 23) begin
	           count <= 0;
	       end
	       else begin
	           count <= count + 1;
	       end	
	   end
	end
	else begin
	   if((state == 2'b01 || state == 2'b10) && hour_enable == 1) begin    //设置
	        count_reg <= num;
	   end
       else if(state == 2'b11 && hour_enable == 1) begin     //FINISH，将设置的时间输出于LED
            count <= count_reg;
       end
	end
end

endmodule
