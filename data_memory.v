`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 12:45:44 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory(


	clk,		//clock
	addr,
	rdata,
	wdata,
	wren
);

    //Following are the input ports to one of the modules.
    
	input clk;
    input [31:0] addr;
	input [31:0] wdata;
	input [3:0] wren;
	
   //The only output port which reads data, is assigned a variable rdata.
   
    output [31:0] rdata;

    //We have here 4 memory units, each of which has 65536 (8 bit locations). 
 
    reg	[7:0] memory_lane0	[65535:0];
    reg	[7:0] memory_lane1	[65535:0];
    reg	[7:0] memory_lane2	[65535:0];
    reg	[7:0] memory_lane3	[65535:0];
    
    //The output port takes up 8 bit from each of the memory unit, adding up to 32 bit data which was supposed to be read.
    //This is done using the command assign.
   
	assign rdata = {
						memory_lane3[addr[17:2]],
						memory_lane2[addr[17:2]],
						memory_lane1[addr[17:2]],
						memory_lane0[addr[17:2]]
					};
    //Our operations are active on the rising edge i.e. the positive clock edge.
    //If write enable(denoted by wren[i]) is assigned a value 1, the data is assigned to a particular location in the memory unit.
    						
	
    always @(posedge clk)
	begin
		if (wren[0])
			memory_lane0[addr[17:2]] <= wdata[7:0];
			
		if (wren[1])
			memory_lane1[addr[17:2]] <= wdata[15:8];
			
		if (wren[2])
			memory_lane2[addr[17:2]] <= wdata[23:16];
			
		if (wren[3])
			memory_lane3[addr[17:2]] <= wdata[31:24];
	end
	
 endmodule  


