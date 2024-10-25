module Datapath(clk,rst,PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite,ALUSrcA,ALUSrcB,ResultSrc,ALUControl,ImmSrc
    ,zero , sign , opcode , func3 , func7 );
    input clk,rst,PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite;
    input [1:0] ALUSrcA,ALUSrcB,ResultSrc;
    input [2:0] ALUControl;
	input [2:0] ImmSrc;

    output zero,sign;
    output reg[2:0] func3;
    output reg[6:0] opcode,func7;

    wire[31:0] Result , PC , Adr,BData ,WriteData, ReadData,Data,OldPC,Instr, WD3, out_A,out_B,A,SrcA,SrcB,ImmExt,ALUResult,ALUOut;
    
    regPC PC_m(Result, clk ,rst, PCWrite ,PC );
    mux2to1 mux_pc(AdrSrc,PC,Result,Adr);
    inst_data_memory instdata( Adr, WriteData,MemWrite , clk , ReadData);
    IRReg ir_reg( PC , ReadData ,clk , IRWrite ,OldPC , Instr);
    registerfile regfile(Instr[19:15]  , Instr[24:20],Instr[11:7], Result, RegWrite , clk , out_A , out_B);
    register MDR(ReadData,clk,Data);
    ImmExt imm(Instr[31:7] , ImmSrc , ImmExt );
    register reg_A(out_A,clk,A);
	register reg_B(out_B,clk,WriteData);
    mux3To1 Mux_A(ALUSrcA,PC,OldPC,A,SrcA);
    mux3To1 Mux_B(ALUSrcB,WriteData,ImmExt,32'b00000000000000000000000000000100,SrcB);
    ALU alu(ALUControl,SrcA, SrcB,zero , sign , ALUResult);
    register ALU_Reg(ALUResult,clk,ALUOut);
    mux4to1 Result_mux(ResultSrc,ALUOut, Data , ALUResult, ImmExt,Result);

    assign opcode = Instr[6:0];
	assign func7 = Instr[31:25];
	assign func3 = Instr[14:12];

endmodule
    