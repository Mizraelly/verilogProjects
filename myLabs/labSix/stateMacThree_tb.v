`timescale 1ns/1ps
module testbench;

parameter PERIOD = 20;

reg clk , rst;
reg  x , y;
wire [2:0] state;
wire [1:0] z1 , z2;
stateMacThree statemac(.i_clk(clk),.i_rst_n(rst),.i_x(x),.i_y(y),.sta(state),.o_z1(z1),.o_z2(z2));


initial begin
rst = 0;
#5 rst = 1;
end

initial begin
	clk = 0;
	forever #(PERIOD/2)  clk = ~clk;
end

initial begin
	x <= 1;
	y <= 1;
	forever #(PERIOD ) begin x = ~x; #100 y <= ~y; end
end


initial #2000 $finish;
endmodule