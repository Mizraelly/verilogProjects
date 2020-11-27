`timescale 1ns/1ps
module micro_mac(i_clk,i_x1,i_x2,i_x3,o_out);
input i_clk,i_x1,i_x2,i_x3;
output reg o_out;


reg [3:0] state;

initial begin 
state = 0;
forever #500 state = $urandom_range(0,8); //use random which needed to tb
end

parameter	Y0 = 0, Y1 = 1, Y2 = 2, Y3 = 3, Y4 = 4, Y5 = 5, Y6 = 6, Y7 = 7, Y8 = 8, Yk = 9;
//			out = 0	out = 0	out = 1	out = 1	out = 1	out = 0	out = 1	out = 1	out = 0	out = 0				
always @(posedge i_clk) begin
case (state)
	Y0:	state = Y1;
	Y1:	state = Y2;

	Y2:	if(i_x2)		state = Y3;
		else if(i_x1)	state = Y6;
		else 			state = Y5;

	Y3:	state = Y4;

	Y4:	if(~i_x3) 		state = Y2;
		else 			state = Y8;

	Y5:	if(~i_x3) 		state = Y2;
		else 			state = Y8;	

	Y6: 				state = Y7;

	Y7:	if(~i_x3) 		state = Y2;
		else 			state = Y8;

	Y8:					state = Yk;
	Yk: 				state = state;
	default: 			state = Y1;					

endcase
end

always @(posedge i_clk) begin
case (state)
	Y0:	o_out = 1'b0;
	Y1:	o_out = 1'b0;
	Y2:	o_out = 1'b1;
	Y3:	o_out = 1'b1;
	Y4:	o_out = 1'b1;
	Y5:	o_out = 1'b0;
	Y6:	o_out = 1'b1;
	Y7:	o_out = 1'b1;
	Y8:	o_out = 1'b0;
	Yk:	o_out = 1'b0;
	default: o_out = 1'b0;
endcase
end
endmodule