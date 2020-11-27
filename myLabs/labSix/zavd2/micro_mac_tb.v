`timescale 1ns/1ps
module testbench;

parameter PERIOD = 20;

reg clk,x1,x2,x3;
wire out;
micro_mac machine(.i_clk(clk),.i_x1(x1),.i_x2(x2),.i_x3(x3),.o_out(out));

initial begin
	x1 = 0;
	x2 = 0;
	x3 = 0;
end

//create signal clk
initial begin
	clk = 0;
	forever #(PERIOD/2)  clk = ~clk; 
end

//x1
initial begin
	x1 = 0;
	forever #(PERIOD/2) x1 = ~x1;
end

//x2
initial begin
	x2 = 0;
	forever #(PERIOD) x2 = ~x2;
end

//x3
initial begin
	x3 = 0;
	forever #(PERIOD*2) x3 = ~x3;
end

initial #10000 $finish; //after 2000 ns, finish simulate
endmodule