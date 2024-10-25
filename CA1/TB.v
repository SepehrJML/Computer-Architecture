`timescale 1ns/1ns
module TESTBENCH ();
	reg [9:0] a_in = 10'b1011010000,b_in= 10'b0010101000;
	reg start=0,sclr=0,clk=0;
	wire [9:0] q_out;
	wire dvz,ovf,busy,valid;
	divider DIVIDER (a_in, b_in ,start ,sclr ,clk,q_out, dvz,ovf,busy,valid);

	initial begin
		repeat(450)
		# 100 clk=~clk;
		# 100 $stop; 
		end
	
	initial begin
		# 50;
		# 200 start = 1;
		# 200 start = 0;
		# 10000 sclr=1;
		# 300 sclr=0;

		# 1000

		a_in = 10'b0000010000;
		b_in = 10'b0000000000;
		# 200 start = 1;
		# 200 start = 0;
		# 10000 sclr=1;
		# 300 sclr=0;

		# 1000

		a_in = 10'b1001010000;
		b_in = 10'b0000001000;
		# 200 start = 1;
		# 200 start = 0;
		# 10000 sclr=1;
		# 300 sclr=0;

		# 1000

		a_in = 10'b1001010000;
		b_in = 10'b0010001000;
		# 200 start = 1;
		# 200 start = 0;
		# 1000 sclr=1;
		# 300 sclr=0;

		# 1000

		a_in = 10'b0001010000;
		b_in = 10'b0110001000;
		# 200 start = 1;
		# 200 start = 0;
		# 10000 sclr=1;
		# 300 sclr=0;
		end
endmodule
