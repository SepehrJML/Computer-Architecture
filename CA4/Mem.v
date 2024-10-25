module DataMem(clk , we,A,WD,ReadData);
	input clk , we;
	input[31:0] A,WD;
	output[31:0] ReadData;
	reg [31:0] mem [0:$pow(2, 16)-1];
	initial $readmemh("Data.mem", mem);
	wire [31:0] adr;
	
	assign adr = {2'b00,A[31:2]}; 
	assign ReadData=mem[adr];
	always@(posedge clk)begin 
		if(we)
			mem[adr]<=WD;
		else
			mem[adr]<=mem[adr];
	end
endmodule