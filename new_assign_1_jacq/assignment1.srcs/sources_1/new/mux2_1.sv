`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2022 11:26:46 AM
// Design Name: 
// Module Name: mux2_1
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


module mux2_1(
    input [1:0] DS,
    input [7:0] zero,
    input [7:0] one,
    output logic [7:0] D
    );
    always_comb
    begin
    if (DS == 0)
        begin
         D = zero; //out = one;
        end
    else
        begin
         D = one; //out = one;
        end
     end
endmodule
