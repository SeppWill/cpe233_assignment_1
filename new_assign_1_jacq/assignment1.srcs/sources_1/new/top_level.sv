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
    output [3:0] ANODES,
    output [7:0] CATHODES,
    output [3:0] LEDS
    );
    logic [7:0] t1; // mux42 to RAM
    logic [7:0] x;
    logic [7:0] y;
    logic [3:0] cnt;
    logic [7:0] data;
    logic [7:0] t2; // x register to mux
    logic t3; // from sorted reg to and gate
    logic CNT_14;
    logic CNT_CLR;
    logic CNT_15; // enter button
    logic SCLK;
    logic gt;
    logic RAM_WE; // LED password state indication
    logic CNT_EN; // LED password state indication
    logic WS; // LED password state indication
    logic DS;  // password recording state
    logic SORTED_CLR;
    logic btn;
    logic [7:0]out;
    logic Done;
    logic [3:0] cnt_y;
    //clk divider and debounce
    
    clk_div clk_div(.clk(CLK), .sclk(SCLK));
    debounce_one_shot one_shot(.CLK(SCLK), .BTN(BTN), .DB_BTN(btn));

    cntr_udclr_nb counter (.clk(SCLK), .clr(CNT_CLR), .up(CNT_EN), .count(cnt)); // CNT_CLR
   
    LEDS(.cnt(cnt), .LEDS(LEDS));
    
    rca_nb rca (.a(cnt), .b(1), .cin(0), .sum(cnt_y)); // for y addr
    Rom_16x8 ROM (.CLK(SCLK), .ADDR(cnt_y), .DATA(data));
    ram ram (.CLK(SCLK), .WR(RAM_WE), .DIN(t1), .ADDRX(cnt), .ADDRY(cnt_y), .DX_OUT(x), .DY_OUT(y));
    
    mux mux4_2(.ws(WS), .zero(data), .one(t2), .two(y), .D(t1)); // ws from fsm and one from x reg
    mux2_1 mux2_1(.DS(DS), .zero(x), .one(data), .D(out));
    
    assign CNT_14 = cnt && 4'b1110;
    assign CNT_15 = cnt && 4'b1110;
    assign Done = ~t3 && CNT_14;
    
    FSM_CHECKER fsm (.CLK(SCLK), .BTN(btn), .gt(gt),.CNT_15(CNT_15), .Done(Done), .CNT_14(CNT_14), .RAM_WE(RAM_WE), .CNT_EN(CNT_EN), .CNT_CLR(CNT_CLR), .WS(WS), .DS(DS), .SORTED_CLR(SORTED_CLR));
    
    x_reg x_reg (.X(x), .CLK(CLK), .D(t2));
    sort_reg sorted_reg (.LD(gt), .sorted_CLR(SORTED_CLR), .CLK(CLK), .D(t3)); // LD will come from compare 
    
   
    compare compare (.x(x), .y(y), .gt(gt));  
   
    SevSegDisp sseg(.CLK(CLK), .MODE(0), .DATA_IN(out), .CATHODES(CATHODES), .ANODES(ANODES)); //out

    
endmodule
