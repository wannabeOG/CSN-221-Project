

module ALU (alu_out, zero, funct, data1, data2);
	output zero;
	output reg [31:0] alu_out;
	input [31:0] data1,data2;
	input [3:0] funct;

`define CERO 4'b0000
`define ADD  4'b0001
`define SUB  4'b0010
`define AND  4'b0011
`define OR   4'b0100
`define NOT  4'b0101
`define XOR  4'b0110
`define LSL  4'b0111	
`define RSL  4'b1000

	assign zero=~(|alu_out); // 
always @(funct,data1,data2)
begin
  case (funct)
    `ADD: alu_out=data1+data2;
    `SUB: alu_out=data1-data2;
    `AND: alu_out=data1&data2;
    `OR:  alu_out=data1|data2;
    `NOT: alu_out=~data1;
    `XOR: alu_out=data1^data2;
    default:alu_out=32'b0;
  endcase
end

endmodule
