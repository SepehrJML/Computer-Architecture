`define AND 3'b000
`define OR 3'b001
`define XOR 3'b010
`define ADD 3'b011
`define SUB 3'b100
`define SLT 3'b101
`define SLTU 3'b110
module ALU(opc, SrcA, SrcB, zero, neg, w);
    input [2:0] opc;
    input signed [31:0] SrcA, SrcB;
    output zero, neg;
    output reg signed [31:0] w;
    
    always @(SrcA ,SrcB, opc) begin
        case (opc)
            `AND   :  w = SrcA & SrcB;
            `OR    :  w = SrcA | SrcB;
            `XOR   :  w = SrcA ^ SrcB;
            `ADD   :  w = SrcA + SrcB;
            `SUB   :  w = SrcA - SrcB;
            `SLT   :  w = SrcA < SrcB ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            `SLTU  :  w = {SrcA} < {SrcB} ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            default:  w = {32{1'bz}};
        endcase
    end

    assign zero = (~|w);
    assign neg = w[31];
endmodule
