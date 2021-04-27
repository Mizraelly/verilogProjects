module nextPC(	i_zero,
				i_j,
				i_beq,
				i_bne,
				o_PCSrc,
				o_Kill1,
				o_Kill2
				);

input i_zero, i_j, i_beq, i_bne;

output [1:0] o_PCSrc;
output o_Kill1, o_Kill2;

wire Br;
wire Jmp;

assign Br = ((i_beq & i_zero) |(i_bne & ~i_zero));
assign Jmp = i_j & (~Br);
assign o_Kill1 = i_j | Br;
assign o_Kill2 = Br;
assign o_PCSrc =({Br,Jmp});
endmodule : nextPC