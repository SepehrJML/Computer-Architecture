module RiscV(clk);
    input clk;
    wire MemWriteD, ALUSrcD, RegWriteD, JumpD, BranchD, JalrD, RegWriteM, RegWriteW, JalrE, JumpE, BranchE, ZeroE, ALUResult0, StallF, StallD, FlushD, FlushE;
    wire [1:0] ResultSrcD, ResultSrcE, PCSrcE, ForwardAE, ForwardBE, ResultSrcM, ResultSrcW;
    wire [2:0] func3D, func3E, ALUControlD, ImmSrcD;
    wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
    wire [6:0] func7, op;

        Datapath D(
        .clk(clk),
        .StallF(StallF),
        .MemWriteD(MemWriteD),
        .ALUSrcD(ALUSrcD),
        .RegWriteD(RegWriteD),
        .JumpD(JumpD),
        .BranchD(BranchD),
        .JalrD(JalrD),
        .StallD(StallD),
        .FlushD(FlushD),
        .ResultSrcD(ResultSrcD),
        .ALUControlD(ALUControlD),
        .ImmSrcD(ImmSrcD),
        .FlushE(FlushE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .PCSrcE(PCSrcE),
        .BranchE(BranchE),
        .JumpE(JumpE),
        .JalrE(JalrE),
        .ZeroE(ZeroE),
        .ALUResult0(ALUResult0),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ResultSrcE(ResultSrcE),
        .ResultSrcM(ResultSrcM),
        .ResultSrcW(ResultSrcW),
        .func3D(func3D),
        .func3E(func3E),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .RdM(RdM),
        .RdW(RdW),
        .func7(func7),
        .op(op)
    );

    Controller C(
        .func3(func3D),
        .func7(func7),
        .op(op),
        .MemWrite(MemWriteD),
        .ALUSrc(ALUSrcD),
        .RegWrite(RegWriteD),
        .Jump(JumpD),
        .Branch(BranchD),
        .Jalr(JalrD),
        .ResultSrc(ResultSrcD),
        .ALUControl(ALUControlD),
        .ImmSrc(ImmSrcD)
    );

    hazard_unit H(
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ResultSrcE(ResultSrcE),
        .PCSrcE(PCSrcE),
        .ResultSrcM(ResultSrcM),
        .ResultSrcW(ResultSrcW),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .RdM(RdM),
        .RdW(RdW),
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

    pc_selector P(
        .JalrE(JalrE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ZeroE(ZeroE),
        .ALUResult0(ALUResult0),
        .func3E(func3E),
        .PCSrcE(PCSrcE)
    );


endmodule





