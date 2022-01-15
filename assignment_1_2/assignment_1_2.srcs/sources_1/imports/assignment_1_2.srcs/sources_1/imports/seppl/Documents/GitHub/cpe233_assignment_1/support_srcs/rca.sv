`timescale 1ns / 1ps
/////////////////////////////////////////////////////
// Company: Ratner Engineering
// Engineer: James Ratner
//
// Create Date: 07/04/2018 02:13:56 PM
// Design Name:
// Module Name: rca_nb
// Project Name:
// Target Devices:
// Tool Versions:
// Description: n-bit RCA model
//
// Usage (instantiation) example for 16-bit RCA
// (model defaults to 8-bit RCA)
//
// rca_nb #(.n(16)) MY_RCA (
// .a (my_a),
// .b (my_b),
// .cin (my_cin),
// .sum (my_sum),
// .co (my_co)
// );
//
// Dependencies:
//
// Revision:
// Revision 1.00 - File Created: 07-04-2018
// Additional Comments:
//
///////////////////////////////////////////////////////
module rca_nb(a, b, cin, sum, co);
	input [n-1:0] a, b;
	input cin;
	output reg [n-1:0] sum;
	output reg co;
	//- default bit-width
	parameter n = 8;
	always @(a, b, cin)
	begin
		{co, sum} = a + b + cin;
	end
endmodule