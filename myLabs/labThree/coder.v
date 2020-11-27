module coder (input [-5:4]x, output [3:0]Q);
assign Q[3] = x[-5] | x[-4] | x[-3] | x[-2] | x[-1];
assign Q[2] = x[-4] | x[-3] | x[-2] | x[-1] | x[4];
assign Q[1] = x[-5] | x[-2] | x[-1] | x[2] | x[3];
assign Q[0] = x[-5] | x[-3] | x[-1] | x[1] | x[3];
endmodule 