module inst_mem(pc, inst);
    input [31:0] pc;
    output [31:0] inst;
    reg [7:0] instructions [0:$pow(2, 16)-1]; 
    wire [31:0] adr;

    assign adr = {pc[31:2], 2'b00}; 
    initial $readmemb("instructions.mem", instructions);
    assign inst = {instructions[adr], instructions[adr + 1], instructions[adr + 2], instructions[adr + 3]};

endmodule
