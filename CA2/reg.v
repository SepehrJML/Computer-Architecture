module reg_pc(in_pc, clk, rst, out_pc);
    input [31:0] in_pc;
    input clk, rst;
    output reg [31:0] out_pc;
    
    always @(posedge clk ,posedge rst) begin
        if(rst)
            out_pc <= 32'b0;
        else
            out_pc <= in_pc;
    end

endmodule
