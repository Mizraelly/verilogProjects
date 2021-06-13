module aluControl(i_aluOp, i_func, o_aluControl);
 
input       [1:0]   i_aluOp;
input       [5:0]   i_func;
output  reg [3:0]   o_aluControl;

localparam AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010 , SLL = 4'b1000;
localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100, SRL = 4'b1111;


always@(*)begin
	case (i_aluOp)
		2'b00: o_aluControl = ADD; //lw,sw
		2'b01: o_aluControl = SUB; //beq
		default: begin 
			case(i_func)
			6'h20: o_aluControl = ADD;
			6'h22: o_aluControl = SUB;
			6'h24: o_aluControl = AND;
			6'h25: o_aluControl = OR;
			6'h27: o_aluControl = NOR;
			6'h2A: o_aluControl = SOLT;
			6'h00: o_aluControl = SLL;
			6'h02: o_aluControl = SRL;
		endcase // i_func
		end
	endcase // i_aluOp
end
endmodule