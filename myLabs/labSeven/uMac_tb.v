`timescale 1ns/1ps
module testbench;

reg clk, rst_n, mode;
reg [1:0] itask;
reg [15:0] a1,a2,b1,b2;
wire [31:0] out1,out2;

parameter PERIOD = 20;
uMac uMac1 (.i_a1(a1),.i_a2(a2),.i_b1(b1),.i_b2(b2),.i_clk(clk),.i_rst_n(rst_n),.i_task(itask),.i_mode(mode),.o_out1(out1),.o_out2(out2));

initial begin
	clk = 0;
	forever #(PERIOD / 2) clk = ~clk;
end

initial begin
a1 = 16'b0;
b1 = 16'b0;
a2 = 16'b0000_0000_1111_1111;
b2 = 16'b0;
itask = 2'b0;
mode = 0;
rst_n = 0;
#5 rst_n = 1;
end


always @(posedge clk)begin
	a1 <= a1 - 1;
	if(itask == 0)a2 = 120;
	else if(a2 == 16'b0000_0000_0000_0000) begin
		a1 <= 16'b0000_0000_1111_1111;
		a2 <= 16'b0000_0000_1111_1111;
	end	else if(a1 == 16'b0000_0000_0000_0000)begin
		a1 <= 16'b0000_0000_1111_1111;
		a2 <= a2 - 1;
	end 
end

always @(posedge clk)begin
	b1 <= b1 + 1;
	if(b2 == 16'b0000_0000_1111_1111) begin
		b1 <= 0;
		b2 <= 0;

		itask <= itask + 1;
		if(itask == 2'b11) mode <= mode + 1;

	end	else if(b1 == 16'b0000_0000_1111_1111)begin
		b1 <= 16'b0;
		b2 <= b2 + 1;
	end 
end

initial #10000000 $finish;
endmodule