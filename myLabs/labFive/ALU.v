module ALU(i_a, i_b, i_control, o_out);
	input [7:0] i_a, i_b;
	input [1:0] i_control;
	output reg[16:0] o_out;

	wire [7:0] invb;
	assign invb = ~i_b;

	function [7:0] AxorB;
	input [7:0] a, b;
		begin
			AxorB = a ^ b;
		end
	endfunction 

	function [16:0] AmulBaddOther;
		input [7:0] a, b, invb;
		begin
			AmulBaddOther = a * b + a + invb; 
		end
	endfunction

	function [7:0] getA;
		input [7:0] a;
		begin
			getA = a; 
		end
	endfunction

	function [7:0] getB;
		input [7:0] b;
		begin
			getB = b; 
		end
	endfunction

always @(i_a, i_b, i_control) begin
		case(i_control)
			0: o_out = AxorB(i_a,i_b);
			1: o_out = AmulBaddOther(i_a,i_b,invb); 
			2: o_out = getA(i_a);
			3: o_out = getB(i_b);
		endcase
	end
	endmodule