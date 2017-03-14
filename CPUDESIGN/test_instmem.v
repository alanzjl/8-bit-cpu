`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:18:17 01/25/2017
// Design Name:   InstMem
// Module Name:   D:/Alanzjl/Documents/Projects/CPUDesign/CPUDesign/test_instmem.v
// Project Name:  CPUDesign
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstMem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_instmem;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [7:0] addra;
	reg [7:0] dina;
	reg clkb;
	reg enb;
	reg [0:0] web;
	reg [7:0] addrb;
	reg [7:0] dinb;

	// Outputs
	wire [7:0] douta;
	wire [7:0] doutb;

	// Instantiate the Unit Under Test (UUT)
	InstMem uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta), 
		.clkb(clkb), 
		.enb(enb), 
		.web(web), 
		.addrb(addrb), 
		.dinb(dinb), 
		.doutb(doutb)
	);

	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		clkb = 0;
		enb = 0;
		web = 0;
		addrb = 0;
		dinb = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#2; addra = addra+1;
		#10; $stop;
        
		// Add stimulus here

	end
	always #1 clka = ~clka;
      
endmodule

