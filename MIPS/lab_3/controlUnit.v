module controlUnit(i_op, 
	               o_regDst,
	               o_J, 
	               o_Beq,
	               o_ExtOp,
	               o_memToReg,
	               o_aluOp,
	               o_memWrite,
	               o_memRead,
	               o_aluSrc,
	               o_regWrite
	               );
  
input     	[5:0]    i_op;
output reg           o_regDst;
output reg           o_regWrite;
output reg			 o_ExtOp;
output reg           o_aluSrc;
output reg           o_Beq;
output reg           o_J; 
output reg           o_memRead;
output reg           o_memWrite;
output reg           o_memToReg;
output reg   [1:0]   o_aluOp;

reg [10:0] control;
parameter 		RTYPE    = 6'b000000,
				BEJ  	 = 6'b000100, //4
				J 		 = 6'b000010, //2
				SW 		 = 6'b101011, //43
				LW 	 	 = 6'b100011, //35
				ADDIU 	 = 6'b001001; //9

assign {o_regDst,o_regWrite,o_ExtOp,o_aluSrc,o_Beq,o_J,o_memRead,o_memWrite,o_memToReg,o_aluOp} = control;

always @(*) begin
	case (i_op)
		RTYPE: 	control <= 11'b11x00000011;
		BEJ: 	control <= 11'bx0x01000x01;
		J:		control <= 11'bx0xx0100x11;
		SW:		control <= 11'bx0110001x00;
		LW: 	control <= 11'b01110010100;
		ADDIU:	control <= 11'b01110000000;
	endcase
end
  
endmodule