module Instr (A,RD); 
    input[31:0] A;
    output[31:0] RD;

    reg [31:0] inst [0:$pow(2, 16)-1];
    initial $readmemh("Instructions.mem", inst);
    wire [31:0] adr;
    assign adr = {2'b00,A[31:2]};
    assign RD=inst[adr];
endmodule
