`timescale 1ns / 1ps


module control unit {
  instruction,
	data_mem_wren, 
	reg_file_wren,
	reg_file_dmux_select,
	reg_file_rmux_select,
	alu_mux_select,
	alu_control,
	alu_zero,
	pc_control
  }
  
// INPUT PORT TO THE CONTROL UNIT.

// This is the 32 bit instructions that will be sent to the control unit for interpretation. 
input [31:0] instruction;

 // OUTPUT PORT OF THE CONTROL UNIT 
 
  // Will be sent to the data memory for write enable access. It is a 4 bit wire since the design involves using 4 RAM blocks
  output [3:0] data_mem_wren;  
  // Enables write action on the register file                               
  output reg_file_wren;
  //output reg_file_dmux_select;
	//output reg_file_rmux_select;
	// This is the wire to select the ALU if it is being called in the instruction. 
  output alu_mux_select;
	output [3:0] alu_control;
  // PC has 4 functions which necessiates the usage of a 3 bit addressing scheme.
	output [2:0] pc_control;
  
  // Setting the names of the instruction field as follows;
  
  reg [4:0] rs;
  reg [4:0] rt;
  reg [4:0] rd;
  reg [4:0] shamt;
  reg [5:0] funct;
  //reg [2:0] type;
	reg [25:0] address;
	reg [15:0] immediate;
  //6 bit opcode
	wire [5:0] op;
  
  // Demarcating the instruction set
  
  // This design makes sure that the the last 6 bits of an instruction are the opcode. So assigning the last 6 bits of an 
  // instruction as the opcode.
  
  assign op = instruction[31:26];
  
  always @(instruction)
	begin
  
 // R Format instruction. We are assigning it a opcode of 000000 for the decoder to understand that it is a R format instruction 
  if (op == 6'b000000) begin
			address		= 26'b00000000000000000000000000; // Since there is no address to go to 
			immediate	= 16'b0000000000000000; 
			rs			= instruction[25:21];
			rt			= instruction[20:16];
			rd			= instruction[15:11];
			shamt		= instruction[10:6];
			//type		= 3'b001;
			funct		= instruction[5:0];
		end
    //  J Format instruction. We are assigning it an opcode of 000010 for the decoder to understand that it is a J format instruction
    else if (op == 6'b000010) begin 
			address		= instruction[25:0]; // Jumping to the address that is given. 
			immediate	= 16'b0000000000000000;
			rs			= 5'b00000;
			rt			= 5'b00000;
			rd			= 5'b00000;
			shamt		= 5'b00000;
			//type		= 3'b100;
			funct		= 6'b000000; 
		end
    // I format instruction. This is used for an immediate addition wherein the immediate part will be sign extended to 32 bits for proper operation. 
    else begin 
			address		= 26'b00000000000000000000000000;
			immediate	= instruction[15:0];
			rs			= instruction[25:21];
			rt			= instruction[20:16];
			rd			= 5'b00000;
			shamt		= instruction[10:6];
			//type		= 3'b010;
			funct		= instruction[5:0];
		end
  
  
  
  
  
