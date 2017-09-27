`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 12:03:13 AM
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file
(
	clk,	//clock
	raddr0,
	rdata0,
	raddr1,
	rdata1,
	waddr,
	wdata,
	wren
);
	// Input Ports
	input	clk;
  input [4:0]	raddr0;
	input [4:0]	raddr1;
	input [4:0]	waddr;
	input	[31:0] wdata;
	input wren;
	//Output Ports	
  output [31:0] rdata0;
	output [31:0]	rdata1; 
    
    
    // Signal Declarations: reg    
    reg	[31:0] reg_file	[31:0];
		
	// Combinational Logic
	assign rdata0 = reg_file[raddr0];
	assign rdata1 = reg_file[raddr1];
	
	// Sequential Logic
	
	integer i;
	
	initial
	begin	
	    for(i = 0; i < 32; i = i+1)
		begin
	        reg_file[i] = 0;
		end
	end
    always @(posedge clk)
	begin
		if (wren) begin
			reg_file[waddr] <= wdata;
		end
	end
	
 endmodule
