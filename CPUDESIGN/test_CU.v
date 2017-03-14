`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:49:48 01/22/2017
// Design Name:   ControlUnit
// Module Name:   D:/Alanzjl/Documents/Projects/CPUDesign/CPUDesign/test_CU.v
// Project Name:  CPUDesign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_CU;

	// Inputs
	reg [7:0] inst;
	reg clk;
	reg m_clk;
	reg rst_n;

	// Outputs
	wire [9:0] amem;
	wire [1:0] aa;
	wire [1:0] ab;
	wire [1:0] ad;
	wire wr;
	wire md;
	wire mw;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.amem(amem), 
		.aa(aa), 
		.ab(ab), 
		.ad(ad), 
		.wr(wr), 
		.md(md), 
		.mw(mw), 
		.inst(inst), 
		.clk(clk), 
		.m_clk(m_clk), 
		.rst_n(rst_n)
	);

	initial begin
		// Initialize Inputs
		inst = 0;
		clk = 0;
		m_clk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#20;
		rst_n = 1;
		#4;
		inst = 8'b1000_0100;
		#2;
		inst = 8'b1000_0111;
		#2;
		inst = 8'b1001_0111;
		#2;
		inst = 8'b1001_0111;

		#10;
		inst = 8'b0000_1011;
		#2;
		inst = 8'b1010_0101;
        
		// Add stimulus here
		#20;
		$stop;

	end

	always #1 clk = ~clk;
	always #1 m_clk = ~m_clk;
      
endmodule

