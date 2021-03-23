module main(i_clk, i_rst_n_pc);
input i_clk, i_rst_n_pc;

//Parameters...
parameter DATA_WIDTH_ADDER_PC = 30;

parameter DATA_WIDTH_INST_MEM = 32;
parameter ADDR_WIDTH_INST_MEM = 8;

parameter WIDTH_OPPERAND = 5;
parameter DATA_WIDTH_DATA_MEM = 32;
parameter ADDR_WIDTH_DATA_MEM = 5;

parameter WIDTH_IMM_BEFORE_EXTEND = 16;
parameter WIDTH_IMM_AFTER_EXTEND = 32;

parameter WIDTH_IMM_I = 26;
parameter WIDTH_IMM_O = 30;
////////////////////////////////////////////////////////////////////////

//def MUX_NextPC_to_PC param.........................
wire [DATA_WIDTH_ADDER_PC-1:0] o_MUX_NextPC_to_PC;
////////////////////////////////////////////////////////////////////////

//def PC param.........................
//wire i_rst_n_pc;
wire [DATA_WIDTH_INST_MEM-1:0] out_pc;
////////////////////////////////////////////////////////////////////////

//def ADDER_PC param.........................
wire [(DATA_WIDTH_ADDER_PC-1):0] o_result_adderPC;
////////////////////////////////////////////////////////////////////////

//def InstMem param.........................
wire [(DATA_WIDTH_INST_MEM-1):0] o_data_inst_memory;
////////////////////////////////////////////////////////////////////////

//def MUX_InstMem_to_RegFile param.........................
wire [WIDTH_OPPERAND-1:0] o_MUX_InstMem_to_regFile;
////////////////////////////////////////////////////////////////////////

//def RegFile param.........................
wire [DATA_WIDTH_DATA_MEM-1:0] o_rdata1_regFile,o_rdata2_regFile;
////////////////////////////////////////////////////////////////////////

//def Extender param.........................
wire [DATA_WIDTH_DATA_MEM-1:0] out_extOP;
////////////////////////////////////////////////////////////////////////

//def MUX_RegFile_to_ALU param.........................
wire [DATA_WIDTH_DATA_MEM-1:0] o_MUX_RegFile_to_ALU;
////////////////////////////////////////////////////////////////////////

//def ALU param.........................
wire [DATA_WIDTH_DATA_MEM-1:0] o_result_alu;
wire o_zf_alu;
////////////////////////////////////////////////////////////////////////

//def DataMem param.........................
wire [(DATA_WIDTH_DATA_MEM-1):0] o_data_mem;
////////////////////////////////////////////////////////////////////////

//def MUX_DataMem_to_RegFile param.........................
wire [(DATA_WIDTH_DATA_MEM-1):0] o_MUX_DataMem_to_RegFile;
////////////////////////////////////////////////////////////////////////

//def ControlUnit param.........................
wire regDst,j,Beq,ExtOp,memToReg,memWrite,memRead,aluSrc,regWrite;
wire [1:0] aluOp;
////////////////////////////////////////////////////////////////////////

//def AluControl param.........................
wire [3:0] o_aluControl_aluControl;
////////////////////////////////////////////////////////////////////////

//def NextPC param.........................
wire [WIDTH_IMM_O-1:0] o_addr_nextPC;
wire o_PCSrc_nextPC;
////////////////////////////////////////////////////////////////////////


//init MUX_NextPC_to_PC.................................................
mux2in1 #(.WIDTH(WIDTH_IMM_O))	MUX_NextPC_to_PC (		.i_dat0(o_result_adderPC),
														.i_dat1(o_addr_nextPC),
														.i_control(o_PCSrc_nextPC),
														.o_dat(o_MUX_NextPC_to_PC)
														);
////////////////////////////////////////////////////////////////////////


//init PC...............................................................
pc pc ( .i_clk(i_clk),
		.i_rst_n(i_rst_n_pc),
		.i_pc({o_MUX_NextPC_to_PC,2'b00}),
		.o_pc(out_pc)
		);
////////////////////////////////////////////////////////////////////////


//init ADDER_PC............................................................
adder #(.DATA_WIDTH(DATA_WIDTH_ADDER_PC)) adderPC(	.i_op1(30'b1),
													.i_op2(out_pc[31:2]),
													.o_result(o_result_adderPC)
													);
/////////////////////////////////////////////////////////////////////////


//init inst_memory......................................................
inst_memory #(.ADDR_WIDTH(ADDR_WIDTH_INST_MEM),.DATA_WIDTH(DATA_WIDTH_INST_MEM)) inst_memory(	.i_addr(out_pc[9:2]),
																								.o_data(o_data_inst_memory)
																								);
////////////////////////////////////////////////////////////////////////


//MUX_InstMem_to_RegFile................................................
mux2in1 #(.WIDTH(WIDTH_OPPERAND))	MUX_InstMem_to_RegFile (	.i_dat0(o_data_inst_memory[20:16]), // Rt OPP
																.i_dat1(o_data_inst_memory[15:11]), // Rd OPP
																.i_control(regDst),
																.o_dat(o_MUX_InstMem_to_regFile)
																);
////////////////////////////////////////////////////////////////////////


//init regFile......................................................
regFile regFile(.i_clk(i_clk), 
               	.i_raddr1(o_data_inst_memory[25:21]), //Rs OPP
                .i_raddr2(o_data_inst_memory[20:16]), //Rt OPP
               	.i_waddr(o_MUX_InstMem_to_regFile), 
               	.i_wdata(o_MUX_DataMem_to_RegFile), 
               	.i_we(regWrite),
               	.o_rdata1(o_rdata1_regFile),
               	.o_rdata2(o_rdata2_regFile) 
               );
////////////////////////////////////////////////////////////////////////


//init Extender.........................................................
signExtend #(.WISIGNEXTEND(WIDTH_IMM_BEFORE_EXTEND),.WOSIGNEXTEND(WIDTH_IMM_AFTER_EXTEND )) signExtend( .i_data(o_data_inst_memory[15:0]),
																										.i_en(ExtOp),
																										.o_data(out_extOP)
																										);
////////////////////////////////////////////////////////////////////////


//init MUX_RegFile_to_ALU...............................................
mux2in1 #(.WIDTH(DATA_WIDTH_DATA_MEM))	MUX_RegFile_to_ALU 	(	.i_dat0(o_rdata2_regFile), 
																.i_dat1(out_extOP), 
																.i_control(aluSrc),
																.o_dat(o_MUX_RegFile_to_ALU)
																);
////////////////////////////////////////////////////////////////////////


//init alu..............................................................
alu alu(	.i_op1(o_rdata1_regFile), 
			.i_op2(o_MUX_RegFile_to_ALU), 
			.i_control(o_aluControl_aluControl), 
			.o_result(o_result_alu), 
			.o_zf(o_zf_alu)
			);
////////////////////////////////////////////////////////////////////////

//init data_memory......................................................
data_memory #(.DATA_WIDTH(DATA_WIDTH_DATA_MEM),.ADDR_WIDTH(ADDR_WIDTH_DATA_MEM)) data_memory(	.i_clk(i_clk),
																								.i_addr(o_result_alu[4:0]),
																								.i_data(o_rdata2_regFile),
																								.i_we(memWrite), 
																								.o_data(o_data_mem)
																								);
////////////////////////////////////////////////////////////////////////


//init MUX_DataMem_to_RegFile...........................................
mux2in1 #(.WIDTH(DATA_WIDTH_DATA_MEM))	MUX_DataMem_to_RegFile 	(	.i_dat0(o_result_alu), 
																	.i_dat1(o_data_mem), 
																	.i_control(memToReg),
																	.o_dat(o_MUX_DataMem_to_RegFile)
																	);
////////////////////////////////////////////////////////////////////////


//init contolUnit.......................................................
controlUnit controlUnit (  .i_op(o_data_inst_memory[31:26]), 
			               .o_regDst(regDst),
			               .o_J(j), 
			               .o_Beq(Beq),
			               .o_ExtOp(ExtOp),
			               .o_memToReg(memToReg),
			               .o_aluOp(aluOp),
			               .o_memWrite(memWrite),
			               .o_memRead(memRead),
			               .o_aluSrc(aluSrc),
			               .o_regWrite(regWrite)
			               );
////////////////////////////////////////////////////////////////////////


//init aluControl......................................................
aluControl aluControl(	.i_aluOp(aluOp), 
						.i_func(o_data_inst_memory[5:0]),
						.o_aluControl(o_aluControl_aluControl)
						);
////////////////////////////////////////////////////////////////////////


//init next PC................................................................
nextPC #(.WIDTHIMM_INPUT(WIDTH_IMM_I),.WIDTHIMM_OUT(WIDTH_IMM_O))	nextPC (	.i_incPC(o_result_adderPC),
																			.i_imm26(o_data_inst_memory[25:0]),
																			.i_zero(o_zf_alu),
																			.i_j(j),
																			.i_beq(Beq),
																			.o_PCSrc(o_PCSrc_nextPC),
																			.o_addr(o_addr_nextPC)
																			);
/////////////////////////////////////////////////////////////////////////

endmodule : main