`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 02:54:41 AM
// Design Name: 
// Module Name: control_unit
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
		else if (op == 6'b000010 || op == 6'b000011) begin 
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
		
		
     
// ALU MUX SELECT
		
 // ALU needs to be selected for R-Format and I-Format instructions so ALU_MUX_SELECT gets set to 1 and and gets set to 0 for  
 // J-Format instructions.


      if (!(op == 6'h0 || op == 6'b000010 || op == 6'b000011)) begin // J format
      alu_mux_select = 1;
      end 
      else begin // R or I format
      alu_mux_select = 0;
      end

// ALU CONTROL UNIT 
		
// ALU format is synchronized with the control unit wherein the alu_control specifies the type of the operaation that the ALU
// will perform given the signal it receives from the control unit.
		
// Op code specifies the type of instruction that will be performed, and funct is an additional 6 bit instruction to tell the 
// computer about the type of instruction that has to be performed by the ALU. The funct bits have been allotted in an 
// arbitrary manner.

                if (op == 6'h0 && funct == 6'h24) begin // AND
			alu_control = 4'b0000;
		end else if (op == 6'h0 && funct == 6'h25) begin // OR
			alu_control = 4'b0001;
		end else if (op == 6'h0 && funct == 6'h21) begin // ADD - unsigned
			alu_control = 4'b0010; 
		end else if (op == 6'h0 && funct == 6'h26) begin // XOR
			alu_control = 4'b0011;
		end else if (op == 6'h0 && funct == 6'h27) begin // NOR
			alu_control = 4'b0100;
		end else if (op == 6'h0 && funct == 6'h22) begin // SUBTRACT - unsigned
			alu_control = 4'b0110;
		end else if (op == 6'h0 && funct == 6'h2A) begin // SLT
			alu_control = 4'b0111;
		end else if (op == 6'h0 && funct == 6'h0) begin // SLL
			alu_control = 4'b1000;
		end else if (op == 6'h0 && funct == 6'h2) begin // SRL
			alu_control = 4'b1001;
		end else if ((op == 6'h0 && funct == 6'h20) || op == 6'h8 || op == 6'h2B || op == 6'h23) begin  // ADD - signed
			alu_control = 4'b1011;
		end else if ((op == 6'h0 && funct == 6'h22) || op == 6'h4 || op == 6'h5) begin // SUB - signed - AND bne, beq
			alu_control = 4'b1100;
		end else begin
			alu_control = 4'b1111;
		end	
		
		
 // This is the control unit for the PC register, the 4 bit instructions specify the type of the function that the program 
 // counter will perform, these are and not limited to the following, for a J-ype instruction, fora normal increment,
 // gets incremented by 4 for next instruction, for a write enable to the registers.
		

            if (op == 6'h2 || op == 6'h3) begin // j, jal
	        pc_control = 3'b001;
	    end 
	else if (op == 6'h0 && funct == 6'h8) begin // jr
		pc_control = 3'b010;
	    end 
		else if (op == 6'h4 && alu_zero == 1) begin // beq
	        pc_control = 3'b011;
	    end 
		else if (op == 6'h5 && alu_zero == 0) begin // bne
		pc_control = 3'b011;
	    end 
		else begin // Default
		pc_control = 3'b000;
		end
		
		
	end
		
	end module 
		
  
  
  
  
  
