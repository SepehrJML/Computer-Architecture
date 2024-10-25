module	TB();
	reg clk=0;
	
	RiscV	mod(clk);
	
	always #20 clk=~clk;
	
	initial begin 
	#10000 $stop;
	end
	
endmodule

