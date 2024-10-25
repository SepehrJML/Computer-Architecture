module RISCV(clk ,rst);
    input clk,rst;

    wire MemWrite,RegWrite,ALUSrc,zero,sign;
	wire[1:0] PCSrc,ResultSrc;
	wire[2:0] func3,ImmSrc;
	wire[3:0] ALUControl;
	wire[6:0] func7,opcode;

    Datapath dp(clk,rst ,ALUSrc ,MemWrite ,RegWrite , PCSrc , ResultSrc , ALUControl ,ImmSrc ,zero , sign , opcode , func3 ,func7 );
	Controller control(zero , sign , opcode , func3 , func7 ,PCSrc , ResultSrc ,MemWrite ,  ALUControl , ALUSrc ,ImmSrc ,RegWrite);

endmodule