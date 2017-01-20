`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:34 01/05/2017 
// Design Name: 
// Module Name:    main 
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
module main(
	clk,
	rst_n 
    );
	input clk, rst_n;

	wire [7:0] ra, rb, rd, inst, flags;
	wire wr;								//	Write/Read signal for register file
	wire [5:0]	aa, ab,ad;					//	address, 2^6 (64B) memory

	//ClockGen cg(clk, rst_n, clk_o);			//	generate the 1 Hz clock

	RegFile rf(.ra(ra), .rb(rb), 						//	output: ra, rb (data)
		.wr(wr), .rd(rd), .aa(aa), 
		.ab(ab), .ad(ad), .clk(clk), 
		.rst_n(rst_n));	//	input W/R, rd, aa (address), ab, ad, clk, rst_n
	
	ArithmeticLogicUnit alu(rd,	flags,			//	output: rd	
		ra, rb, inst, clk, rst_n);			//	input: ra, rb, instruction
	
	ControlUnit cu(aa, ab, ad, wr, inst, 	//	output: wr, inst
		clk, rst_n);
	

endmodule
