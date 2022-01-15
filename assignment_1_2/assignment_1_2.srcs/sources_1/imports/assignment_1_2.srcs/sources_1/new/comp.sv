`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 12:00:06 AM
// Design Name: 
// Module Name: comp
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


module comp(a, b, eq, lt, gt);
    parameter n = 4;
    input [n-1:0] a, b;
    output reg eq, lt, gt;
    
    always @ (a,b)
    begin
        if (a == b)
        begin
            eq = 1; lt = 0; gt = 0;
        end
        else if (a > b)
        begin
            eq = 0; lt = 0; gt = 1;
        end
        else if (a < b)
        begin
            eq = 0; lt = 1; gt = 0;
        end
        else
        begin
            eq = 0; lt = 0; gt = 0;
        end
    end
endmodule
