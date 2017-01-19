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

## Arithmetic Logic Unit (ALU) Instructions
|	Code		|	Function		|
|	--------	|	--------------	|
|	1000 RD xx	|	RD -> RD + 1	|
|	1001 RD xx	|	RD -> RD - 1	|
|	1010 RD RS	|	RD -> RD + RS	|
|	1011 RD RS	|	RD -> RD - RS	|
