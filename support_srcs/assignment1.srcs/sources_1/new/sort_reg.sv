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


module sort_reg(
    input LD,
    input sorted_CLR,
    input CLK, 
    
    output logic D
    );


always_ff @ (posedge CLK) //Register with sync load behavior
begin
if (sorted_CLR)
   D = 0;
if (LD == 1) // if password is in the matching sequence state, record
   D = 1; //saved 3 bit entered password]
else
  D = 0;
 end

endmodule
