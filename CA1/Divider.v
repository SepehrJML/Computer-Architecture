`timescale 1ns/1ns
module divider (a_in, b_in , start ,sclr ,clk, q_out, dvz,ovf,busy,valid);
	input [9:0]a_in, b_in;
	input start ,sclr ,clk;
	output [9:0] q_out;
	wire [9:0] q_out;
	output dvz,ovf,busy,valid;

	wire cnten,initcnt,ldB,ldA,ldACC,ldQ,clrACC,clrQ,shACC,shQ,shift_value,sel,Cout,sign,Bzero;
	wire [3:0] cnt;
	datapath Dpath(a_in,b_in,clk,sclr,cnten,shift_value,initcnt,ldB,ldA,ldACC,ldQ,clrACC,clrQ,shACC,shQ,sel,q_out,cnt,Cout,sign,Bzero); 
	controller Control(start, clk, sclr, Bzero, ldA, ldB, clrACC, clrQ, ldACC,initcnt,cnten, shift_value,ldQ, shACC, shQ, busy, sel, sign, Cout, ovf, valid, cnt, q_out, dvz);
endmodule
