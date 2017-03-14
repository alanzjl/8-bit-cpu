`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:48 01/20/2017 
// Design Name: 
// Module Name:    ArithmeticLogicUnit 
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
module ArithmeticLogicUnit(
    rd, flags,
	ra, rb, inst, clk
	);

	output reg [7:0] rd;
	output reg [7:0] flags;
	input [7:0] ra;
	input [7:0] rb;
	input [7:0] inst;
	input clk;		// only modify flags when clk comes


	/**************************** Adder part ************************************/
	wire [7:0] tmp_add, tmpf_add;		// tmp res and tmp flags
	reg [7:0] add_oprand;

	always @(*) begin			// adder: res = ra + add_oprand
		case (inst[7:4])
			4'b1000: add_oprand <= 8'd1;
			4'b1001: add_oprand <= 8'b11111111;
			4'b1010: add_oprand <= rb;
			4'b1011: add_oprand <= ~rb + 8'b1;
			default: add_oprand <= 8'b0;
		endcase
	end

	FullAdder fa (.res(tmp_add), 
		.flags(tmpf_add), 
		.ra(ra), 
		.rb(add_oprand),
		.cin(1'b0)
	);
	/**************************************************************************/
	/************************** Multiplier ************************************/
	wire [7:0] tmp_mul, tmpf_mul;
	Multiplier mul(
		.res(tmp_mul),
		.flags(tmpf_mul),
		.ra(ra[3:0]),
		.rb(rb[3:0])
	);

	/************************** Signed Multiplication *************************/
	wire [7:0] tmp_mul_s, tmpf_mul_s;
	MultiplierSigned mul_s(
		.res(tmp_mul_s),
		.flags(tmpf_mul_s),
		.ra(ra[3:0]),
		.rb(rb[3:0])
	);

	/**************************************************************************/
	always @(*) begin
		case (inst[7:4])
			4'b1000: rd <= tmp_add;
			4'b1001: rd <= tmp_add;
			4'b1010: rd <= tmp_add;
			4'b1011: rd <= tmp_add;
			4'b0100: rd <= tmp_mul;
			4'b0101: rd <= tmp_mul_s;
			default: rd <= 8'b0;
		endcase
	end

	always @(posedge clk) begin
		case (inst[7:4])
			4'b1000: flags <= tmpf_add;
			4'b1001: flags <= tmpf_add;
			4'b1010: flags <= tmpf_add;
			4'b1011: flags <= tmpf_add;
			4'b0100: flags <= tmpf_mul;
			4'b0101: flags <= tmpf_mul_s;
			default: flags <= 8'b0;
		endcase
	end


endmodule
