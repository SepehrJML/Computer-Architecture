`define I_imm 3'b000
`define S_imm 3'b001
`define B_imm 3'b010
`define J_imm 3'b011
`define U_imm 3'b100
module ImmExt( in ,  ImmSrc , out );
	input[31:7] in;
    input[2:0] ImmSrc;
    output reg[31:0] out;
    
    always @ (*)begin
		case(ImmSrc)
			`I_imm: begin out = {{20{in[31]}} , in[31:20]}; end
			`S_imm: begin out = {{20{in[31]}} , in[31:25] , in[11:7]}; end
			`B_imm: begin out = {{20{in[31]}} , in[31], in[7] , in[30:25] , in[11:8], 1'b0}; end
			`J_imm: begin out = {{12{in[31]}} , in[31],in[19:12] , in[20] , in[30:21] , 1'b0}; end
			`U_imm: begin out = {in[31:12] , {12{1'b0}} }; end
		endcase
	end
endmodule