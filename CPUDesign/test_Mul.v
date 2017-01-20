`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:50:57 01/20/2017
// Design Name:   Multiplier
// Module Name:   D:/Alanzjl/Documents/Projects/CPUDesign/CPUDesign/test_Mul.v
// Project Name:  CPUDesign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_Mul;

	// Inputs
	reg [3:0] ra;
	reg [3:0] rb;

	// Outputs
	wire [7:0] res;
	wire [7:0] flags;

	wire [7:0]s1, s2, s3, s4;

	// Instantiate the Unit Under Test (UUT)
	Multiplier uut (
		.res(res), 
		.flags(flags), 
		.ra(ra), 
		.rb(rb),
		.s1(s1),
		.s2(s2),
		.s3(s3),
		.s4(s4)
	);

	initial begin
		// Initialize Inputs
		ra = 0;
		rb = 0;

		// Wait 100 ns for global reset to finish
		#4;
		ra = 4'b1110;
		rb = 4'b0010;
		#4; $stop;
        
		// Add stimulus here

	end
      
endmodule

