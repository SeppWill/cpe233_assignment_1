`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2022 03:13:29 PM
// Design Name: 
// Module Name: top_level
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


module top_level(
    input BTN,
    input CLK,
    output ANODES,
    output SEGMENTS,
    output LEDS
    );
    logic t1; // mux42 to RAM
    logic [7:0] x;
    logic [7:0] y;
    logic cnt;
    logic [7:0] data;
    logic [7:0] t2; // x register to mux
    logic t3; // from sorted reg to and gate
    logic CNT_14;
    logic CNT_CLR;
    logic CNT_15; // enter button

    logic gt;
    logic RAM_WE; // LED password state indication
    logic CNT_EN; // LED password state indication
    logic WS; // LED password state indication
    logic DS;  // password recording state
    logic SORTED_CLR;
    //clk divider and debounce
    cntr_udclr_nb counter (.clk(CLK), .clr(CNT), .up(CNT_EN), .count(cnt));
    
    Rom_16x8 ROM (.clk(CLK), .ADDR(cnt), .DATA(data));
    
    
    ram ram (.CLK(CLK), .WR(), .DIN(t1), .ADDRX(cnt), .ADDRY(cnt+1), .DX_OUT(x), .DY_OUT(y));
    
    mux mux4_2(.ws(), .zero(data), .one(t2), .two(y), .D(t1)); // ws from fsm and one from x reg
    mux2_1 mux2_1(.DS(), .zero(x), .one(data));
    
    logic Done = ~t3 + CNT_14;
    
    FSM_CHECKER fsm (.BTN(BTN), .gt(gt),.CNT_15(), .Done(Done), .CNT_14(CNT_14), .RAM_WE(RAM_WE), .CNT_EN(CNT_EN), .CNT_CLR(CNT_CLR), .WS(WS), .DS(DS), .SORTED_CLR(SORTED_CLR));
    
    x_reg x_reg (.X(x), .CLK(CLK), .D(t2));
    sort_reg sorted_reg (.LD(), .sorted_CLR(SORTED_CLR), .CLK(CLK), .D(t3)); // LD will come from compare 
    
   
    //compare
    
    //display
 
    
    
    
endmodule
