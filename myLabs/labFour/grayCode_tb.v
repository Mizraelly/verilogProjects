`timescale 1ns / 1ps
module testbench; 

wire [2:0]out;
reg clk , rst_n;

parameter PERIOD = 20;

grayCode grayCode (.o_out(out), .i_clk(clk), .i_rst_n(rst_n));

initial begin
	clk = 1'b0;
	forever #(PERIOD / 2) clk = ~clk;
end

initial begin
	rst_n = 1'b0;
	#10 rst_n = 1'b1;
end

initial #320 $finish;

endmodule