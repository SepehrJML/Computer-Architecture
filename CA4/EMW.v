
module EM(clk,RegWriteE,MemWriteE, ResultSrcE, RdE, ALUResultE,WriteDataE,ExtImmE,
	PCPlus4E, RegWriteM,MemWriteM, ResultSrcM,RdM, ALUResultM,WriteDataM,ExtImmM,
	PCPlus4M);
	input clk,RegWriteE,MemWriteE;
	input [1:0] ResultSrcE;
	input[4:0] RdE;
	input[31:0] ALUResultE,WriteDataE,ExtImmE,PCPlus4E;
	output RegWriteM,MemWriteM;
	output [1:0] ResultSrcM;
	output[4:0] RdM;
	output[31:0] ALUResultM,WriteDataM,ExtImmM,PCPlus4M;

	Register #(1) R1(clk,1'b1,1'b0,RegWriteE,RegWriteM);
	Register #(1) R2(clk,1'b1,1'b0,MemWriteE,MemWriteM);
	Register #(2) R3 (clk,1'b1,1'b0,ResultSrcE,ResultSrcM);
	Register #(5) R4 (clk,1'b1,1'b0,RdE,RdM);
	Register R5 (clk,1'b1,1'b0,ALUResultE,ALUResultM);
	Register R6 (clk,1'b1,1'b0,WriteDataE,WriteDataM);
	Register R7 (clk,1'b1,1'b0,ExtImmE,ExtImmM);
	Register R8 (clk,1'b1,1'b0,PCPlus4E,PCPlus4M);
endmodule
