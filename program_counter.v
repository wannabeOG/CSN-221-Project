`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:			Pennsylvania State University
//					
// Engineer: 		Uffaz Nathaniel
//
// Create Date:		4/26/2013
// Design Name: 	Program Counter
// Module Name:     program_counter
// Project Name:	Processor
// Target Devices: 	N/A
// Tool versions:	N/A
// Description:		Describes a program counter
//
// Dependencies:	N/A
//
// Revision:		N/A
//
//
// Additional Comments: N/A
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module program_counter
(
	clk,	//clock
	rst,
	pc,
	pc_control,
	jump_address,
	branch_offset,
	reg_address
);

    //--------------------------
	// Parameters
	//--------------------------	
	
    //--------------------------
	// Input Ports
	//--------------------------
	// < Enter Input Ports  >
	input						clk;
	input						rst;
	input				[2:0]	pc_control;
	input				[25:0]	jump_address;
	input				[15:0]	branch_offset;
	input				[31:0] 	reg_address;
	
    //--------------------------
    // Output Ports
    //--------------------------
    // < Enter Output Ports  >	
    output 	reg	[31:0] 	pc;
		
    //--------------------------
    // Bidirectional Ports
    //--------------------------
    // < Enter Bidirectional Ports in Alphabetical Order >
    // None
      
    ///////////////////////////////////////////////////////////////////
    // Begin Design
    ///////////////////////////////////////////////////////////////////
    //-------------------------------------------------
    // Signal Declarations: local params
    //-------------------------------------------------
   
    //-------------------------------------------------
    // Signal Declarations: reg
    //-------------------------------------------------    
	
    //-------------------------------------------------
    // Signal Declarations: wire
    //-------------------------------------------------
	wire	[31:0]	pc_plus_4;
	
	//---------------------------------------------------------------
	// Instantiations
	//---------------------------------------------------------------
	// None

	//---------------------------------------------------------------
	// Combinatorial Logic
	//---------------------------------------------------------------
	assign pc_plus_4 = pc + 4;
	
	//---------------------------------------------------------------
	// Sequential Logic
	//---------------------------------------------------------------
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



