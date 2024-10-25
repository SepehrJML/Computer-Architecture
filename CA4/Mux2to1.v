module mux2to1(sel, a, b, w);
    input sel;
    input [31:0] a, b;
    output [31:0] w;

    assign w = sel ? b : a;
endmodule
