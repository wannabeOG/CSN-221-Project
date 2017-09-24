

module ALU (alu_out, zero, funct, data1, data2);
	output zero;
	output reg [31:0] alu_out;
	input [31:0] data1,data2;
	input [2:0] funct;

`define CERO 3'b000
`define ADD 3'b001
`define SUB 3'B010
`define AND 3'b011
`define OR 3'b100
`define NOT 3'b101
`define XOR 3'b110

assign zero=~(|alu_out);

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
