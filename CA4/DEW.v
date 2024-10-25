module DE( clk,sclr,RegWriteD,MemWriteD,ALUSrcD,JumpD,BranchD,JalrD, ResultSrcD, ALUControlD,func3D, Rs1D,
	Rs2D,RdD,PCD,ExtImmD,PCPlus4D,RD1D,RD2D,RegWriteE,MemWriteE,ALUSrcE,JumpE,BranchE,JalrE, ResultSrcE,
	ALUControlE,func3E, Rs1E,Rs2E,RdE, PCE,ExtImmE,PCPlus4E,RD1E,RD2E);
	input clk,sclr,RegWriteD,MemWriteD,ALUSrcD,JumpD,BranchD,JalrD;
	input[1:0] ResultSrcD;
	input [2:0] ALUControlD,func3D;
	input[4:0] Rs1D,Rs2D,RdD;
	input[31:0]  PCD,ExtImmD,PCPlus4D,RD1D,RD2D;
	output RegWriteE,MemWriteE,ALUSrcE,JumpE,BranchE,JalrE;
	output[1:0] ResultSrcE;
	output [2:0] ALUControlE,func3E;
	output[4:0] Rs1E,Rs2E,RdE;
	output[31:0]  PCE,ExtImmE,PCPlus4E,RD1E,RD2E;

	Register #(1) R1(clk,1'b1,sclr,RegWriteD,RegWriteE);
	Register #(1) R2(clk,1'b1,sclr,MemWriteD,MemWriteE);
	Register #(1) R3(clk,1'b1,sclr,JumpD,JumpE);
	Register #(1) R4(clk,1'b1,sclr,ALUSrcD,ALUSrcE);
	Register #(1) R5(clk,1'b1,sclr,BranchD,BranchE);
	Register #(1) R6(clk,1'b1,sclr,JalrD,JalrE);
	Register #(2) R7 (clk,1'b1,sclr,ResultSrcD,ResultSrcE);
	Register #(3) R8 (clk,1'b1,sclr,ALUControlD,ALUControlE);
	Register #(3) R9 (clk,1'b1,sclr,func3D,func3E);
	Register #(5) R10 (clk,1'b1,sclr,Rs1D,Rs1E);
	Register #(5) R11 (clk,1'b1,sclr,Rs2D,Rs2E);
	Register #(5) R12 (clk,1'b1,sclr,RdD,RdE);
	Register R13 (clk,1'b1,sclr,PCD,PCE);
	Register R14 (clk,1'b1,sclr,ExtImmD,ExtImmE);
	Register R15 (clk,1'b1,sclr,PCPlus4D,PCPlus4E);
	Register R16 (clk,1'b1,sclr,RD1D,RD1E);
	Register R17 (clk,1'b1,sclr,RD2D,RD2E);
endmodule


