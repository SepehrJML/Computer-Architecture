module regPC(PCnext, clk ,rst, PCWrite ,PC );
	input clk,rst , PCWrite;
    input [31:0] PCnext;
    output reg [31:0]PC=32'b0;
    always @(posedge clk,posedge rst) begin
        if(PCWrite)
            PC <= PCnext;
    end
endmodule
