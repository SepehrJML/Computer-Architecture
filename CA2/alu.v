`define AND 4'b0000
`define OR 4'b0001
`define XOR 4'b0011
`define ADD 4'b0010
`define SUB 4'b0110
`define SLT 4'b0111
`define SLTU 4'b1000
module ALU(opc, SrcA, SrcB, zero, neg, w);
    input [3:0] opc;
    input signed [31:0] SrcA, SrcB;
    output zero, neg;
    output reg signed [31:0] w;
    
    always @(SrcA ,SrcB, opc) begin
        case (opc)
            `ADD   :  w = SrcA + SrcB;
            `SUB   :  w = SrcA - SrcB;
            `AND   :  w = SrcA & SrcB;
            `OR    :  w = SrcA | SrcB;
            `XOR   :  w = SrcA ^ SrcB;
            `SLT   :  w = SrcA < SrcB ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            `SLTU  :  w = {SrcA} < {SrcB} ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            default:  w = {32{1'bz}};
        endcase
    end

    assign zero = (~|w);
    assign neg = w[31];
endmodule
