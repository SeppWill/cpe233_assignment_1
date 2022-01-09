`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2018 01:00:34 AM
// Design Name: 
// Module Name: Rom
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


module Rom_16x8(
    input CLK,
    input [3:0] ADDR,
    output logic [7:0] DATA
    );
     
    (* rom_style="{distributed | block}" *)
    logic [7:0] rom[0:15];
    
    initial begin
        $readmemh("rom_data.mem", rom, 0, 15);
    end 
    
    always_ff @(posedge CLK) begin
        DATA <= rom[ADDR];
    end
              
endmodule
