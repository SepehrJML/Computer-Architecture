module shift_register #(parameter N = 11) (clk,sclr,sh,ld,clr,q,reg_in,reg_out);
    input clk,sclr,sh,ld,clr,q;
    input [N-1:0] reg_in;
    output [N-1:0] reg_out;
    reg [N-1:0] reg_out;
    
    always @(posedge clk)
        if (clr | sclr)
            reg_out <= 0;
        else if (ld)
            reg_out <= reg_in;
        else if (sh)
            reg_out <= {reg_out[N-2:0],q};
endmodule

module mux2to1 #(parameter Nm = 11) (sel,in_zero,in_one,out);
    input sel;
    input[Nm-1:0] in_zero,in_one;
    output[Nm-1:0] out;

    assign out = ~sel ? in_zero : in_one;
endmodule

module sub(A,B, out,sign);
    input[10:0] A,B;
    output[10:0] out;
    output sign;

    assign sign = (A < B) ? 1'b1: 1'b0;
    assign out = A - B;
endmodule
module counter (Pin, clk,sclr,cnten,initcnt,Pout,  co);
	input[3:0] Pin;
	input clk,sclr,cnten,initcnt;
	output [3:0] Pout;
	output co;
	reg [3:0] Pout;
	always @ (posedge clk,posedge sclr) begin
		if (sclr)
			Pout <= 4'd0;
			else begin
				if (initcnt)
					Pout <= Pin;
						else if (cnten) Pout <= Pout + 1;
			end
	end
	assign co = &Pout;
endmodule
