module MW(clk,RegWriteM, ResultSrcM, RdM,ALUResultM,ReadDataM,ExtImmM,PCPlus4M,
	 RegWriteW, ResultSrcW, RdW,ALUResultW,ReadDataW,ExtImmW,PCPlus4W);
	input clk,RegWriteM;
	input[1:0] ResultSrcM;
	input[4:0] RdM;
	input[31:0] ALUResultM,ReadDataM,ExtImmM,PCPlus4M;
	output RegWriteW;
	output[1:0] ResultSrcW;
	output[4:0] RdW;
	output[31:0] ALUResultW,ReadDataW,ExtImmW,PCPlus4W;

	Register #(1) R1 (clk,1'b1,1'b0,RegWriteM,RegWriteW);
	Register #(2) R2 (clk,1'b1,1'b0,ResultSrcM,ResultSrcW);
	Register #(5) R3 (clk,1'b1,1'b0,RdM,RdW);
	Register R4 (clk,1'b1,1'b0,ALUResultM,ALUResultW);
	Register R5 (clk,1'b1,1'b0,ReadDataM,ReadDataW);
	Register R6 (clk,1'b1,1'b0,ExtImmM,ExtImmW);
	Register R7 (clk,1'b1,1'b0,PCPlus4M,PCPlus4W);
endmodule

