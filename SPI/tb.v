`timescale 1ns/1ps

module testbench;

parameter PERIOD = 20;

parameter DATA_WIDTH = 8;
parameter DELAY_WIDTH = 32;

reg 						i_clk;
reg 						i_rst_n;

reg		 					i_start;
reg 	[3:0] 				i_data_length;
reg		[DATA_WIDTH-1:0] 	i_data;
reg 	[DELAY_WIDTH-1:0]	i_delay;

wire					o_mosi;
wire					o_sck;
wire					o_start;
wire					o_finish;

reg [DATA_WIDTH-1:0] shift_receiver;

spi_core #(	.DATA_WIDTH(DATA_WIDTH), .DELAY_WIDTH(32)) spi_core_0 (	
	.i_clk(i_clk), 
	.i_rst_n(i_rst_n), 
	.i_start(i_start), 
	.i_data_length(i_data_length), 
	.i_data(i_data), 
	.i_delay(i_delay), 
	.o_mosi(o_mosi), 
	.o_sck(o_sck), 
	.o_start(o_start), 
	.o_finish(o_finish)
);


// receiver 
always @(negedge o_sck, negedge i_rst_n) begin
	if (~i_rst_n)
		shift_receiver <= 0;
	else
		shift_receiver <= {shift_receiver[DATA_WIDTH-2:0],o_mosi};
end


initial begin
	i_clk = 0;
	forever #(PERIOD / 2) i_clk = ~i_clk;
end

initial begin
	i_rst_n = 0; i_start = 0; i_data_length = 8; i_data = 50; i_delay = 10; #20
	i_rst_n = 1; i_start = 1;
end

initial #5000 $finish;

endmodule