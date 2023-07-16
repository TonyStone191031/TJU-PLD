`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/20 00:05:28
// Design Name: 
// Module Name: Hex2BCD
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


module Hex2BCD(
	input [5:0] Hex,
	output reg[3:0] BCDH, BCDL
    );

always@* 
begin
	if(Hex>49) BCDH = 5;
	else if(Hex>39) BCDH = 4;
	else if(Hex>29) BCDH = 3;
	else if(Hex>19) BCDH = 2;
    else if(Hex>9) BCDH = 1;
	else BCDH = 0;
	
	BCDL = Hex - BCDH*10;
end

endmodule
