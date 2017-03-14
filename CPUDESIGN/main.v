`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:34 01/05/2017 
// Design Name: 
// Module Name:    main 
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
module main(
	vga_r, vga_g, vga_b, vga_hsy, vga_vsy,
	led_out, ax, bx, cx, dx,
	//ra, rb, rd, flags, m_clk, inst_clk,  amem, MD, MW, WR, aa, ab, ad,
	//addr_lock,
	//inst_mem,
	//inst,
	key_in,
	clk,
	rst_n 
    );
	input clk, rst_n;
	input [3:0] key_in;

	output wire [3:0] led_out;

	wire [7:0] inst;

	output wire [7:0] ax, bx, cx, dx;

	wire [7:0] ra, rb, rd, flags;
	//	wire [7:0] ra, rb, rd, flags;

	//	wire WR;								//	Write/Read signal for register file
	wire WR;								//	Write/Read signal for register file

	// wire MD, MW;
	wire MD, MW;
	
	// wire [1:0]	aa, ab,ad;					//	address, 2-bit
	wire [1:0]	aa, ab,ad;					//	address, 2-bit

	//wire [9:0] amem;						// mem address
	wire [9:0] amem;						// mem address

	wire [7:0] tmpRd_mem, tmpRd_alu;

	//	wire addr_lock;
	wire addr_lock;

	wire [7:0] inst_mem;

	// reg m_clk;
	reg m_clk, inst_clk;
	
	output wire [4:0] vga_r;
    output wire [5:0] vga_g;
    output wire [4:0] vga_b;
    output wire vga_hsy;
    output wire vga_vsy;

	mux mux_D(rd, tmpRd_mem, tmpRd_alu, MD);	// rd = MD ? RDALU : RDMEM

	RegFile rf(
		.ax(ax), .bx(bx), .cx(cx), .dx(dx),
		.ra(ra), .rb(rb), 						//	output: ra, rb (data)
		.wr(WR), .rd(rd),
		.addr_lock(addr_lock), 
		.aa(aa), .ab(ab), .ad(ad), .clk(m_clk), .rst_n(rst_n)		// faster clock for register file 
	);//	input W/R, rd, aa (address), ab, ad, clk, rst_n
	
	ArithmeticLogicUnit alu(tmpRd_alu,	flags,			//	output: rd	
		ra, rb, inst, inst_clk);			//	input: ra, rb, instruction
	
	ControlUnit cu(.amem(amem), .aa(aa), .ab(ab), .ad(ad),
	   	.wr(WR), .md(MD), .mw(MW), .addr_inst(addr_lock),	//	output: wr
		.inst(inst), .clk(clk), .m_clk(m_clk), .rst_n(rst_n));
	
	Memory mem(
		.clka(clk), .wea(MW), .addra(amem), .dina(rb), .clkb(clk), .addrb(amem), .doutb(tmpRd_mem)
	);

	InstPub ip(
		.inst(inst),
		.addr_mem(inst_mem),
		.flags(flags),
		.addr_lock(addr_lock),
		.i_clk(inst_clk),
		.clk(clk),
		.rst_n(rst_n)
	);

	/*
	MachineClock mc(
		.CLK_IN1(clk),
		.CLK_OUT1(m_clk),			// 10 MHz
		.CLK_OUT2(),				// 25 MHz
		.RESET(~rst_n),
		.LOCKED(locked)
	);*/

   /****** Machine clock generation *********/
   reg[1:0] counter, inst_counter;
   always @ (posedge clk or negedge rst_n) begin
	   if(!rst_n)
		   counter <= 0;
	   else if(counter == 2'b10)
		   counter <= 0;
	   else
		   counter <= counter + 2'b01;
   end

   always @ (negedge clk or negedge rst_n) begin
	   if(!rst_n)
		   inst_counter <= 0;
	   else if(inst_counter == 2'b10)
		   inst_counter <= 0;
	   else inst_counter <= inst_counter + 2'b01;
   end 

   always @ (posedge clk or negedge rst_n) begin
	   if(!rst_n)
		   m_clk <= 1'b0;
	   else if(counter == 2'b01)
		   m_clk <= ~m_clk;
   end

   always @ (negedge clk or negedge rst_n) begin		// instruction clock is 50% ahead of m_clk
	   if(!rst_n)
		   inst_clk <= 1'b0;
	   else if(counter == 2'b0)
		   inst_clk <= ~inst_clk;
   end

   reg status;				// activate chipscope
   reg rst_tmp1, rst_tmp2;
   always @ (posedge clk) rst_tmp1 <= rst_n;
   always @ (posedge clk) rst_tmp2 <= rst_tmp1;
   always @ (posedge clk) begin
	   if({rst_n, rst_tmp2} == 2'b10)
		   status <= 1'b1;
	   else
		   status <= 1'b0;
   end

   LedOut lo(
	   .led_out(led_out),
	   .clk(clk),
	   .rst_n(rst_n),
	   .key_in(key_in),
	   .ax(ax),
	   .bx(bx),
	   .cx(cx),
	   .dx(dx)
   );

   wire [35:0] CONTROL;
   wire [127:0] TRIG;
   ChipScope cs_icon(.CONTROL0(CONTROL));
   ChipScope_ILA cs_ila(
	   .CONTROL(CONTROL),
	   .CLK(clk),
	   .TRIG0(TRIG)
   );

   assign TRIG[7:0] = rd;
   assign TRIG[15:8] = rb;
   assign TRIG[23:16] = ra;
   assign TRIG[31:24] = dx;
   assign TRIG[39:32] = cx;
   assign TRIG[47:40] = bx;
   assign TRIG[55:48] = ax;
   assign TRIG[63:56] = inst;
   assign TRIG[64:64] = m_clk;
   assign TRIG[65:65] = inst_clk;
   assign TRIG[66:66] = rst_n;
   assign TRIG[67:67] = status;

   vga_char shower(clk, rst_n, ax, bx, cx, dx, vga_r, vga_g, vga_b, vga_hsy, vga_vsy);


endmodule
