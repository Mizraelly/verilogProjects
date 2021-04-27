module controlUnit(i_op, 
	               o_regDst,
	               o_J, 
	               o_Beq,
	               o_Bne,
	               o_ExtOp,
	               o_memToReg,
	               o_aluOp,
	               o_memWrite,
	               o_memRead,
	               o_aluSrc,
	               o_regWrite
	               );
  
input     	[5:0]    i_op;
output           	 o_regDst;
output           	 o_regWrite;
output 			 	 o_ExtOp;
output            	 o_aluSrc;
output             	 o_Beq;
output 				 o_Bne;
output           	 o_J; 
output           	 o_memRead;
output           	 o_memWrite;
output           	 o_memToReg;
output    [1:0]  	 o_aluOp;

reg [11:0] control;
parameter 		RTYPE    = 6'b000000,
				BEJ  	 = 6'b000100, //4
				BNE      = 6'b000101, //5
				J 		 = 6'b000010, //2
				SW 		 = 6'b101011, //43
				LW 	 	 = 6'b100011, //35
				ADDIU 	 = 6'b001001; //9

assign {o_regDst,o_regWrite,o_ExtOp,o_aluSrc,o_Beq,o_Bne,o_J,o_memRead,o_memWrite,o_memToReg,o_aluOp} = control;

always @(*) begin
	case (i_op)
		RTYPE: 	control <= 12'b11x000000011;
		BEJ: 	control <= 12'bx01010000x01;
		BNE:	control <= 12'bx01001000x01;
		J:		control <= 12'bx0xx00100x11;
		SW:		control <= 12'bx01100001x00;
		LW: 	control <= 12'b011100010100;
		ADDIU:	control <= 12'b011100000000;
	endcase
end
  
endmodule