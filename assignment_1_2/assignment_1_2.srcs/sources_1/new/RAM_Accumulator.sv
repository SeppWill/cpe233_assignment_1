`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2022 12:10:17 AM
// Design Name: 
// Module Name: RAM_Accumulator
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


module RAM_Accumulator(
    input btn, clk,
    output [7:0] seg,
    output [3:0] an
    );
    reg sclk;
    wire [3:0] count;
    wire [7:0] DATA;
    reg [12:0] SUM, DATA2, RCA_OUT;
    
    clk_div CLOCK (
        .clk(clk),
        .sclk(sclk) );
        
    //assign sclk = clk;
        
    Rom_16x8 RAM (
        .ADDR(count),
        .CLK(sclk),
        .DATA(DATA) );
        
    fsm_template fsm (
        .co(co),
        .btn(btn),
        .ld(ld),
        .cclr(cclr),
        .rclr(rclr),
        .clk(sclk) );
        
    univ_sseg sseg (
        .cnt1(SUM),
        .valid(1),
        .mod_sel(2'b10),
        .clk(clk),
        .ssegs(seg),
        .disp_en(an) );
        
    cntr_udclr_nb #(4) counter (
        .clk(sclk),
        .clr(cclr),
        .up(1),
        .count(count),
        .rco(co) );
        
    rca_nb #(13) rca (
        .a(SUM),
        .b(DATA2),
        .cin(0),
        .sum(RCA_OUT) );
    
    assign DATA2[7:0] = DATA;
    assign DATA2[12:8] = 0;
        
    always @ (posedge sclk)
    begin
        if (rclr)
            SUM = 0;
        else if (ld)
            SUM = RCA_OUT;
        else
            SUM = SUM;
    end
        
endmodule
