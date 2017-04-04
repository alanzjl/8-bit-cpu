# 8-bit-cpu
A simple 8-bit RISC cpu that runs self-defined assemble language. Built with verilog, tested on Xilinx XC6XLS45 (Spartan 6). Compilter is written in python, and commands are sent via UART.

## Author
This work is finished by Alan Zhao, you can visit [my homepage](http://alanzjl.com) for more information about this project.

Contact with me: alanzjl@126.com

## Basic registers and their addresses
|	Register Name	|	Address	|
|	-------------	|	-------	|
|	AX				|	00		|
|	BX				|	01		|
|	CX				|	10		|
|	DX				|	11		|

## Register Instructions

|	Code		|	Function			|
|	----------	|	---------------		|
|	0000 xx xx  |	LOAD TMP, {DX, xxxx}|
|	0001 RD xx	|	STORE RD, {DX, xx}	|
|	0010 RD xx	|	MOV RD, TMP			|

**The 12-bit address is made up of 4 bits from the current instruction and 8 bits from the next instruction.**

***PS: This should have been a 16-bit CPU... I don't know what happened to me that night...***

## Branch Instructions

|	Code		|	Function			|
|	----------	|	---------------		|
|	1100 OFFSET	|	Branch Zero			|
|	1101 OFFSET	|	Branch Carry		|
|	1110 OFFSET	|	Branch Overflow		|
|	1111 OFFSET	|	Branch Negative		|
|	0011 1111  	|	HALT				|

*For Branch instructions, address of the next instruction is the sum of OFFSET and the address of the current instruction.* **OFFSET is a signed number between -8 and 7**

## Arithmetic Logic Unit (ALU) Instructions

*Addition:*

|	Code		|	Function		|
|	--------	|	--------------	|
|	1000 RD xx	|	RD -> RD + 1	|
|	1001 RD xx	|	RD -> RD - 1	|
|	1010 RD RS	|	RD -> RD + RS	|
|	1011 RD RS	|	RD -> RD - RS	|

*Multiplication:*

|	Code		|	Function								|
|	--------	|	--------------							|
|	0100 RD RS	|	(*unsigned*)	RD -> RD[3:0] * RS[3:0]	|
|	0101 RD RS	|	(*signed*)	 	RD -> RD[3:0] * RS[3:0]	|

*Division:*

|	Code		|	Function												|
|	--------	|	--------------											|
|	0110 RD RS	|	(*unsigned*)	RD[3:0] -> RD[7:0]/RS[3:0] MOD: RD[7:4]	|
|	0111 RD RS	|	(*signed*)	 	RD[3:0] -> RD[7:0]/RS[3:0] MOD: RD[7:4]	|

## Flags
|	Position	|	Function			|
|	--------	|	-------------		|
|	0000000x	|	ZF: zero flag		|
|	000000x0	|	CF: carry flag		|
|	00000x00	|	OF: overflow flag	|
|	0000x000	|	NF: negative flag	|