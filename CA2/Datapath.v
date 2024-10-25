module Datapath(clk,rst, ALUSrc, MemWrite ,RegWrite ,PCSrc ,  ResultSrc ,ALUControl ,  ImmSrc
    ,zero , sign , opcode , func3 , func7 );
    input clk,rst,RegWrite,MemWrite,ALUSrc;
    input [1:0] PCSrc,ResultSrc;
    input [3:0] ALUControl;
	input [2:0] ImmSrc;
    output zero,sign;
    output reg[2:0] func3;
    output reg[6:0] opcode,func7;

    wire [31:0] in_pc , out_pc , inst;
    wire[4:0] A1, A2 , A3 ;
	wire [24:0] imm;
    wire [31:0] RD1 , RD2 , Result;
    wire signed[31:0] SrcA , SrcB;
    wire[31:0] Imm_Ext;
    wire[31:0] ALUResult;
    wire [31:0] ReadData;
    wire[31:0]  PCPlus4 , PCTarget;
    
    assign opcode = inst[6:0];
	assign func3 = inst[14:12];
	assign func7 = inst[31:25];
	assign A1 = inst[19:15];
	assign A2 = inst[24:20];
	assign A3 = inst[11:7];
	assign imm = inst[31:7];
    assign SrcA = RD1;

    reg_pc PC(in_pc, clk, rst, out_pc);
	inst_mem INST(out_pc, inst);
    registerfile REG_FILE(A1 , A2,A3, Result, RegWrite , clk , RD1 , RD2);
    ImmExt ImmExtend( imm ,  ImmSrc , Imm_Ext );
    data_memory DATA_MEM( ALUResult, RD2,MemWrite , clk , ReadData);
    mux2to1 MUX2to1(ALUSrc, RD2, Imm_Ext, SrcB);
    ALU alu(ALUControl, SrcA, SrcB, zero, sign, ALUResult);
    adder PCT(out_pc, Imm_Ext, PCTarget);
    adder PC_plus_4(out_pc, 32'b00000000000000000000000000000100, PCPlus4);
    mux4to1 MUX4to1(ResultSrc, ALUResult, ReadData, Imm_Ext,PCPlus4, Result);
    mux3To1 MUX3to1(PCSrc,PCPlus4, ALUResult,PCTarget,in_pc);
endmodule
