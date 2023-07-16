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
    input clk,  //ϵͳʱ��
    input clksec,        //��ģ���ʱ��(1Hz)
    input rst,
    input [1:0] state,  //ѡ��ʱ�ӵĹ���״̬, 00��ʱ, 01��10����, 11���  
    input [5:0] num,    //ѡ�����õ�ʱ��
    input sec_enable,       //����ʱ���ʹ���źţ��ߵ�ƽ��Ч
    output reg[5:0] count,
	output reg sec60sig     //��counter_60min��ʱ���ź�
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
	if(rst) begin      //��λ
		count <= 0;
	end
	else if(clksec_now == 1 && clksec_before == 0) //clksec(��1Hzʱ��)�����ص���
	begin
	   if(state == 2'b00) begin        //��ʱ
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
	   if((state == 2'b01 || state == 2'b10) && sec_enable == 1) begin    //����
	        count_reg <= num;
	   end
       else if(state == 2'b11 && sec_enable == 1) begin     //FINISH�������õ�ʱ�������LED
            count <= count_reg;
       end
	end
end

endmodule
