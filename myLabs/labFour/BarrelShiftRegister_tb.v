`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 10;

reg clk, load, res_n, direction_right;
reg [3:0] shift_emount;
reg [7:0] data;
wire [15:0] out;

BarrelShiftRegister BarrelShiftRegister (.o_out(out), .i_clk(clk), .i_load(load), .i_res_n(res_n), .i_direction_right(direction_right), .i_data(data), .i_shift_emount(shift_emount));

initial begin
	res_n = 1'b0;
	load = 1'b1;
	#60 res_n = 1'b1;
	#10 load = 1'b0;
end

initial begin
	shift_emount = 4'b0000;
	direction_right = 1'b1;
	forever #(PERIOD * 5)begin
	if(shift_emount == 4'b1111)begin
	shift_emount = 4'b0000;
	direction_right = 1'b0;
	end	else shift_emount = shift_emount + 1; 
	end
end

initial begin
	data = 8'b00110101;
end

initial begin
	clk = 1'b0;
	forever #(PERIOD/2) clk <= ~clk;
end
initial #1600 $finish;

endmodule