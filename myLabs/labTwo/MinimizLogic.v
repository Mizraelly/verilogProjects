module MinimizLogic(a, b, c, out);
input a, b, c;
output out;
assign out = (b&c)|(~c&a);
endmodule