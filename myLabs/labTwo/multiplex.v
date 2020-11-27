module multiplex(input [7:0]x, input[2:0]a, input en, output f);
assign f = ~en ? (~a[2]&~a[1]&~a[0]&x[0] | ~a[2]&~a[1]&a[0]&x[1] | ~a[2]&a[1]&~a[0]&x[2] | ~a[2]&a[1]&a[0]&x[3] | a[2]&~a[1]&~a[0]&x[4] | a[2]&~a[1]&a[0]&x[5] | a[2]&a[1]&~a[0]&x[6] | a[2]&a[1]&a[0]&x[7]) : 1'bz;
endmodule 