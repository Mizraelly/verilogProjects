module stateMacSix(i_clk, i_reset, i_w, o_OUT1);
input i_clk, i_reset, i_w;
output reg o_OUT1;

reg [3:0] state;

parameter [3:0] stateA = 0, stateB = 1, stateC = 2, stateD = 3, stateE = 4, stateF = 5, stateG = 6, stateH = 7, stateI = 8;

always @(posedge i_clk , posedge i_reset) begin
	if (i_reset)
		 state = stateA;
		else
	 case (state) 
		stateA: if(~i_w) state = stateB;
		else state = stateF;
		//
		stateB:	if(~i_w) state = stateC;
		else state = stateF;
		stateC: if (~i_w) state = stateD;
		else state = stateF;
		stateD:if(~i_w) state = stateE;
		else state = stateF;
		stateE:if(i_w) state = stateF;
		else state = state;
		//
		stateF:if(i_w) state = stateG;
		else state = stateB;
		stateG:if(i_w) state = stateH;
		else state = stateB;
		stateH:if(i_w) state = stateI;
		else state = stateB;
		stateI:if(~i_w) state = stateB;
		default: state = stateA;
	endcase
	
end

always @(state) begin
	case(state)
	stateA: o_OUT1 = 0;
	stateB: o_OUT1 = 0;
	stateC: o_OUT1 = 0;
	stateD: o_OUT1 = 0;
	stateE: o_OUT1 = 1;
	stateF: o_OUT1 = 0;
	stateG: o_OUT1 = 0;
	stateH: o_OUT1 = 0;
	stateI: o_OUT1 = 1;
	default:o_OUT1 = 0;
	endcase
end
endmodule