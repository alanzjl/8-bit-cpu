`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:48 01/20/2017 
// Design Name: 
// Module Name:    FullAdder 
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
module FullAdder(
	res, flags, 
	ra, rb, cin
    );

	output wire [7:0] flags;
	output wire [7:0] res;
	input [7:0] ra, rb;
	input cin;

	wire [6:0] res_p;	// the second to last result
	wire cout, cout_p;	// the last and the second to last carries	
	wire flag_OF;	// overflow
	wire flag_CF;	// carry
	wire flag_NF;	// negative
	wire flag_ZF;	// zero	

	assign {cout_p, res_p}	= ra[6:0] + rb[6:0] + cin;
	assign {cout, res} = ra + rb + cin;

	assign flag_OF = cout ^ cout_p;
	assign flag_CF = cout;	// only valid during addition
	assign flag_NF = res[7:7];
	assign flag_ZF = (res == 0) ? 1'b1 : 1'b0;
	
	assign flags = {4'b0, flag_NF, flag_OF, flag_CF, flag_ZF};

endmodule
