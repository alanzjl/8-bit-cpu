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
	amem, aa, ab, ad,
	wr, md, mw, addr_inst,
	inst,  
	clk, m_clk, rst_n
    );

	output reg [1:0] aa, ab;
	output wire [1:0] ad;
	output reg [9:0] amem;
	output reg wr, md, mw;
	input [7:0] inst;
	input clk, m_clk, rst_n;

	output reg addr_inst;	// inst lock

	always @ (posedge m_clk) begin	// generation of MD
		if(!addr_inst)
			if (inst[7:4] == 4'b0010)
				md <= 1'b0;		// data flow from memory
			else
				md <= 1'b1;		// data flow from alu
	end

	always @ (posedge m_clk) begin	// generation of MW
		if(!addr_inst)
			if (inst[7:4] == 4'b0001)
				mw <= 1'b1;
			else
				mw <= 1'b0;
	end

	always @ (posedge m_clk) begin
		if(!addr_inst)
			case (inst[7:4])
				4'b0010: wr <= 1'b1;

				4'b1000: wr <= 1'b1;
				4'b1001: wr <= 1'b1;
				4'b1010: wr <= 1'b1;
				4'b1011: wr <= 1'b1;

				4'b0100: wr <= 1'b1;
				4'b0101: wr <= 1'b1;
				4'b0110: wr <= 1'b1;
				4'b0111: wr <= 1'b1;
			
				default: wr <= 1'b0;
			endcase
	end

	assign ad = addr_inst ? ad : inst[3:2];
	always @ (inst, addr_inst) begin
		if(!addr_inst)
			if(inst[7:5] == 3'b100)begin		// incre & decrement
				//ad <= inst[3:2];
				aa <= inst[3:2];
			end
			else if(inst[7:5] == 3'b101)begin		// addition
				//ad <= inst[3:2];
				aa <= inst[3:2];
				ab <= inst[1:0];
			end
			else if(inst[7:5] == 3'b010) begin	// multiplication
				//ad <= inst[3:2];
				aa <= inst[3:2];
				ab <= inst[1:0];
			end
			/*else if(inst[7:4] == 4'b0000)		// LOAD
				ad <= inst[3:2];*/
			else if(inst[7:4] == 4'b0001)		// STORE
				ab <= inst[3:2];
	end

	always @ (posedge m_clk or negedge rst_n) begin
		if(!rst_n)
			addr_inst <= 1'b0;
		else if(addr_inst)
			addr_inst <= 1'b0;
		else if(inst[7:5] == 3'b000)
			addr_inst <= 1'b1;
		else 
			addr_inst <= 1'b0;
	end
	
	always @(posedge m_clk) begin
		if(addr_inst)
			amem[9:2] <= inst;
		else if(inst[7:5] == 3'b000)
			amem[1:0] <= inst[1:0];
	end

endmodule
