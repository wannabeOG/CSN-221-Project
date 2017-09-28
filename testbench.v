`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 03:03:18 AM
// Design Name: 
// Module Name: testbench
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


module testbench;
reg [31:0] operand0;
    reg [31:0] operand1;
    reg [3:0] control;
    
    wire [31:0] result;
     reg [31:0] actual;
      wire [31:0] ifcorrect;
     uut alu( 
     .control(control), 
     .operand1(operand1), 
     .operand0(operand0),
      .result(result)
      )  ;
       
        initial begin
              
              // Add
              control = 4'b0010;
               operand0 = 32'hffffff68; 
                     operand1 = 32'hffffff34; 
               actual  = 32'hffffff34; 
                 #10
                     
                    operand0 = 32'hffffffff; 
                     operand1 = 32'h00000000; 
                     actual = 32'hffffffff; 
                     #10
                     
                     operand0 = 32'haaaaaaaa; 
                     operand1 = 32'haaaaaaaa; 
                     actual = 32'hffffff34; 
                     #10
                     
                     // Subtract
                             control = 6'b0110;
                             
                             operand0 = 32'hffffff68; 
                             operand1 = 32'hffffff34; 
                             actual = 32'h00000034; 
                             #10
                             
                             operand0 = 32'h00000000; 
                             operand1 = 32'hffffff34; 
                             actual = 32'h000000cc; 
                             #10
                             
                             operand0 = 32'hffffffff; 
                             operand1 = 32'hffffff34; 
                             actual = 32'h000000cb; 
                             #10
                              // AND
                                    control = 6'b0000;
                                    
                                    operand0 = 32'hffffff68; 
                                    operand1 = 32'hffffff34; 
                                    actual = 32'h00000034; 
                                    #10
                                    
                                    operand0 = 32'h00000000; 
                                    operand1 = 32'hffffff34; 
                                    actual = 32'h000000cc; 
                                    #10
                                    
                                    a = 32'hffffffff; 
                                    b = 32'hffffff34; 
                                    expected = 32'h000000cb; 
                                    #10
                             
                // OR
                                          control = 6'b0001;
                                           
                                           operand0 = 32'hffffff68; 
                                          operand1 = 32'hffffff34; 
                                           actual = 32'h00000034; 
                                           #10
                                                                                      
                                           operand0 = 32'h00000000; 
                                           operand1 = 32'hffffff34; 
                                           actual = 32'h000000cc; 
                                           #10
                                           
                                           operand0 = 32'hffffffff; 
                                           operand1 = 32'hffffff34; 
                                           actual = 32'h000000cb; 
                                           #10
               
                // XOR
                                                 control = 6'b0011;
                                                  
                                                  operand0 = 32'hffffff68; 
                                                  operand1 = 32'hffffff34; 
                                                  actual = 32'h00000034; 
                                                  #10
                                                  
                                                  operand0 = 32'h00000000; 
                                                  operand1 = 32'hffffff34; 
                                                  actual = 32'h000000cc; 
                                                  #10
                                                  
                                                  operand0 = 32'hffffffff; 
                                                  operand1 = 32'hffffff34; 
                                                  actual = 32'h000000cb; 
                                                  #10
                // NOR
                                                         control = 6'b010110;
                                                         
                                                         operand0 = 32'hffffff68; 
                                                          operand1 = 32'hffffff34; 
                                                         actual = 32'h; 
                                                         #10
                                                         
                                                        operand0  = 32'h00000000; 
                                                         operand1 = 32'hffffff34; 
                                                         actual = 32'h000000cc; 
                                                         #10
                                                         
                                                         operand0 = 32'hffffffff; 
                                                        operand1 = 32'hffffff34; 
                                                         actual = 32'h000000cb; 
                                                         #10
               
               
endmodule
