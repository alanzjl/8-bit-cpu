`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:08 01/20/2017 
// Design Name: 
// Module Name:    RegFile 
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
module RegFile(
	ra, rb, 
	wr, rd, aa, ab, ad, 
	clk, rst_n
	);

	output wire [7:0] ra;
	output wire [7:0] rb;
	input wr;
	input [7:0] rd;
	input [5:0] aa;
	input [5:0] ab;
	input [5:0] ad;
	input clk, rst_n;

	wire [5:0] tmpa;		// tmp addr, equal to aa (read) or ad (write)

	ram ram_reg(		// a true dual-port ram
						// use port a & b to read, use a to write
		.clka(clk),
		.clkb(clk),
		.addra(tmpa),		// write addr
		.addrb(ab),		// read addr
		.douta(ra),		// read data
		.doutb(rb),		// read data
		.dina(rd),		// write db
		.dinb(8'd0),		// write db
		.wea(wr),		// write enable
		.web(1'b0)		// always read
	);

	assign tmpa = wr ? ad : aa;

endmodule
