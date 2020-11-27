module stateMacThree(i_clk, i_rst_n, i_x, i_y,sta, o_z1, o_z2);
input i_clk, i_rst_n, i_x, i_y;
output reg [1:0] o_z2, o_z1;
output [2:0] sta;

reg [2:0] state;
assign sta = state;


parameter [2:0] stateA = 0, stateB = 1, stateC = 2, stateD = 3, stateE = 4, stateF = 5, stateG = 6, stateH = 7;

always @(posedge i_clk , negedge i_rst_n) begin
	if (~i_rst_n) state = stateA;
	case (state) 
		stateA: begin
		if (~i_x & ~i_y) state = stateA;
		else if (i_x) state = stateB;
		else if (~i_x & i_y) state = stateE;
		end
		stateB:	if(i_x) state = stateD;
		stateC: begin
		if (i_x) state = stateA;
		else if (~i_x & i_y) state = stateG;
		end
		stateD:if(i_x) state = stateC;
		stateE:if(i_x | i_y) state = stateF;
		stateF:if(i_x | i_y) state = stateB;
		stateG:if(i_x | i_y) state = stateH;
		stateH:if(i_x | i_y) state = stateD;
		default: state = stateA;
	endcase
end

always @(state) begin
	case(state)
	stateA: begin o_z1 = 2'b10 ; o_z2 = 2'b10; end
	stateB: begin o_z1 = 2'b10; o_z2 = 2'b10; end
	stateC: begin o_z1 = 2'b10; o_z2 = 2'b10; end
	stateD: begin o_z1 = 2'b00; o_z2 = 2'b00; end
	stateE: begin o_z1 = 2'b11; o_z2 = 2'b11; end
	stateF: begin o_z1 = 2'b10; o_z2 = 2'b10; end
	stateG: begin o_z1 = 2'b11; o_z2 = 2'b11; end
	stateH: begin o_z1 = 2'b11; o_z2 = 2'b11; end
	default: begin o_z2 = 2'b10; o_z1 = 2'b10; end
	endcase
end
endmodule