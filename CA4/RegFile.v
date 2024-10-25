module RegisterFile(clk,we, A1,A2,A3, WD3, RD1,RD2);
	
	input clk,we;
	input [4:0] A1,A2,A3;
	input[31:0] WD3;
	output[31:0] RD1,RD2;

	reg[31:0] regfile [0:31];
	
	assign RD1=regfile[A1];
	assign RD2=regfile[A2];
	
	initial begin
		regfile[0]=32'b0;
	end
	always@(negedge clk)begin 
		if(we==1&&A3!=32'b0)
			regfile[A3]<=WD3;
		else
			regfile[A3]<=regfile[A3];
	end
endmodule			
