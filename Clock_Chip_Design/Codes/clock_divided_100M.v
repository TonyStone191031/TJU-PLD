`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 23:42:23
// Design Name: 
// Module Name: clock_divided_100M
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

//100M分频器，产生1Hz时钟给count_sec
module clock_divided_100M(
    input clk, rst,     //clk为默认系统时钟100MHz
    output reg clk_1hz
    );
    
reg [26:0]count;

always@(posedge clk,posedge rst)
begin
	if(rst) begin
		count <= 0;
	end
	else if(count == 100_000_000)
		count <= 0;
	else 
	   count <= count + 1;
end
	
always@(posedge clk)
begin
	if(count < 50_000_000)
		clk_1hz <= 0;
	else 
		clk_1hz <= 1;
end

endmodule
