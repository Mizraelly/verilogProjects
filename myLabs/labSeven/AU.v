module AU(a1,a2,b1,b2,itask,out1,out2);
input [15:0] a1,a2,b1,b2;
input [1:0] itask;
output reg [31:0] out1,out2;

parameter [1:0] SUM = 0, SUB = 1, MUL = 2, DIV = 3;

always @(a1,a2,b1,b2,itask)begin
	case(itask)
		SUM: begin 	out1 = a1 + b1;
					out2 = a2 + b2;
			end
		SUB: begin 	out1 = a1 - b1;
					out2 = a2 - b2;
			end
		MUL: begin 	out1 = a1 * b1;
					out2 = a2 * b2;		
			end
		DIV: begin 	out1 = a1 / b1;
					out2 = a2 / b2;
			end
	endcase
end
endmodule