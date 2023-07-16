`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/20 00:22:21
// Design Name: 
// Module Name: segment7_decoder
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


module segment7_decoder(
    input [3:0] Q,
    output reg[7:0] segment
    );

always@*
begin
	case(Q)                    //共阴极数码管，低电平点亮
		0:segment = 8'hC0;    //8'b1100_0000
		1:segment = 8'hF9;    //8'b1111_1001
		2:segment = 8'hA4;    //8'b1010_0100
		3:segment = 8'hB0;    //8'b1011_0000
		4:segment = 8'h99;    //8'b1001_1001
		5:segment = 8'h92;    //8'b1001_0010
		6:segment = 8'h82;    //8'b1000_0010
		7:segment = 8'hF8;    //8'b1111_1000
		8:segment = 8'h80;    //8'b1000_0000
		9:segment = 8'h90;    //8'b1001_0000
		default: segment = 8'hFF; //8'b11111111
	endcase
end

endmodule
