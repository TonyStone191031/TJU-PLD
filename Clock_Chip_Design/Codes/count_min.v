`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 23:59:28
// Design Name: 
// Module Name: count_min
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


module count_min(
    input clk,      //系统时钟
    input sec60sig,      //此模块的普通计时的触发时钟
    input rst,
    input [1:0] state,  //选择时钟的工作状态, 00计时, 01或10设置, 11完成  
    input [5:0] num,    //选择设置的时间
    input min_enable,       //设置时间的使能信号，高电平有效
    output reg[5:0] count,
	output reg min60sig    //给counter_24h的时钟
    );

reg[5:0] count_reg;
reg sec_now, sec_before;

always@(posedge clk, posedge rst)
begin
    if(rst) begin
        sec_now <= 0;
        sec_before <= 0;
    end
    else begin
        sec_now <= sec60sig;
        sec_before <= sec_now;
    end
end

always@(posedge clk, posedge rst)
begin
	if(rst) begin      //复位
		count <= 0;
	end
	else if(sec_now == 1 && sec_before == 0)
	begin
	   if(state == 2'b00) begin        //计时
	       if(count == 59) begin
	           count <= 0;
	           min60sig <= 1;
	       end
	       else begin
	           count <= count + 1;
	           min60sig <= 0;
	       end	
	   end
	end
	else begin
	   if((state == 2'b01 || state == 2'b10) && min_enable == 1) begin    //设置
	        count_reg <= num;
	   end
       else if(state == 2'b11 && min_enable == 1) begin     //FINISH，将设置的时间输出于LED
            count <= count_reg;
       end
	end
end

endmodule
