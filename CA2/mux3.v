module mux3To1 (sel,a0, a1 , a2,out);
    input[1:0] sel;
    input[31:0] a0, a1 , a2;
    output[31:0] out;
    assign out = (sel==2'b01) ? a1 : (sel==2'b00)? a0 : a2;
endmodule
