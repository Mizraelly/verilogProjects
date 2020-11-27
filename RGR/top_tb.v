`timescale 1ns/1ps
module testbench;
reg clk,rst_n,sck,load;
reg [7:0] addr;
wire miso,mosi,en;

parameter PERIOD = 20;

top top1(clk,sck,rst_n,addr,load,en,miso,mosi);

initial begin
	rst_n = 0;
	#2 rst_n = 1;
	#20 load <= 1;
	addr = 0;
	//addr = $urandom_range(0,255);
	#20 load <= 0;
	forever #(PERIOD * 1000000) begin
		load <= 1;
		addr <= 0;
		//addr = $urandom_range(0,255);
		#20 addr <= 0;			
	end
end

initial begin
	clk = 0;
	forever #(PERIOD / 2) clk = ~clk;
end

initial begin
	sck = 0;
	forever #( PERIOD * 50) sck = ~sck; 
end

initial #250000 $finish;
endmodule