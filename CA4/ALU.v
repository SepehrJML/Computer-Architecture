`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR 3'b011
`define XOR 3'b100
`define SLT 3'b101
`define SLTU 3'b110

module ALU ( opc,srcA, srcB,w,zero);
	input[2:0] opc;
	input signed[31:0]srcA, srcB;
	output reg[31:0] w;
	output zero;
	always @(*) begin
        case (opc)
            `ADD:  w = srcA + srcB;
            `SUB:  w = srcA - srcB;
            `AND:  w = srcA & srcB;
            `OR:  w = srcA | srcB;
	    `XOR:  w = srcA ^ srcB;
            `SLT:  w = srcA < srcB ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            `SLTU:  w = {srcA} < {srcB} ? 32'b00000000000000000000000000000001 : 32'b00000000000000000000000000000000;
            default: w = {32{1'bz}};
        endcase
    	end

    	assign zero = ~|w;
endmodule
