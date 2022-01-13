`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2022 01:04:00 PM
// Design Name: 
// Module Name: sort_reg
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


module x_reg(
input [7:0] X, //switches
 input CLK, 
 output logic [7:0]D // this is output 3 bit password
// input BTN // enter button

 ); // created 

always_ff @ (posedge CLK) //Register with sync load behavior
begin
//if ((create == 0)&&(EN == 1)) 
 D = X; //saved 3 bit entered password
 end
 
endmodule