`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2022 03:23:54 PM
// Design Name: 
// Module Name: bubble_sort
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


module bubble_sort(
    input btn, clk,
    output [7:0] seg,
    output [3:0] an,
    output [15:0] led
    );
    
    wire sclk, clr, up, co, we, ds, gt, done, t;
    wire [1:0] ws;
    wire [3:0] ROM_ADDR;
    wire [4:0] count, count1, count2;
    reg [4:0] X_ADDR, Y_ADDR;
    wire [7:0] ROM_DATA, XD_OUT, YD_OUT;
    reg [7:0] D_IN, disp_DATA, X_REG;
    reg sorted;
    
    //clk_div CLOCK (
    //    .clk(clk),
    //    .sclk(sclk) );
        
    assign sclk = clk;
        
    Rom_16x8 ROM (
        .CLK(sclk),
        .ADDR(count),
        .DATA(ROM_DATA) );
        
    ram ram (
        .RF_ADDRX(X_ADDR),
        .RF_ADDRY(Y_ADDR),
        .RF_WR(we),
        .RF_CLK(sclk),
        .RF_DIN(D_IN),
        .RF_DX_OUT(XD_OUT),
        .RF_DY_OUT(YD_OUT) );
        
    comp #(8) MY_COMP4A (
        .a (XD_OUT),
        .b (YD_OUT),
        .gt (gt) );
        
    fsm_template fsm (
        .co(co),
        .gt(gt),
        .done(done),
        .btn(btn),
        .up(up),
        .we(we),
        .clr(clr),
        .ws(ws),
        .ds(ds),
        .clk(sclk),
        .t(t) );
        
    univ_sseg sseg (
        .cnt1(disp_DATA),
        .valid(1),
        .mod_sel(2'b10),
        .clk(clk),
        .ssegs(seg),
        .disp_en(an) );
        
    cntr_udclr_nb #(5) counter (
        .clk(sclk),
        .clr(clr),
        .up(up),
        .count(count),
        .rco() );
    
    assign co = Y_ADDR[4] | count[4];

    always @ (*)
    begin
        if (ws == 2'b00)
            D_IN = ROM_DATA;
        else if (ws == 2'b01)
            D_IN = X_REG;
        else if (ws == 2'b10)
            D_IN = YD_OUT;
        else
            D_IN = X_REG;
     end
     
     always @ (posedge sclk)
     begin
        if (ds == 1)
            disp_DATA = XD_OUT;
        else
            disp_DATA = ROM_DATA;
     end
        
    always @ (posedge sclk)
    begin
        if (sorted == 0)
        begin
            if (gt == 1)
                sorted = 1;
        end
        else if (clr == 1)
            sorted = 0;
    end
    
    assign done = ~sorted & co;
    
    rca_nb #(5) rca1 (
        .a(count),
        .b(0),
        .cin(1'b1),
        .sum(count1) );
    
    rca_nb #(5) rca2 (
        .a(count),
        .b(5'b11111),
        .cin(1'b0),
        .sum(count2) );
        
    always @ (*)
    begin
        if (t == 1)
        begin
            Y_ADDR = count;
            X_ADDR = count2;
        end
        else
        begin
            X_ADDR = count;
            Y_ADDR = count1;
        end
    end
    
    assign led[3:0] = X_ADDR;
    
    always @ (posedge sclk)
    begin
        X_REG = XD_OUT;
    end
        
endmodule
