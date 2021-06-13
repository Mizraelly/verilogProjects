module alu(i_op1, i_op2, i_control, i_sa, o_result, o_zf);

localparam AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010;
localparam SUB = 4'b0110, SOLT = 4'b0111, NOR = 4'b1100; //SOLT - Set On Less then
localparam SLL = 4'b1000,  SRL = 4'b1111; 

input       [31:0]  i_op1, i_op2;
input       [3:0]   i_control;
input 		[4:0] 	i_sa;
output reg  [31:0]  o_result;
output 	            o_zf;
reg [31:0] temp;
assign o_zf = ~|o_result;

always @(*) begin
	case(i_control) 
		AND: 	o_result = i_op1 & i_op2;
		OR:		o_result = i_op1 | i_op2;
		ADD:	o_result = i_op1 + i_op2;
		SUB:	o_result = i_op1 - i_op2;
		NOR:	o_result = ~(i_op1 | i_op2);
		SRL:	o_result = i_op2 >> i_sa;
		SOLT : begin
			if (i_op1[31] ^ i_op2[31]) o_result = i_op1[31];
			else begin
				temp = i_op1 - i_op2;
				o_result = temp[31];
			end
		end
		SLL:	o_result = i_op2 << i_sa;
	endcase
end

endmodule