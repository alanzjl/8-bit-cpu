`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:33:25 01/20/2017
// Design Name:   RegFile
// Module Name:   D:/Alanzjl/Documents/Projects/CPUDesign/CPUDesign/test_RegFile.v
// Project Name:  CPUDesign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_RegFile;

	// Inputs
	reg wr;
	reg [7:0] rd;
	reg [1:0] aa;
	reg [1:0] ab;
	reg [1:0] ad;

	// Outputs
	wire [7:0] ra;
	wire [7:0] rb;

	// Instantiate the Unit Under Test (UUT)
	RegFile uut (
		.ra(ra), 
		.rb(rb), 
		.wr(wr), 
		.rd(rd), 
		.aa(aa), 
		.ab(ab), 
		.ad(ad) 
	);

	initial begin
		// Initialize Inputs
		wr = 0;
		rd = 8'd12;
		aa = 0;
		ab = 0;
		ad = 0;

		#20;
		// Add stimulus here
		#1;	// wait 1 clk (pos edge
		ad = 2'b00;
		rd = 8'd12;
		wr = 1'b1;
		#1;
		ad = 2'b01;
		rd = 8'd13;
		#1;
		ad = 2'b10;
		rd = 8'd14;
		#1;
		ad = 2'b11;
		rd = 8'd15;

		#1; wr = 1'b0;
		aa = 2'b01;
		ab = 2'b11;
		#1;
		aa = 2'b10;
		ab = 2'b00;
		#1;
		#2; $stop;


	end

endmodule

