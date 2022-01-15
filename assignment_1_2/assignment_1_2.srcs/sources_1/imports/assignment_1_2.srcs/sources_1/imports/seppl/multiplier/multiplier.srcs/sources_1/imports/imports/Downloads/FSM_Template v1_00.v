`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Ratner Surf Designs
// Engineer:  James Ratner
// 
// Create Date: 07/07/2018 08:05:03 AM
// Design Name: 
// Module Name: fsm_template
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Generic FSM model with both Mealy & Moore outputs. 
//    Note: data widths of state variables are not specified 
//
// Dependencies: 
// 
// Revision:
// Revision 1.00 - File Created (07-07-2018) 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_template(co, btn, clk, ld, cclr, rclr); 
    input  co, btn, clk;
    output reg ld, cclr, rclr;
     
    reg [1:0] NS, PS; 
    parameter WAIT=2'b00, SETUP=2'b01, COUNT=2'b10, RETURN=2'b11; 
    

    //- model the state registers
    always @ (posedge clk)
       PS <= NS; 
    
    
    //- model the next-state and output decoders
    always @ (*)
    begin
       case(PS)
          WAIT:
             begin
                ld = 0;
                cclr = 0;
                rclr = 0;
                if (btn == 0)
                begin
                    NS = WAIT;
                end  
                else
                begin
                    NS = SETUP;
                    cclr = 1;
                end  
             end
          
          SETUP:
             begin
                ld = 0;
                cclr = 0;
                rclr = 1;
                NS = COUNT;
             end
             
          COUNT:
             begin
                ld = 1;
                cclr = 0;
                rclr = 0;
                if (co == 0)
                begin
                    NS = COUNT;
                end  
                else
                begin
                    NS = RETURN;
                end  
             end
          
          RETURN:
             begin
                ld = 1;
                rclr = 0;
                cclr = 1;
                NS = WAIT;
             end
             
          default: NS = WAIT; 
            
          endcase
      end              
endmodule


