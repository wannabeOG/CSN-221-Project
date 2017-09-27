`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 12:53:39 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
	clk,	//clock
	rst,
	pc,
	pc_control,
	jump_address,
	branch_offset,
	reg_address
);
	input clk;
	input rst;
	input [2:0]	pc_control;
	input [25:0] jump_address;
	input [15:0] branch_offset;
	input [31:0] reg_address;
	
    output 	reg	[31:0] 	pc;
		
    wire [31:0]	pc_plus_4;
	assign pc_plus_4 = pc + 4;
	
    always @(posedge clk or posedge rst)
	begin
		if (rst)
		begin
			pc <= 32'd0;
		end
		else
		begin
			case (pc_control)
				3'b000 : pc <= pc_plus_4;
				3'b001 : pc <= {pc_plus_4[31:28], jump_address, 2'b00};
				3'b010 : pc <= reg_address;
				3'b011 : pc <= pc_plus_4 + { {14{branch_offset[15]}}, branch_offset[15:0],  2'b00  };
				default: pc <= pc_plus_4;
			endcase
		end
	end
	
 endmodule  


   
