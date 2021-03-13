module nextPC(	i_incPC,
				i_imm26,
				i_zero,
				i_j,
				i_beq,
				o_PCSrc,
				o_addr
				);

parameter WIDTHIMM_INPUT = 26;
parameter WIDTHIMM_OUT = 30;

input [WIDTHIMM_OUT-1:0] i_incPC;
input [WIDTHIMM_INPUT-1:0] i_imm26;
input i_zero, i_j, i_beq;

output  [WIDTHIMM_OUT-1:0] o_addr;
output  o_PCSrc;


wire [WIDTHIMM_OUT-1:0] imm26;
signExtend #(.WISIGNEXTEND(WIDTHIMM_INPUT),.WOSIGNEXTEND(WIDTHIMM_OUT)) signExtender_NextPC(	.i_data(i_imm26),
																								.i_en(i_imm26[25]),
																								.o_data(imm26)
																								);
wire [WIDTHIMM_OUT-1:0] outadder;
adder #(.DATA_WIDTH(WIDTHIMM_OUT)) adder_NextPC (	.i_op1(i_incPC),
													.i_op2(imm26),
													.o_result(outadder)	
													);

mux2in1 #(.WIDTH(WIDTHIMM_OUT))	mux2in1NextPC (	.i_dat0(outadder),
												.i_dat1({i_incPC[29:26],i_imm26}),
												.i_control(i_j),
												.o_dat(o_addr)
												);

assign o_PCSrc = (i_zero & i_beq) | i_j;

endmodule : nextPC