module mux4to1(sel, a0, a1, a2, a3, w);
    input [1:0] sel;
    input [31:0] a0, a1, a2, a3;
    output [31:0] w;

    assign w = (sel==2'b00) ? a0 : (sel==2'b01) ? a1 : (sel==2'b10) ? a2 : a3 ;

endmodule