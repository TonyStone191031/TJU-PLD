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
    input clk,      //ϵͳʱ��
    input sec60sig,      //��ģ�����ͨ��ʱ�Ĵ���ʱ��
    input rst,
    input [1:0] state,  //ѡ��ʱ�ӵĹ���״̬, 00��ʱ, 01��10����, 11���  
    input [5:0] num,    //ѡ�����õ�ʱ��
    input min_enable,       //����ʱ���ʹ���źţ��ߵ�ƽ��Ч
    output reg[5:0] count,
	output reg min60sig    //��counter_24h��ʱ��
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
	if(rst) begin      //��λ
		count <= 0;
	end
	else if(sec_now == 1 && sec_before == 0)
	begin
	   if(state == 2'b00) begin        //��ʱ
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
	   if((state == 2'b01 || state == 2'b10) && min_enable == 1) begin    //����
	        count_reg <= num;
	   end
       else if(state == 2'b11 && min_enable == 1) begin     //FINISH�������õ�ʱ�������LED
            count <= count_reg;
       end
	end
end

endmodule
