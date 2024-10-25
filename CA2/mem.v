module data_memory ( A, WD,WE , clk , RD);
    input WE , clk; 
    input [31:0] A, WD;
    output [31:0] RD;
    reg [7:0] data_memory [0:$pow(2, 16)-1];
    reg [31:0] adr;
    
    assign adr = {A[31:2], 2'b00}; 
    initial $readmemb("data.mem", data_memory);
    assign RD = {data_memory[adr ], data_memory[adr + 1], data_memory[adr + 2], data_memory[adr+ 3]};
    always @(posedge clk) begin
        if (WE)
            {data_memory[adr ], data_memory[adr + 1], data_memory[adr + 2], data_memory[adr + 3]} <= WD;
    end

endmodule