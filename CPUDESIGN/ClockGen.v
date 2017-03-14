`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:53:38 01/05/2017 
// Design Name: 
// Module Name:    ClockGen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// In order to show the intermediate states of 8086, we slow down the clock
// frequency from 50MHz to 1Hz
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ClockGen(
	clk,
	rst_n,
	clk_o
    );

	input clk;
	input rst_n;
	output reg clk_o;
	reg [24:0] counter;

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			counter <= 0;
		//else if(counter == 25'H17D_7840)	// 25M
		else if(counter == 25'H1)	// 25M
			counter <= 0;
		else
			counter <= counter + 1'b1;
	end

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			clk_o <= 1'b0;
		//else if(counter == 25'H17D_7840)	// 25M
		else if(counter == 25'H1)
			clk_o <= !clk_o;
	end

endmodule
