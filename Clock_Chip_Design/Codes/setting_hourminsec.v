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
    input [1:0] state_input,      //ѡ��ʱ�ӵĹ���״̬, 00��ʱ, 01��10����, 11���
    input secset, //ѡ�����õ���sec
	input minset, //ѡ�����õ���min
	input hourset, //ѡ�����õ���hour
    input [5:0] timenum,    //���õ�ʱ��
    output wire[5:0] num,       //�����counter_60sec��counter_60min��counter_24h
    output wire[1:0] state,      //ʱ�ӵĹ���״̬, 00��ʱ, 01��10����, 11���
    output wire sec_enable,min_enable,hour_enable
    );

//��ͣ�Ĺ��ܣ�ֻҪ�����state_inputΪ01��10������11ֱ�ӻص�00���Ϳ��Բ�����ʱ����ﵽ��ͣ������
//����Ĺ���ֱ�����ܸ�λrst����

assign state = state_input;
assign num = timenum;
assign sec_enable = secset;
assign min_enable = minset;
assign hour_enable = hourset;

endmodule
