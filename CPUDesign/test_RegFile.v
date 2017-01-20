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
	reg [5:0] aa;
	reg [5:0] ab;
	reg [5:0] ad;
	reg clk;
	reg rst_n;

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
		.ad(ad), 
		.clk(clk), 
		.rst_n(rst_n)
	);

	initial begin
		// Initialize Inputs
		wr = 0;
		rd = 8'd12;
		aa = 0;
		ab = 0;
		ad = 0;
		clk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst_n = 1;
		// Add stimulus here
		#1;	// wait 1 clk (pos edge

		#4; aa = 6'd10;ab = 6'd01; ad = 6'd01;	// read test
		#4; wr = 1'b1; #2; wr = 1'b0;
		#4; ab = 6'd01;
		#10; $stop;

	end

	always #1 clk = ~clk;
	//always #2 aa = aa+1'b1;
	//always #2 ab = ab+1'b1;
      
endmodule

