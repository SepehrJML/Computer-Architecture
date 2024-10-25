`define 	R_Type	7'b0110011
`define 	I_Type	7'b0010011
`define		Lw	7'b0000011
`define 	Jalr	7'b1100111
`define		S_Type	7'b0100011
`define		J_Type	7'b1101111
`define 	B_Type	7'b1100011
`define		U_Type	7'b0110111


`define IMM_I 3'b000
`define IMM_S 3'b001
`define IMM_B 3'b010
`define IMM_J 3'b011
`define IMM_U 3'b100


`define AND 3'b000
`define OR 3'b001
`define XOR 3'b010
`define ADD 3'b011
`define SUB 3'b100
`define SLT 3'b101
`define SLTU 3'b110


`define		Add	10'b0000_0000_00
`define 	Sub	10'b0100_0000_00
`define		And	10'b0000_0001_11
`define 	Or	10'b0000_0001_10
`define		Slt	10'b0000_0000_10
`define     Sltu 10'b0000_0000_01


`define		lw	3'b010
`define 	addi	3'b000
`define		xori	3'b100
`define 	ori	3'b110
`define		slti	3'b010
`define     sltiu   3'b001
`define		jalr	3'b000


`define		beq	3'b000
`define 	bne	3'b001
`define		blt	3'b100
`define 	bge	3'b101


`define 	IF	      5'b00000
`define 	ID	      5'b00001
`define 	EX_R	  5'b00010
`define 	MEM_RI	  5'b00011
`define 	EX_I	  5'b00100
`define 	EX_LW	  5'b00101
`define 	MEM_LW	  5'b00110
`define 	W_LW	  5'b00111
`define 	EX_SW	  5'b01000
`define 	MEM_SW	  5'b01001
`define 	EX_B	  5'b01010
`define 	EX_JALR	  5'b01011
`define 	MEM_JALR  5'b01100
`define 	W_JALR 5'b01101
`define 	EX_JAL	  5'b01110
`define 	MEM_JAL	  5'b01111
`define 	W_JAL  5'b10000
`define 	EX_U      5'b10001



module Controller(input clk,zero,branchLEG,input [6:0] op,func7,input[2:0] func3,
	output reg PCw,AdrSrc,Memw,IRw,Regw,output reg[1:0] ResSrc,AluSrcA,AluSrcB,output reg[2:0]AluOp,ImmSrc);

	reg[4:0] ps=5'b0,ns=5'b0;
	
	always@(posedge clk)begin
		ps<=ns;
	end
	
	always @ (ps, zero, branchLEG, op, func7, func3) begin 
		
        case(ps)
		
		    `IF: ns = `ID;
		
		    `ID: ns = (op == `R_Type) ? `EX_R :
		              (op == `I_Type) ? `EX_I :
			          (op == `Lw) ? `EX_LW :
                      (op == `S_Type)? `EX_SW :
                      (op == `B_Type)? `EX_B:
                      (op == `Jalr  )? `EX_JALR:
                      (op == `J_Type)? `EX_JAL:
                      (op == `U_Type)? `EX_U: 5'b00000;
		
		    `EX_R :	ns = `MEM_RI;
		
	    	`EX_I : ns=`MEM_RI;

	    	`MEM_RI : ns = `IF;
		
		    `EX_LW : ns = `MEM_LW;
		
    		`MEM_LW : ns = `W_LW;
		
	    	`W_LW : ns = `IF;
		
		    `EX_SW : ns = `MEM_SW;
		
    		`MEM_SW : ns = `IF;
		
	    	`EX_B: ns = `IF;
		
		    `EX_JALR: ns = `MEM_JALR;
		
    		`MEM_JALR:	ns = `W_JALR;
		
	    	`W_JALR:	ns = `IF;
		
		    `EX_JAL: ns = `MEM_JAL;
		
		    `MEM_JAL: ns = `W_JAL;
		
    		`W_JAL: ns = `IF;
		
	    	`EX_U: ns = `IF;

            default: ns = `IF;

		endcase		
	
    end

	always @ (ps, zero, branchLEG, op, func7, func3) begin
        
		{PCw, AdrSrc, Memw, IRw, Regw, ResSrc, AluSrcA, AluSrcB, ImmSrc, AluOp} = 17'b0000_0000_0000_0001_0;
		
        case(ps)
		
		    `IF: begin
				AluOp = `ADD;
				AdrSrc = 1'b0;
				IRw = 1'b1;
				AluSrcA = 2'b00;
				AluSrcB = 2'b10;
				ResSrc = 2'b10;
				PCw = 1'b1;
			end
		
		    `ID: begin
				AluOp = `ADD;
				AluSrcA = 2'b01; 
				AluSrcB = 2'b01;
				ImmSrc = `IMM_B;
			end
		
		    `EX_R: begin
            	AluSrcA = 2'b10; 
				AluSrcB = 2'b00;
				case ({func7,func3})
					`Add: AluOp = `ADD;
					`Sub: AluOp = `SUB;
					`And: AluOp = `AND;
					`Or : AluOp = `OR;
					`Slt: AluOp = `SLT;
					`Sltu: AluOp = `SLTU;
				endcase	
				end
	
    		`EX_I: begin
                AluSrcA = 2'b10; 
				AluSrcB = 2'b01; 
				ImmSrc = `IMM_I;
	    	  	case(func3)
		    		`addi: AluOp = `ADD;
			    	`xori: AluOp = `XOR;	
				    `ori : AluOp = `OR;
    				`slti: AluOp = `SLT;
					`sltiu: AluOp = `SLTU;
	    	    	endcase
		        end

			`EX_LW:  begin
				AluOp = `ADD;
				AluSrcA = 2'b10;
				AluSrcB = 2'b01;
				ImmSrc = `IMM_I;
			end

			`EX_SW:	begin
				AluOp = `ADD;
				AluSrcA = 2'b01;
				AluSrcB = 2'b01;
				ImmSrc = `IMM_S;
			end
		
			`EX_B: begin
				AluSrcA = 2'b10;
				AluSrcB = 2'b00;
				ResSrc = 2'b00;

			
				case (func3)
					`beq: begin
						AluOp = `SUB;
						PCw = (zero) ? 1 : 0;
					end
					`bne: begin
						AluOp= `SUB;
						PCw = (zero) ? 0 : 1;
					end
					`blt: begin
						AluOp = `SLT;
						PCw = (branchLEG) ? 1 : 0;
					end
					`bge:begin
						AluOp = `SLT;
						PCw = (branchLEG) ? 0 : 1;
					end
				endcase
				end
	
			`EX_U: begin
				ResSrc = 2'b11;
				ImmSrc = `IMM_U;
				Regw = 1'b1;
			end

			`EX_JALR: begin
				AluOp = `ADD;
				AluSrcA = 2'b01;
				AluSrcB = 2'b10;
			end
	
			`EX_JAL: begin
				AluOp = `ADD;
				AluSrcA = 2'b01;
				AluSrcB = 2'b10;
			end

		    `MEM_RI: begin
				ResSrc = 2'b00;
				Regw = 1'b1;
			end
		
			`MEM_LW: begin
				ResSrc = 2'b00;
				AdrSrc = 1'b1;
			end

			`MEM_SW: begin
				ResSrc = 2'b00;
				AdrSrc = 1'b1;
				Memw = 1'b1;
			end
	
			`MEM_JALR: begin
				ResSrc = 2'b00;
				Regw = 1'b1;
			end
	
			`MEM_JAL: begin
				ResSrc = 2'b00;
				Regw = 1'b1;
			end




			`W_LW: begin
				ResSrc = 2'b01;
				Regw = 1'b1;
			end
	
			`W_JALR: begin
				AluOp = `ADD;
				AluSrcA = 2'b10;
				AluSrcB = 2'b01;
				ResSrc = 2'b10;
				ImmSrc = `IMM_I;
				PCw = 1'b1;
			end
	
			`W_JAL: begin
				AluOp = `ADD;
				AluSrcA = 2'b01;
				AluSrcB = 2'b01;
				ImmSrc = `IMM_J;
				PCw = 1'b1;
				ResSrc = 2'b10;
			end
	
		endcase
	end

endmodule