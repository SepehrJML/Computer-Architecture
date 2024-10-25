`define Rtype 7'b0110011
`define LW 7'b0000011
`define Itype 7'b0010011
`define Stype 7'b0100011
`define JALR 7'b1100111
`define Jtype 7'b1101111
`define Btype 7'b1100011
`define Utype 7'b0110111

`define I_imm 3'b000
`define S_imm 3'b001
`define B_imm 3'b010
`define J_imm 3'b011
`define U_imm 3'b100

`define AND 4'b0000
`define OR 4'b0001
`define XOR 4'b0011
`define ADD 4'b0010
`define SUB 4'b0110
`define SLT 4'b0111
`define SLTU 4'b1000


module Controller(input zero, sign, input[6:0] opc, input[2:0] f3, input[6:0] f7,
	output reg [1:0] PCSrc, output reg[1:0] ResSrc, output reg MemW,  output reg [3:0] AluCu, output reg AluSrc,
	output reg[2:0] ImmSrc ,output reg RegW);
	reg branch;

	always @ (opc, f3, f7)begin
		case(opc)
			`Rtype: begin // ImmSrc is dont'care
				RegW <= 1; ImmSrc <= `I_imm; AluSrc <= 0; MemW <= 0; ResSrc <= 2'b00; PCSrc <= 2'b00;
				if (f7 == 7'b0000000 & f3 == 3'b110) AluCu = `OR;
				if (f7 == 7'b0000000 & f3 == 3'b111) AluCu = `AND;
				if (f7 == 7'b0000000 & f3 == 3'b000) AluCu = `ADD;
				if (f7 == 7'b0100000 & f3 == 3'b000) AluCu = `SUB;
				if (f7 == 7'b0000000 & f3 == 3'b010) AluCu = `SLT;
				if (f7 == 7'b0000000 & f3 == 3'b001) AluCu = `SLTU;
			end

			`LW: begin 
				RegW <= 1; ImmSrc <= `I_imm; AluSrc <= 1; MemW <= 0; ResSrc <= 2'b01; PCSrc <= 2'b00;
				if(f3 == 3'b010) AluCu = `ADD;
			end

			`JALR: begin
				RegW <= 1; ImmSrc <= `I_imm; AluSrc <= 1; MemW <= 0; ResSrc <= 2'b11; PCSrc <= 2'b01;
				if(f3 == 3'b000) AluCu = `ADD;
			end

			`Jtype: begin // AluSrc AluCu are don't care
				RegW <= 1; ImmSrc <= `J_imm; AluSrc <= 0; MemW <= 0; ResSrc <= 2'b11; PCSrc <= 2'b10; AluCu = `ADD;
			end

			`Itype: begin 
				RegW <= 1; ImmSrc <= `I_imm; AluSrc <= 1; MemW <= 0; ResSrc <= 2'b00; PCSrc <= 2'b00;
				if (f3 == 3'b000) AluCu = `ADD;
				if (f3 == 3'b100) AluCu = `XOR;
				if (f3 == 3'b110) AluCu = `OR;
				if (f3 == 3'b010) AluCu = `SLT;
				if (f3 == 3'b001) AluCu = `SLTU;
			end

			`Stype: begin // ResSrc is don't care
				RegW <= 0; ImmSrc <= `S_imm; AluSrc <= 1; MemW <= 1; ResSrc <= 2'b00; PCSrc <= 2'b00;
				if(f3 == 3'b010) AluCu = `ADD;
			end

			`Btype: begin // ResSrc is don't care
				RegW <= 0; ImmSrc <= `B_imm; AluSrc <= 0; MemW <= 0; ResSrc <= 2'b00;
				if(f3 == 3'b000) begin AluCu = `SUB; if (zero == 1) PCSrc = 2'b10; else PCSrc = 2'b00; end //beq
				if(f3 == 3'b001) begin AluCu = `SUB; if (zero == 1) PCSrc = 2'b00; else PCSrc = 2'b10; end //bne
				if(f3 == 3'b100) begin AluCu = `SUB; if (sign == 1) PCSrc = 2'b10; else PCSrc = 2'b00; end //blt
				if(f3 == 3'b101) begin AluCu = `SUB; if (sign == 0 | zero == 1) PCSrc = 2'b10; else PCSrc = 2'b00; end //bge
			end

			`Utype: begin // AluSrc AluCu are don't care
				RegW <= 1; ImmSrc <= `U_imm; AluSrc <= 1; MemW <= 0; ResSrc <= 2'b10; PCSrc <= 2'b00; AluCu = `ADD;
			end
		endcase
	end
endmodule