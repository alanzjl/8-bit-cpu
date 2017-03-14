`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:17:22 01/20/2017 
// Design Name: 
// Module Name:    MultiplierSigned 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MultiplierSigned(
	res, flags,
	ra, rb
    );
	
	output [7:0] res;
	output [7:0] flags;
	input [3:0] ra, rb;

	wire [5:0] s1, s2, s3;	// stage 1 2 3

	wire [5:0]res_tmp;
	wire flag_OF;	// overflow
	wire flag_CF;	// carry
	wire flag_NF;	// negative
	wire flag_ZF;	// zero	

	assign s1 = ra[0:0] ? rb[2:0] : 3'b0;
	assign s2 = ra[1:1] ? rb[2:0] : 3'b0;
	assign s3 = ra[2:2] ? rb[2:0] : 3'b0;

	assign res_tmp = s1 + (s2<<1) + (s3<<2);
	assign res = {ra[3:3] ^ rb[3:3], 1'b0, res_tmp};
	
	assign flag_OF = 1'b0;
	assign flag_CF = 1'b0;
	assign flag_ZF = (res == 0) ? 1'b1 : 1'b0;
	assign flag_NF = res[7:7];

	assign flags = {4'b0, flag_NF, flag_OF, flag_CF, flag_ZF};
endmodule
