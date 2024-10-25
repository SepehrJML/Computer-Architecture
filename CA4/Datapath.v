module	Datapath(clk,StallF,MemWriteD,ALUSrcD,RegWriteD,JumpD,BranchD,JalrD,StallD,FlushD,ResultSrcD,ALUControlD,ImmSrcD,FlushE,
		ForwardAE,ForwardBE,PCSrcE,BranchE,JumpE,JalrE,ZeroE,ALUResult0,RegWriteM,RegWriteW, ResultSrcE,ResultSrcM,
		ResultSrcW, func3D,func3E, Rs1D,Rs2D,Rs1E,Rs2E,RdE,RdM,RdW,func7,op);
	
	input clk,MemWriteD,ALUSrcD,RegWriteD,JumpD,BranchD,JalrD,StallF,StallD,FlushD,FlushE;
	input[1:0] ResultSrcD,ForwardAE,ForwardBE,PCSrcE;
	input [2:0] ALUControlD,ImmSrcD;
	output BranchE,JumpE,JalrE,ZeroE,ALUResult0,RegWriteM,RegWriteW;
	output[1:0] ResultSrcE,ResultSrcM,ResultSrcW;
	output[2:0] func3D,func3E;
	output[4:0] Rs1D,Rs2D,Rs1E,Rs2E,RdE,RdM,RdW;
	output[6:0] func7,op;
	
	wire MemWriteM,RegWriteE,MemWriteE,ALUSrcE;
	wire[2:0] ALUControlE;
	wire[4:0] RdD;
	wire[31:0] PCPlus4F,PCF_,PCF,InstrF,InstrD,RD1D,RD2D,ExtImmD,PCD,PCPlus4D,SrcAE,PCTargetE,ALUResultE,
		   RD1E,RD2E,WriteDataE,ExtImmE,PCPlus4E,SrcBE,PCE,WriteDataM,ReadDataM,ALUResultM,PCPlus4M,
		   ExtImmM,ALUResultW,ReadDataW,ResultW,PCPlus4W,ExtImmW;
	
	Register PC(clk,~StallF,1'b0,PCF_,PCF);
	Instr Instruction(PCF,InstrF);
	Adder PCAdd4(PCF,4,PCPlus4F);
	FD W0(clk,FlushD,~StallD,InstrF,PCF,PCPlus4F,InstrD,PCD,PCPlus4D);
	RegisterFile RegFile(clk,RegWriteW,InstrD[19:15],InstrD[24:20],RdW,ResultW,RD1D,RD2D);
	ImmExt Ext(InstrD[31:7],ImmSrcD,ExtImmD);
	DE W1(clk,FlushE,RegWriteD,MemWriteD,ALUSrcD,JumpD,BranchD,JalrD,ResultSrcD,ALUControlD,
		    func3D,Rs1D,Rs2D,RdD,PCD,ExtImmD,PCPlus4D,RD1D,RD2D,RegWriteE,MemWriteE,ALUSrcE,JumpE,BranchE,JalrE,
		    ResultSrcE,ALUControlE,func3E,Rs1E,Rs2E,RdE,PCE,ExtImmE,PCPlus4E,RD1E,RD2E);
	mux4to1 AMux(ForwardAE,RD1E,ResultW,ALUResultM,ExtImmM,SrcAE);
	mux4to1 BMux(ForwardBE,RD2E,ResultW,ALUResultM,ExtImmM,WriteDataE);
	mux2to1 BMux2 (ALUSrcE,WriteDataE,ExtImmE,SrcBE);
	Adder ImmAdd(PCE,ExtImmE,PCTargetE);
	ALU ALU(ALUControlE,SrcAE, SrcBE,ALUResultE,ZeroE);
	EM W2(clk,RegWriteE,MemWriteE,ResultSrcE,RdE,ALUResultE,WriteDataE,ExtImmE,
		    PCPlus4E,RegWriteM,MemWriteM,ResultSrcM,RdM,ALUResultM,WriteDataM,ExtImmM,PCPlus4M);
	DataMem DataMemory(clk ,MemWriteM,ALUResultM,WriteDataM,ReadDataM);
	MW W3(clk,RegWriteM,ResultSrcM,RdM,ALUResultM,ReadDataM,ExtImmM,PCPlus4M,
		    RegWriteW,ResultSrcW,RdW,ALUResultW,ReadDataW,ExtImmW,PCPlus4W);
	mux4to1 ResMux(ResultSrcW,ALUResultW,ReadDataW,PCPlus4W,ExtImmW,ResultW);
	mux3to1 PCSrcMux(PCSrcE,PCPlus4F,PCTargetE,ALUResultE,PCF_);
	assign ALUResult0 = ALUResultE[0];
	assign Rs1D = InstrD[19:15];
	assign Rs2D = InstrD[24:20];
	assign RdD = InstrD[11:7];
	assign func3D = InstrD[14:12];
	assign func7 = InstrD[31:25];
	assign op  = InstrD[6:0];


endmodule