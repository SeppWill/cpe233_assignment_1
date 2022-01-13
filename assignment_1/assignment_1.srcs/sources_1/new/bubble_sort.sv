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
    
    wire sclk, clr, up, co, we, ds, gt, done;
    wire [1:0] ws;
    wire [2:0] PS;
    wire [3:0] count, ROM_ADDR;
    wire [4:0] X_ADDR, Y_ADDR;
    wire [7:0] ROM_DATA, XD_OUT, YD_OUT;
    reg [7:0] D_IN, disp_DATA, X_REG;
    reg sorted;
    
    /*clk_div CLOCK (
        .clk(clk),
        .sclk(sclk) );*/
        
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
        .PS(PS) );
        
    SevSegDisp sseg(
        .CLK(clk),
        .MODE(1'b0),
        .DATA_IN(disp_DATA),
        .CATHODES(seg),
        .ANODES(an) );
        
    cntr_udclr_nb #(4) counter (
        .clk(sclk),
        .clr(clr),
        .up(up),
        .count(count),
        .rco(co) );
        
    
    always @ (*)
    begin
        if (ws == 2'b00)
            D_IN = ROM_DATA;
        else if (ws == 2'b10)
            D_IN = YD_OUT;
        else if (ws == 2'b01)
            D_IN = XD_OUT;
        else
            D_IN = X_REG;
     end
     
     always @ (posedge sclk)
     begin
        if (ds == 0)
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
    
    /*assign X_ADDR = count;
    
    rca_nb #(5) rca (
        .a(X_ADDR),
        .b(0),
        .cin(1'b1),
        .sum(Y_ADDR) );*/
        
    assign Y_ADDR = count;
    
    rca_nb #(4) rca (
        .a(count),
        .b(4'b1111),
        .cin(1'b0),
        .sum(X_ADDR[3:0]) );
    
    assign led[7:5] = PS;
    assign led[3:0] = X_ADDR;
    assign led[15:8] = XD_OUT;
    assign X_ADDR[4] = 0;
    
    always @ (posedge sclk)
    begin
        X_REG = XD_OUT;
    end
        
endmodule
