module registerfile (A1 , A2,A3, WD3, WE3 , clk , RD1 , RD2);
    input WE3 , clk;
    input [4:0] A1 , A2,A3;
    input[31:0] WD3;
    output[31:0] RD1 , RD2;

    reg [31:0] regFile [0:31];
    always @(posedge clk ) begin
        if ( (WE3) & (A3 != 5'b00000) )
                regFile[A3] <= WD3;
    end
    assign RD1 = regFile[A1];
    assign RD2 = regFile[A2];
    assign regFile[0] = 32'b0;
endmodule
