`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 01:14:02 AM
// Design Name: 
// Module Name: alu
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


module alu

(
    control,	//specifies the alu operation to be performed
    operand0, 	//first operand
    operand1, 	//second operand
    result, 	//alu result after the operation
    overflow,	//overflow flag, also the underflow flag
    zero 	//zero flag
);

   
    input [3:0]	 control;
    input [31:0] operand0; 
    input [31:0] operand1;
	
   	
    output [31:0] result; //this is the 32 bit result
    output overflow;
    output zero;

      
   
    reg [31:0] result;
    reg overflow;
    reg zero;
	
   
	always @(control)
	begin
	
		case (control)
			4'b0000 : // and 
				begin
					result = operand0 & operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end	
			4'b0001: // or 
				begin
					result = operand0 | operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end	
			4'b0010: // add 
				begin
					result = operand0 + operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
			4'b0011: // xor 
				begin
					result = operand0 ^ operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
			4'b0100: // nor 
				begin
					result = ~(operand0 | operand1);
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
			4'b0110: // subtract 
				begin
					result = operand0 - operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
			4'b0111: // set on less than 
				begin
					result = (operand0 < operand1) ? -1 : 0;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
			4'b1000: // shift left logical 
				begin
					result = operand0 << operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
			4'b1001: // shift right logical
				begin
					result = operand0 >> operand1;
					overflow = 0;
					zero = (result == 0) ? 1 : 0;
				end
		
				
			4'b1011: // Signed add
				begin
					result = operand0 + operand1;
					//This will check for overflow condition
					
					if ((operand0 >= 0 && operand1 >= 0 && result < 0) ||(operand0 < 0 && operand1 < 0 && result >= 0)) 
					   begin
						overflow = 1;
					   end 
					else 
					     begin
						   overflow = 0;
					     end
					
					zero = (result == 0) ? 1 : 0;
					
					
			       end
			4'b1100: // Signed subtract
				begin
					result = operand0 - operand1;
					//This will check for overflow condition
					
					if ((operand0 >= 0 && operand1 < 0 && result < 0)||(operand0 < 0 && operand1 >= 0 && result >= 0)) 
					   begin
						overflow = 1;
					   end 
				        else 
					    begin
						overflow = 0;
					    end
					
					zero = (result == 0) ? 1 : 0;
					
				
				end
			default:
				begin
					zero = 0;
					overflow = 0;
				end				
		endcase
		
	end

	
	
    
 endmodule

