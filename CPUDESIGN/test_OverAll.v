`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:37:44 01/22/2017
// Design Name:   main
// Module Name:   D:/Alanzjl/Documents/Projects/CPUDesign/CPUDesign/test_OverAll.v
// Project Name:  CPUDesign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_OverAll;

	// Inputs
	reg clk;
	reg rst_n;
	reg [3:0] key_in;

	// Outputs
	wire [3:0] led_out;
	wire [7:0] ax, bx, cx, dx;
	wire [7:0] ra;
	wire [7:0] rb;
	wire [7:0] rd;
	wire [7:0] flags;
	wire [9:0] amem;
	wire m_clk, i_clk;
	wire MD, MW, WR;
	wire addr_lock;
	wire [1:0] aa, ab, ad;
	wire [7:0] inst;
	wire [7:0] inst_mem;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.led_out(led_out),
		.ax(ax),
		.bx(bx),
		.cx(cx),
		.dx(dx),
		.ra(ra), 
		.rb(rb), 
		.rd(rd), 
		.aa(aa),
		.ab(ab),
		.ad(ad),
		.flags(flags),
	    .m_clk(m_clk),	
		.inst_clk(i_clk),
	    .amem(amem),
		.MD(MD),
		.MW(MW),	
		.WR(WR),
		.addr_lock(addr_lock),
		.inst_mem(inst_mem),
		.inst(inst), 
		.key_in(key_in),
		.clk(clk), 
		.rst_n(rst_n)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		key_in = 4'b1111;

		// Wait 100 ns for global reset to finish
		#8;
		rst_n = 1;
        
		/*#24;
		inst = 8'b00000000;
		#12;
		inst = 8'b00000000;
		#12;
		inst = 8'b0010_0100;

		#12;
		inst = 8'b1001_0100;
		#12;
		inst = 8'b0001_0100;
		#12;
		inst = 8'b0000_0000;
		#12;
		inst = 8'b00001100;
		#12;
		inst = 8'b00000000;
		#12;
		inst = 8'b0010_1100;
		#36;
		$stop;*/
		// Add stimulus here
		#200 $stop;

	end

	always #1 clk = ~clk;
      
endmodule

