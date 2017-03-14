`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:11:02 01/20/2017
// Design Name:   ArithmeticLogicUnit
// Module Name:   D:/Alanzjl/Documents/Projects/CPUDesign/CPUDesign/test_ALU.v
// Project Name:  CPUDesign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ArithmeticLogicUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_ALU;

	// Inputs
	reg [7:0] ra;
	reg [7:0] rb;
	reg [7:0] inst;
	reg clk;
	reg rst_n;

	// Outputs
	wire [7:0] rd;
	wire [7:0] flags;

	// Instantiate the Unit Under Test (UUT)
	ArithmeticLogicUnit uut (
		.rd(rd), 
		.flags(flags), 
		.ra(ra), 
		.rb(rb), 
		.inst(inst), 
		.clk(clk), 
		.rst_n(rst_n)
	);

	initial begin
		// Initialize Inputs
		inst = 0;
		clk = 0;
		rst_n = 0;
		ra = 0; 
		rb = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst_n = 1;

		#1;	// clock sync
		/*
		ra = 8'b01111111; 
		rb = 8'd15;
		#4; inst = 8'b1000_0000;	// increment
		#4; inst = 8'b1001_0000;	// decrement
		#4; inst = 8'b1010_0000;	// addition
		#4; inst = 8'b1011_0000;	// subtraction
		*/
	 	ra = 8'b00001011; 
		rb = 8'b00000010;
		#4; inst = 8'b0101_0000;
		#10; $stop;
        
		// Add stimulus here

	end
	always #1 clk = ~clk;
      
endmodule

