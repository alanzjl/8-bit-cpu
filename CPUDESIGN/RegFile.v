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
	ax, bx, cx, dx,
	ra, rb, 
	wr, rd, 
	addr_lock,
	aa, ab, ad, clk, rst_n
	);

	output reg [7:0] ra;
	output reg [7:0] rb;
	input wr, rst_n, clk;
	input [7:0] rd;
	input [1:0] aa;
	input [1:0] ab;
	input [1:0] ad;

	input addr_lock;
	//reg [7:0] ax, bx, cx, dx;
	output reg [7:0] ax, bx, cx, dx;

	always @ (*) begin
		if(!addr_lock)
			case (aa)
				2'b00: ra <= ax;
				2'b01: ra <= bx;
				2'b10: ra <= cx;
				2'b11: ra <= dx;
				default: ra <= 8'b0;
			endcase
	end

	always @ (*) begin
		if(!addr_lock)
		case (ab)
			2'b00: rb <= ax;
			2'b01: rb <= bx;
			2'b10: rb <= cx;
			2'b11: rb <= dx;
			default: rb <= 8'b0;
		endcase
	end

	always @(negedge clk) begin
		if(!addr_lock) begin
			if(!rst_n) begin
				ax <= 8'd0;
				bx <= 8'd0;
				cx <= 8'd0;
				dx <= 8'd0;
			end
			else if({wr, ad} == 3'b100)
				ax <= rd;
			else if({wr, ad} == 3'b101)
				bx <= rd;
			else if({wr, ad} == 3'b110)
				cx <= rd;
			else if({wr, ad} == 3'b111)
				dx <= rd;
		end
	end
endmodule
