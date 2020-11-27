module NotMinimizLogic(a, b, c, out);
input a, b, c;
output out;
assign out = (a&b)|(a&~b&~c)|(~a&b&c);
endmodule