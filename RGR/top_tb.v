`timescale 1ns/1ps
module testbench;
reg clk,rst_n;
wire miso,mosi,en;

parameter PERIOD = 20;

top top1(clk,rst_n,en,miso,mosi);

initial begin
	rst_n = 0;
	#2 rst_n = 1;
	forever #(PERIOD * 1000000) begin
		rst_n = 0;
		#2 rst_n = 1;
	end
end

initial begin
	clk = 0;
	forever #(PERIOD / 2) clk = ~clk;
end


initial #250000 $finish;
endmodule