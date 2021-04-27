module adder(i_op1, i_op2, o_result);
parameter DATA_WIDTH = 32;

input  [DATA_WIDTH-1:0] 	i_op1, i_op2;
output [DATA_WIDTH-1:0] 	o_result;

assign o_result = i_op1 + i_op2;
  
endmodule