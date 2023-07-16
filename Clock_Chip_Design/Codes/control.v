`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/20 00:07:11
// Design Name: 
// Module Name: control
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

//6���Ƽ�������3/6��������24ѡ4��·����
module control(
	input clk_1k,
	input rst,
	input [3:0] secH,
	input [3:0] secL,
	input [3:0] minH,
	input [3:0] minL,
	input [3:0] hourH,
	input [3:0] hourL,
	output reg[3:0] Q,
	output reg[7:0] AN
    );

reg [2:0]count; //�����Ƽ�����

always@(posedge clk_1k, posedge rst)    //�����Ƽ�����
begin
	if(rst) begin
		count <= 0;
	end
	else begin
		if(count == 5) begin
			count <= 0;
		end
		else 
			count <= count + 1;
	end
end
	 
always@(posedge clk_1k)
begin
	case(count)    //�����Ƽ�����
		0: begin  Q <= secL;  AN <= 8'b11111110;  end   //24ѡ4��·����Q; 3/6������AN(�����������)
		1: begin  Q <= secH;  AN <= 8'b11111101;  end
		2: begin  Q <= minL;  AN <= 8'b11111011;  end
        3: begin  Q <= minH;  AN <= 8'b11110111;  end
		4: begin  Q <= hourL; AN <= 8'b11101111;  end
		5: begin  Q <= hourH; AN <= 8'b11011111;  end
	endcase
end

endmodule
