`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2022 12:03:59 PM
// Design Name: 
// Module Name: bubble_sort
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


module bubble_sort(
    input cnt_x,
    input cnt_y,
    input r_memory
    
    );
    always_comb
    begin
   //int i;
   int j; 
   logic [7:0] temp;
  if (ADDRY == 4'b1111)
     //for (i=0; i<16; i++) begin
         for (j=0; j<16; j++) begin
             if (r_memory[j] > r_memory[j+1])
               temp = r_memory[j];
               r_memory[j] = r_memory[j+1];
               r_memory[j+1] = temp;
               
        
         //end
     end
    end
endmodule
