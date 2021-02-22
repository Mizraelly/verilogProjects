`timescale 1ns/1ps
module testbench;
//def mux param...........
parameter WMUX = 32;

reg [WMUX-1:0] dat0,dat1;
reg control;
wire [WMUX-1:0] odat;
//.......................

//def signExtend param............
parameter WISIGNEXTEND = 16;
parameter WOSIGNEXTEND = 32;

reg [WISIGNEXTEND-1 : 0] iDatSignEx;
reg SignExEn;
wire [WOSIGNEXTEND-1 : 0] oDatSignEx;
//................................

//def pc param............
reg i_rst_n_pc;
reg [31:0] in_pc;
wire [31:0] out_pc;
//................................

//def shiftLeftBy2 param............
parameter WSHL2 = 32;
reg [WSHL2-1:0] i_data_shift_by_2;
wire [WSHL2-1:0] o_data_shift_by_2;
//................................

//def regFile
reg [4:0]i_raddr1_reg,i_raddr2_reg,i_waddr_reg; 
reg [31:0] i_wdata_reg; 
reg i_we_reg;
wire [31:0] o_rdata1_reg,o_rdata2_reg;
//................................              

//def clock 50MHz........
reg clk;
parameter PERIOD = 20;
//.......................

mux2in1 mux2in1(.i_dat0(dat0),
				.i_dat1(dat1),
				.i_control(control),
				.o_dat(odat)
				);

signExtend #(.WISIGNEXTEND(WISIGNEXTEND),.WOSIGNEXTEND(WOSIGNEXTEND)) signExtend  ( .i_data(iDatSignEx),
																					.o_data(oDatSignEx),
																					.en(SignExEn)
																					);

pc pc ( .i_clk(clk),
		.i_rst_n(i_rst_n_pc),
		.i_pc(in_pc),
		.o_pc(out_pc)
		);

shiftLeftBy2 #(.WIDTH(WSHL2)) shiftLeftBy2 (.i_data(i_data_shift_by_2),
											.o_data(o_data_shift_by_2)
											); 

regFile regFile(.i_clk(clk), 
               	.i_raddr1(i_raddr1_reg), 
                .i_raddr2(i_raddr2_reg), 
               	.i_waddr(i_waddr_reg), 
               	.i_wdata(i_wdata_reg), 
               	.i_we(i_we_reg),
               	.o_rdata1(o_rdata1_reg),
               	.o_rdata2(o_rdata2_reg) 
               );


//init clk
initial begin
	clk = 0;
	forever #(PERIOD / 2) clk = ~clk;
end 

//init test for mux2in1................
initial begin
	dat0 = 32'd20;
	dat1 = 32'd10;
	control = 0;
	forever #(PERIOD * 5) begin
		control = control + 1'b1;
	end
end
//......................................

//init test for signExtend................
initial begin
	SignExEn = 0;
	iDatSignEx = 16'b1000_0000_0000_1111;
	forever #(PERIOD) SignExEn = ~SignExEn;
end

always @(posedge clk) begin
	iDatSignEx = iDatSignEx - 1'b1;
end
//......................................

//init test for pc................
initial begin
	in_pc = 0;
	i_rst_n_pc = 0;
	#5 i_rst_n_pc = 1;
	forever #(PERIOD) in_pc = in_pc + 1'b1;
end
//......................................

//init test for pc................
initial begin
	i_data_shift_by_2 = 0;
	forever #(PERIOD) i_data_shift_by_2 = i_data_shift_by_2 + 1'b1;
end
//......................................

//init test for regFile................
initial begin
	i_we_reg = 0;
	i_raddr1_reg = 0;
	i_raddr2_reg = 0;
	i_waddr_reg = 0;
	i_wdata_reg = 0;
	#2 i_we_reg = 1;
end

initial begin 
	forever #(PERIOD * 5) begin
		i_raddr1_reg <= i_raddr1_reg + 1;
		i_raddr2_reg <= i_raddr2_reg + 2;
	end
end

initial begin 
	forever #(PERIOD) begin
		i_waddr_reg <= i_waddr_reg + 1;
		i_wdata_reg <= i_wdata_reg + 5;
	end
end
//......................................



initial #1000 $finish;
endmodule : testbench