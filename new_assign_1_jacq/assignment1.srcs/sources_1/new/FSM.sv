`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2022 12:36:25 PM
// Design Name: 
// Module Name: FSM
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


module FSM_CHECKER(
   input logic BTN, // enter butto
   input logic CNT_15, // enter button
   input logic Done, // enter butto
   input logic CNT_14, // enter button
   input logic gt,
    input logic CLK, // clock from clock divider
    
    output logic RAM_WE, // LED password state indication
    output logic CNT_CLR,  // password recording state
    output logic CNT_EN, // LED password state indication
    output logic WS, // LED password state indication
    output logic DS,  // password recording state
    output logic SORTED_CLR
    );
    //reg [2:0]NS, PS; // 
    parameter [2:0] a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100, f = 3'b101;
    //logic [2:0] g = 3'd6;
   logic [2:0] NS;
   logic [2:0] PS = a;
        //sequential logic to change states
    always_ff @ (posedge CLK) // reset add
    begin
         PS = NS;
    end
    
//always @ (BTN, PS, CNT_15, gt, CNT_14, Done)
always_comb 
    begin
    RAM_WE = 0; // LED password state indication
    CNT_CLR = 0;  // password recording state was commented out
    CNT_EN = 1; // LED password state indication
    WS = 0; // LED password state indication
    DS = 1;  // password recording state
    SORTED_CLR = 0; 
    case (PS)//This is going to be the case where the button is pressed
    
      a: // first password entering state
        begin
      //RAM_WE = 0; // LED password state indication
      CNT_CLR = 0;  // password recording state
     // CNT_EN = 1; // LED password state indication 
      CNT_EN = 1;
      DS = 1;
      if (BTN == 1) // if enable is presssed
      begin
          CNT_CLR = 1;
          CNT_CLR = 0;  // password recording state
          NS = b; //put b back
       end
      else // if no enable pressed, stay in the same state
      begin
          NS = a;
          end
         end
                  
         b: // second password entering state
         begin
           RAM_WE = 1;
           CNT_EN = 1; 
          // WS = 0;
            if (CNT_15 == 1)
            begin
                //SORTED_CLR = 0;
                NS = c;
            end
             else 
          begin
               NS = b;
                 end
         end

         c: // sorting state
         begin
            WS = 2; 
            CNT_EN = 1;
            if ((gt==0) &&(CNT_14 ==0)&& (Done ==0))
            begin
               NS = e;
            end
            if ((gt==0) &&(CNT_14 ==0)&& (Done ==1))
            begin
               NS = f;
            end
            else if (gt ==1)
            begin
                NS = d;
            end
           else 
          begin
               NS = c;
                 end       
         end
         
          d: // finished entering state
         begin
           RAM_WE = 1;
           WS  = 1;
            if (CNT_15 == 1) // entering to move to a state again
            begin
                NS = e;
            end
          else 
          begin
               NS = c; 
                 end
         end
         
         
         e: // finished entering state
         begin
           SORTED_CLR = 1;
           CNT_CLR = 1;
           NS = c;
         end
         
         
         f: // finished entering state
         begin
         DS = 0; 
         end
         default:
            NS = a; //a
      endcase    
      end
      
endmodule