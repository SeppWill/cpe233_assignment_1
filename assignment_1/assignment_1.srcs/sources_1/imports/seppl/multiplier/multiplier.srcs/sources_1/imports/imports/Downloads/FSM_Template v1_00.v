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

module fsm_template(co, gt, done, btn, up, we, clr, ws, ds, clk, PS); 
    input  co, btn, clk, gt, done; 
    output reg up, we, clr, ds;
    output reg [1:0] ws;
    output reg [2:0] PS;
     
    reg [2:0] NS;//, PS; 
    parameter [4:0] WAIT=3'b000, TRANSFER=3'b001, SORT=3'b010, SWAP1=3'b011, SWAP2=3'b100, CHECK=3'b101, TRANSFER2=3'b110; 
    

    //- model the state registers
    always @ (posedge clk)
       PS <= NS; 
    
    
    //- model the next-state and output decoders
    always @ (*)
    begin
       case(PS)
          WAIT:
             begin
                we = 0;
                ws = 2'b00;
                up = 0;
                ds = 1;
                clr = 1;
                if (btn == 0)
                begin
                    NS = WAIT;
                    clr = 0;
                end  
                else
                begin
                    NS = TRANSFER;
                    clr = 1;
                    up = 1;
                end  
             end
          
          TRANSFER:
             begin
                we = 1;
                ws = 2'b00;
                up = 1;
                ds = 1;
                clr = 0;
                if (co == 0)
                begin
                    NS = TRANSFER;
                end
                else
                begin
                    NS = TRANSFER2;
                    //up=0;
                end
             end
             
          TRANSFER2:
            begin
                we = 1;
                ws = 2'b00;
                up = 0;
                ds = 1;
                clr = 0;
                NS = SORT;
             end
             
          SORT:
             begin
                we = 0;
                ws = 2'b01;
                up = 1;
                clr = 0;
                if (gt == 1)
                begin
                    up = 0;
                    NS = SWAP1;
                end
                else if (done == 1)
                begin
                    NS = WAIT;
                end
                else if (co == 1)
                begin
                    NS = SORT;
                    clr = 1;
                end
                else
                begin
                    NS = SORT;
                end
             end
             
          SWAP1:
             begin
                up = 1;
                we = 1;
                ws = 2'b10;                
                if (co)
                begin
                    NS = CHECK;
                    we = 0;
                end
                else
                begin
                    NS = SWAP2;
                    we = 1;
                end
             end
             
          SWAP2:
            begin
                up = 1;
                we = 1;
                ws = 2'b11;
                if (co)
                begin
                    NS = CHECK;
                    //we = 0;
                end
                else
                begin
                    NS = SORT;
                    //we = 1;
                end
             end
          
          CHECK:
             begin
                we = 0;
                ws = 2'b00;
                up = 0;
                if (done == 0)
                begin
                    NS = SORT;
                    clr = 1;
                end
                else
                begin
                    NS = WAIT;
                end
             end
             
          default: NS = WAIT; 
            
          endcase
      end              
endmodule


