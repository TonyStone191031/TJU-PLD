`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 23:46:48
// Design Name: 
// Module Name: clock_divided_100k
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

//100k分频器，产生1kHz时钟给control对数码管进行扫描显示
module clock_divided_100k(
    input clk, rst,
    output reg clk_1k
    );

reg [26:0]count;

always@(posedge clk,posedge rst)
begin
	if(rst) begin
		count <= 0;
	end
	else if(count == 100_000)
		count <= 0;
	else 
	   count <= count + 1;
end
	
always@(posedge clk)
begin
	if(count < 50_000)
		clk_1k <= 0;
	else 
		clk_1k <= 1;
end

endmodule
