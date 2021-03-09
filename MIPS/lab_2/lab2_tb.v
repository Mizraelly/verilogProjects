`timescale 1ns/1ps
module testbench;
parameter PERIOD = 20;

reg clk;
//init adder............................................................
parameter DATA_WIDTH_ADDER = 32;
reg [(DATA_WIDTH_ADDER-1):0] i_op1_adder, i_op2_adder;
wire [(DATA_WIDTH_ADDER-1):0] o_result_adder;

adder #(.DATA_WIDTH(DATA_WIDTH_ADDER)) adder(	.i_op1(i_op1_adder),
												.i_op2(i_op2_adder),
												.o_result(o_result_adder)
												);
/////////////////////////////////////////////////////////////////////////

//init data_memory......................................................
parameter DATA_WIDTH_DATA_MEM = 32;
parameter ADDR_WIDTH_DATA_MEM = 5;

reg i_we_data_mem;
reg [(ADDR_WIDTH_DATA_MEM-1):0] i_addr_data_mem;
wire [(DATA_WIDTH_DATA_MEM-1):0] i_data_mem;
wire [(DATA_WIDTH_DATA_MEM-1):0] o_data_mem;

data_memory #(.DATA_WIDTH(DATA_WIDTH_DATA_MEM),.ADDR_WIDTH(ADDR_WIDTH_DATA_MEM)) data_memory(	.i_clk(clk),
																								.i_addr(i_addr_data_mem),
																								.i_data(i_data_mem),
																								.i_we(i_we_data_mem), 
																								.o_data(o_data_mem)
																								);
////////////////////////////////////////////////////////////////////////

//init aluControl......................................................
wire [1:0] i_aluOp_aluControl;
wire [5:0] i_func_aluControl;
wire [3:0] o_aluControl_aluControl;

aluControl aluControl(	.i_aluOp(i_aluOp_aluControl), 
						.i_func(i_func_aluControl),
						.o_aluControl(o_aluControl_aluControl)
						);
////////////////////////////////////////////////////////////////////////

//init alu..............................................................
reg [31:0] i_op1_alu, i_op2_alu;
wire [3:0] i_control_alu;
wire [31:0] o_result_alu;
wire o_zf_alu;

alu alu(	.i_op1(i_op1_alu), 
			.i_op2(i_op2_alu), 
			.i_control(i_control_alu), 
			.o_result(o_result_alu), 
			.o_zf(o_zf_alu)
			);
////////////////////////////////////////////////////////////////////////

//init inst_memory......................................................
parameter DATA_WIDTH_INST_MEM = 32;
parameter ADDR_WIDTH_INST_MEM = 8;

reg [(ADDR_WIDTH_INST_MEM-1):0] i_addr_inst_memory;
wire [(DATA_WIDTH_INST_MEM-1):0] o_data_inst_memory;

inst_memory #(.ADDR_WIDTH(ADDR_WIDTH_INST_MEM),.DATA_WIDTH(DATA_WIDTH_INST_MEM)) inst_memory(	.i_addr(i_addr_inst_memory),
																								.o_data(o_data_inst_memory)
																								);
////////////////////////////////////////////////////////////////////////

//descript test for module

//inst_mem - alu_control
assign i_aluOp_aluControl = o_data_inst_memory [27:26];
assign i_func_aluControl = o_data_inst_memory [5:0];

//alu_control - alu
assign i_control_alu = o_aluControl_aluControl;

//alu - data
assign i_data_mem = o_result_alu;



//init clk 
initial begin
	clk = 0;
	forever #(PERIOD / 2) clk = ~clk;
end

//increment addr instruction and data mem
initial begin
i_addr_inst_memory = 0;
i_addr_data_mem  = 0;
end

always @(posedge clk)begin
	i_addr_inst_memory <= i_addr_inst_memory + 1;
	i_addr_data_mem <= i_addr_data_mem + 1;
end

//increment opperands
initial begin
	i_op1_alu = 10;
	i_op2_alu = 5;
	i_op1_adder = 10;
	i_op2_adder = 10;
end

always @(posedge clk)begin
	i_op1_alu <= i_op1_alu + 1;
	i_op2_alu <= i_op2_alu + 1;
	i_op1_adder <= i_op1_adder + 1;
	i_op2_adder <= i_op2_adder + 1;
end

//data mem
initial begin
	i_we_data_mem = 1;
end

initial #500 $finish;
endmodule : testbench