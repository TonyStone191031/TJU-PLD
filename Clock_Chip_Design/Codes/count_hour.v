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
    input clk,  //ϵͳʱ��
    input min60sig,      //��ģ�����ͨ��ʱ�Ĵ���ʱ��
    input rst,
    input [1:0] state,  //ѡ��ʱ�ӵĹ���״̬, 00��ʱ, 01��10����, 11���  
    input [5:0] num,    //ѡ�����õ�ʱ��
    input hour_enable,       //����ʱ���ʹ���źţ��ߵ�ƽ��Ч
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
	if(rst) begin      //��λ
		count <= 0;
	end
	else if(min_now == 1 && min_before == 0)
	begin
	   if(state == 2'b00) begin        //��ʱ
	       if(count == 23) begin
	           count <= 0;
	       end
	       else begin
	           count <= count + 1;
	       end	
	   end
	end
	else begin
	   if((state == 2'b01 || state == 2'b10) && hour_enable == 1) begin    //����
	        count_reg <= num;
	   end
       else if(state == 2'b11 && hour_enable == 1) begin     //FINISH�������õ�ʱ�������LED
            count <= count_reg;
       end
	end
end

endmodule
