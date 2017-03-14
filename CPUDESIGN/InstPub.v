`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:26 01/25/2017 
// Design Name: 
// Module Name:    InstPub 
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
module InstPub(
    inst, addr_mem,
	flags, addr_lock, i_clk, clk, rst_n
	);

	output wire [7:0] inst;
	input [7:0] flags;
	input addr_lock, i_clk, clk, rst_n;

	output reg [7:0] addr_mem;

	reg [7:0] offset;
	always @ (inst) begin
		if(!addr_lock) begin
		case(inst[7:4])
			4'b1100: 	begin 
							offset[3:0] <= flags[0:0] ? inst[3:0] : 4'b0000;  
							offset[7:4] <= ({flags[0:0],inst[3:3]}==2'b11) ? 4'b1111 : 4'b0000;			// offset < 0
						end
			4'b1101: 	begin
							offset[3:0] <= flags[1:1] ? inst[3:0] : 4'b0000;  
							offset[7:4] <= ({flags[0:0],inst[3:3]}==2'b11) ? 4'b1111 : 4'b0000;
						end
			4'b1110: 	begin
							offset[3:0] <= flags[2:2] ? inst[3:0] : 4'b0000;  
							offset[7:4] <= ({flags[0:0],inst[3:3]}==2'b11) ? 4'b1111 : 4'b0000;
						end
			4'b1111: 	begin 
							offset[3:0] <= flags[3:3] ? inst[3:0] : 4'b0000;
							offset[7:4] <= ({flags[0:0],inst[3:3]}==2'b11) ? 4'b1111 : 4'b0000;
						end
			default: offset <= 8'b0;
		endcase
		end
	end	

	always @ (negedge i_clk or negedge rst_n) begin
		if(!rst_n)
			addr_mem <= 8'b0;
		else if (offset != 8'b0000)
			addr_mem <= addr_mem + offset;
		else if ({addr_lock, inst} != 9'b0_0011_1111)
			addr_mem <= addr_mem + 1'b1;
	end


	//reg [7:0] inst_tmp;

	InstMem im(
		.clka(i_clk), // input clka
  		.wea(1'b0), // input [0 : 0] wea
 		.addra(addr_mem), // input [7 : 0] addra
 		//.dina(dina), // input [7 : 0] dina
 	 	.douta(inst), // output [7 : 0] douta
 		//.clkb(clkb), // input clkb
 		.enb(1'b0) // input enb
 		//.web(web), // input [0 : 0] web
 		//.addrb(addrb), // input [7 : 0] addrb
 		//.dinb(dinb), // input [7 : 0] dinb
 		//.doutb(doutb) // output [7 : 0] doutb
	);


endmodule
