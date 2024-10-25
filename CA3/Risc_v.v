module risc(input clk,rst);
    wire PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite,zero , sign;
	wire[1:0] ResultSrc,ALUSrcA,ALUSrcB;
	wire[2:0] func3,ALUControl,ImmSrc;
	wire[6:0] func7,opcode;

    Controller ctrl(clk,zero,sign,opcode,func7,func3,
	PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite,ResultSrc,ALUSrcA,ALUSrcB,ALUControl,ImmSrc);
    Datapath dp(clk,rst,PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite,ALUSrcA,ALUSrcB,ResultSrc,ALUControl,ImmSrc
    ,zero , sign , opcode , func3 , func7 );
endmodule