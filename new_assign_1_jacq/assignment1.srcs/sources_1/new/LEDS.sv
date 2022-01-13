`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 10:14:14 AM
// Design Name: 
// Module Name: LEDS
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


module LEDS(
    input [3:0] cnt,
    output logic [3:0] LEDS
    );
    
    always_comb
    begin
    LEDS = cnt;
    end
    
endmodule
