module FD(clk,sclr,en,InstrF,PCF,PCPlus4F,InstrD,PCD,PCPlus4D);
	input clk,sclr,en;
	input[31:0] InstrF,PCF,PCPlus4F;
	output[31:0] InstrD,PCD,PCPlus4D;

	Register R1(clk,en,sclr,InstrF,InstrD);
	Register R2(clk,en,sclr,PCF,PCD);
	Register R3(clk,en,sclr,PCPlus4F,PCPlus4D);
endmodule


