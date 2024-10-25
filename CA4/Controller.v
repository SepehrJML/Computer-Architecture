`define 	R_Type	7'b0110011
`define 	I_Type	7'b0010011
`define		LW	7'b0000011
`define 	Jalr	7'b1100111
`define		S_Type	7'b0100011
`define		J_Type	7'b1101111
`define 	B_Type	7'b1100011
`define		U_Type	7'b0110111


`define		Add	10'b0000_0000_00
`define 	Sub	10'b0100_0000_00
`define		And	10'b0000_0001_11
`define 	Or	10'b0000_0001_10
`define		Slt	10'b0000_0000_10
`define		Sltu	10'b0000_0000_01

`define		lw	3'b010
`define 	addi	3'b000
`define		xori	3'b100
`define 	ori	3'b110
`define		slti	3'b010
`define		sltiu	3'b001
`define		jalr	3'b000


`define		beq	3'b000
`define 	bne	3'b001
`define		blt	3'b100
`define 	bge	3'b101

`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR 3'b011
`define XOR 3'b100
`define SLT 3'b101
`define SLTU 3'b110


module Controller( func3, func7,op, MemWrite,ALUSrc,RegWrite,Jump,Branch,Jalr, ResultSrc,ALUControl,ImmSrc);
	
	input[2:0] func3;
	input[6:0] func7,op;
	output reg MemWrite,ALUSrc,RegWrite,Jump,Branch,Jalr;
	output reg [1:0] ResultSrc;
	output reg [2:0] ALUControl,ImmSrc;

	wire[9:0] func;
	assign func={func7,func3};
	always@(func3,func7,op) begin
		{MemWrite,ALUSrc,RegWrite,Jump,Branch,Jalr,ResultSrc,ALUControl,ImmSrc}=14'b0000_0000_0000_00;
		case(op)
			`R_Type:
				begin
				RegWrite=1'b1;
				case(func)
					`Add:ALUControl=`ADD;
					`Sub:ALUControl=`SUB;
					`And:ALUControl=`AND;
					`Or :ALUControl=`OR;
					`Slt:ALUControl=`SLT;
					`Sltu:ALUControl=`SLTU;
				endcase
				end
			`LW:	
				{RegWrite,ResultSrc,ALUSrc}=4'b1011;
			`I_Type:
				begin
				{ALUSrc,RegWrite}=2'b11;
				case(func3)					
					`addi:ALUControl=`ADD;
					`xori:ALUControl=`XOR;
					`ori :ALUControl=`OR;
					`slti:ALUControl=`SLT;
					`sltiu:ALUControl=`SLTU;
				endcase
				end
			`Jalr:	
				{Jalr,ALUSrc,ResultSrc,RegWrite}=5'b11101;
			`S_Type:	
				{ImmSrc,ALUSrc,MemWrite}=5'b00111;
			`J_Type:	
				{ResultSrc,ImmSrc,RegWrite,Jump}=7'b1001011;
			`B_Type:
				begin 
				{Branch,ImmSrc}=4'b1011;
				case(func3)
					`beq:	ALUControl=`SUB;
					`bne:	ALUControl=`SUB;
					`blt:	ALUControl=`SLT;
					`bge:	ALUControl=`SLT;
				endcase
				end
			`U_Type:
				{ResultSrc,ImmSrc,RegWrite}=6'b111001;
		endcase
	end
endmodule
