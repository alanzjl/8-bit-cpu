`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:44:18 01/20/2017 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
	aa, ab, ad,
	wr, inst,
	clk, rst_n
    );

	output reg [5:0] aa, ab, ad;
	output reg wr;
	output reg [7:0] inst;
	input clk, rst_n;


endmodule
