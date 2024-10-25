`define		beq	3'b000
`define 	bne	3'b001
`define		blt	3'b100
`define 	bge	3'b101

module pc_selector(JalrE,JumpE,BranchE,ZeroE,ALUResult0, func3E,PCSrcE);
	input JalrE,JumpE,BranchE,ZeroE,ALUResult0;
	input[2:0] func3E;
	output[1:0] PCSrcE;

	assign PCSrcE=(JalrE) ? 2'b10:
		((JumpE)||
		(BranchE && func3E==`beq && ZeroE)||
		(BranchE && func3E==`bne && ~ZeroE)||
		(BranchE && func3E==`blt && ALUResult0)||
		(BranchE && func3E==`bge && ~ALUResult0))?2'b01:
		2'b00;
endmodule
