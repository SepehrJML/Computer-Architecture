`timescale 1ns/1ns

module TB ();
    reg clk = 1'b0 , rst=1'b0;
    risc risc_v(clk , rst);
    always #5 clk = ~clk;
	initial begin
		#17 rst = 1'b1;
		#18 rst=1'b0;
		#50000 $stop;
	end
endmodule