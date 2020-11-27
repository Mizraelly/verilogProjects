`timescale 1ns/1ps
module testbench;

parameter PERIOD = 20;

reg clk , reset , w;
wire out;
stateMacSix statemac(.i_clk(clk),.i_reset(reset),.i_w(w),.o_OUT1(out));


initial begin
reset = 0;
#2 reset = 1;
#2 reset = 0;
end

initial begin
	clk = 0;
	forever #(PERIOD/2)  clk = ~clk;
end

initial begin
	
	w = 1;
	forever #(PERIOD * 5) w = ~w;
end


initial #1000 $finish;
endmodule