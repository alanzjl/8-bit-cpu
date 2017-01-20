`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:47:09 01/20/2017 
// Design Name: 
// Module Name:    Multiplier 
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
module Multiplier(
	res, flags,// s1, s2, s3, s4,
	ra, rb
    );
	
	output wire [7:0] res;
	output wire[7:0] flags;
	input [3:0] ra, rb;

	//output [7:0] s1, s2, s3, s4;	// stage 1 2 3 4
	wire [7:0] s1, s2, s3, s4;	// stage 1 2 3 4

	wire flag_OF;	// overflow
	wire flag_CF;	// carry
	wire flag_NF;	// negative
	wire flag_ZF;	// zero	

	assign s1 = ra[0:0] ? rb : 4'b0;
	assign s2 = ra[1:1] ? rb : 4'b0;
	assign s3 = ra[2:2] ? rb : 4'b0;
	assign s4 = ra[3:3] ? rb : 4'b0;

	assign res = s1 + (s2<<1) + (s3<<2) + (s4<<3);
	
	assign flag_OF = 1'b0;
	assign flag_CF = 1'b0;
	assign flag_ZF = (res == 0) ? 1'b1 : 1'b0;
	assign flag_NF = res[7:7];

	assign flags = {4'b0, flag_NF, flag_OF, flag_CF, flag_ZF};
endmodule
