module IRReg( PC , ReadData ,clk , IRWrite ,OldPC , Instr);
	input[31:0] PC , ReadData;
    input clk , IRWrite;
    output reg [31:0] OldPC , Instr;
	always @(posedge clk) begin
		if(IRWrite) begin
			Instr = ReadData;
			OldPC = PC;
		end
    end
endmodule