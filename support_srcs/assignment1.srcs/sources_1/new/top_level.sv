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
    input clk,
    output logic ANODES,
    output logic CATHODES,
    output  logic LEDS
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
    logic CLK;
    logic gt;
    logic RAM_WE; // LED password state indication
    logic CNT_EN; // LED password state indication
    logic WS; // LED password state indication
    logic DS;  // password recording state
    logic SORTED_CLR;
    logic btn;
    //clk divider and debounce
    
    clk_div clk_div(.clk(clk), .sclk(CLK));
    debounce_one_shot one_shot(.CLK(CLK), .BTN(BTN), .DB_BTN(btn));
    assign LEDS = cnt; 
    cntr_udclr_nb counter (.clk(CLK), .clr(CNT), .up(CNT_EN), .count(cnt));
  
    
    Rom_16x8 ROM (.CLK(CLK), .ADDR(cnt), .DATA(data));
    
    
    ram ram (.CLK(CLK), .WR(RAM_WE), .DIN(t1), .ADDRX(cnt), .ADDRY(cnt+1), .DX_OUT(x), .DY_OUT(y));
    
    mux mux4_2(.ws(), .zero(data), .one(t2), .two(y), .D(t1)); // ws from fsm and one from x reg
    mux2_1 mux2_1(.DS(DS), .zero(x), .one(data));
    
    logic Done = ~t3 + CNT_14;
    
    FSM_CHECKER fsm (.BTN(btn), .gt(gt),.CNT_15(CNT_15), .Done(Done), .CNT_14(CNT_14), .RAM_WE(RAM_WE), .CNT_EN(CNT_EN), .CNT_CLR(CNT_CLR), .WS(WS), .DS(DS), .SORTED_CLR(SORTED_CLR));
    
    x_reg x_reg (.X(x), .CLK(CLK), .D(t2));
    sort_reg sorted_reg (.LD(gt), .sorted_CLR(SORTED_CLR), .CLK(CLK), .D(t3)); // LD will come from compare 
    
   
    compare compare (.x(x), .y(y), .gt(gt)); 
    SevSegDisp sseg(.CLK(clk), .MODE(0), .DATA_IN(x), .CATHODES(CATHODES), .ANODES(ANODES));
    always_comb
    begin
      if (cnt == 14)
        CNT_14 = 1;
      else
       CNT_14 = 0;
      if (cnt == 15)
         CNT_15 = 1;
      else
         CNT_15 = 0;
    end
    
    
endmodule
