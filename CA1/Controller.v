`timescale 1ns/1ns

`define idle 4'd0
`define load 4'd1
`define exception 4'd2
`define init 4'd3
`define check_sign 4'd4
`define subtract 4'd5
`define shift 4'd6
`define check_overflow 4'd7
`define overflow 4'd8
`define output_ready 4'd9
`define shift_sub 4'd10

module controller(start, clk, rst, Bzero, ldA, ldB, clrAcc, clrQ, ldAcc,initcnt,cnten,shift_value, ldQ, shAcc, shQ, busy, sel, sign, Cout, ovf, valid, cnt, Q, dvz);
    input start, clk, rst, sign, Bzero,Cout;
    input [9:0] Q;
    output ldA, ldB, clrAcc, clrQ, ldAcc,initcnt,cnten,shift_value, ldQ, shAcc, shQ, busy, sel, ovf, valid, dvz;
    reg ldA, ldB, clrAcc, clrQ, ldAcc,initcnt,cnten,shift_value, ldQ, shAcc, shQ, busy, sel, ovf, valid, dvz;
    output [3:0] cnt;
    

    reg [3:0] ps, ns;

    counter CountUp ({4'b0001},clk,rst,cnten,initcnt, cnt, Cout);

    always @(posedge clk) begin
        if (rst)
            ps <= `idle;
        else
            ps <= ns;
    end

    always @(ps, start) begin
        ns = `idle;
        case (ps)
            `idle: ns = (start) ? `load : `idle;
            `load: ns = (Bzero) ? `exception : `init;
            `exception: ns = `idle;
            `init: ns = `check_sign;
            `check_sign: ns = (sign) ? `shift : `subtract;
            `subtract: ns = `shift_sub;
	    `shift: ns = (Cout) ? `output_ready
                        : (cnt != 4'b1010) ? `check_sign
                        : `check_overflow;
	     `shift_sub: ns = (Cout) ? `output_ready
                        : (cnt != 4'b1010) ? `check_sign
                        : `check_overflow;
            `check_overflow: ns = (|{Q[9:4]}) ? `overflow : `check_sign;
            `overflow: ns = `idle;
            `output_ready: ns = `idle;
            default: ns = `idle;
        endcase
    end

    always @(ps) begin
        {ldA, ldB, clrAcc, clrQ, ldAcc, ldQ, shAcc, shQ, sel, ovf, valid,initcnt,cnten, valid, dvz,shift_value} = 16'b0;
        {busy} = 1'b0;
        case (ps)
	    `idle: busy = 1'b0;
            `load: {ldA, ldB, clrAcc, clrQ, busy,initcnt} = 6'b111111;
            `exception: {dvz, busy} = 2'b10;
            `init: {sel, ldAcc, ldQ, busy} = 4'b0111;
            `check_sign: {busy,cnten} = 2'b11;
            `subtract: {sel, ldAcc, busy} = 3'b111;
            `shift: {shAcc, shQ, busy,shift_value} = 4'b1110;
	    `shift_sub: {shAcc, shQ, busy,shift_value} = 4'b1111;
            `check_overflow: busy = 1'b1;
	    `overflow: {ovf, busy} = 2'b10;
            `output_ready: {valid, busy} = 2'b10;
        endcase
    end
endmodule

