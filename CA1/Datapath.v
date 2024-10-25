`timescale 1ns/1ns

module datapath(inA,inB,clk,sclr,cnten,shift_value,initcnt,ldB,ldA,ldACC,ldQ,clrACC,clrQ,shACC,shQ,sel,Q_next,conter_out,co,sign,Bzero);  
    input[9:0] inA,inB;
    input clk,sclr,cnten,shift_value,initcnt,ldB,ldA,ldACC,ldQ,clrACC,clrQ,shACC,shQ,sel;
    output [9:0] Q_next; 
    output [3:0] conter_out;
    output sign,Bzero,co;
    wire [9:0] Q_next;
    wire [9:0] outA,outB,Q;
    wire [10:0] ACC,ACC_next,SUB_out;
    
    shift_register #(.N(10)) regA(clk,sclr,0,ldA,clrA,0,inA,outA);
    shift_register #(.N(10)) regB(clk,sclr,0,ldB,clrB,0,inB,outB);
    shift_register #(.N(10)) regQ(clk,sclr,shQ,ldQ,clrQ,shift_value,Q,Q_next);
    shift_register #(.N(11)) regACC(clk,sclr,shACC,ldACC,clrACC,Q_next[9],ACC,ACC_next);
    mux2to1  #(.Nm(11)) MUXACC (sel,{10'b0,outA[9]},SUB_out,ACC);
    mux2to1  #(.Nm(10)) MUXQ (sel,{outA[8:0],1'b0},Q_next,Q);
    sub SUB (ACC_next,{1'b0,outB},SUB_out,sign);

    assign Bzero = ~(|inB);
endmodule
