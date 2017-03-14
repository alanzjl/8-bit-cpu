`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:29:27 01/25/2017 
// Design Name: 
// Module Name:    LedOut 
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
module LedOut(
	led_out, clk, rst_n, key_in, ax, bx, cx, dx
    );
	input clk, rst_n;
	input [3:0] key_in;
	input [7:0] ax, bx, cx, dx;
	output reg [3:0] led_out;

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)
			led_out <= ax[3:0];
		else begin
			if(!key_in[0])
				led_out <= ax[3:0];
			if(!key_in[1])
				led_out <= bx[3:0];
			if(!key_in[2])
				led_out <= cx[3:0];
			if(!key_in[3])
				led_out <= dx[3:0];
		end
	end

endmodule
