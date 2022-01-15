`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2021 02:10:01 PM
// Design Name: 
// Module Name: comparator
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


module comparator(

    );
    reg btn, clk;
    wire [7:0] seg;
    wire [3:0] an;
    wire [15:0] led;
    
    RAM_Accumulator sim (.btn(btn), .clk(clk), .seg(seg), .an(an));
    
    initial
    begin
        clk = 0; //- init signal
        forever #10 clk = ~clk;
    end
    
    initial 
    begin
       btn = 1'b0;
       #20
       btn = 1'b1;
       #40
       btn = 1'b0;
    end
endmodule
