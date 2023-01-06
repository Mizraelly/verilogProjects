`timescale 1ns / 1ps
module testbench;

	parameter PERIOD = 20;
	reg [1:0] mode;
	reg [7:0] a, b;
	reg i_clk;
	wire [16:0] out;

	ALU alu (.i_a(a), .i_b(b), .i_control(mode), .o_out(out));

	initial begin
		a = 0;
		b = 0;
		mode = 0;
	end

	initial begin
		i_clk = 0;
		forever #(PERIOD / 2) i_clk = ~i_clk;
	end

	always @(posedge i_clk) begin

		$display("%b 	%b 		%b 		%b",mode, a , b, out);
		if (mode == 2'b11 && a == 8'b11111111 && b == 8'b11111111)begin
			$finish;
		end

		if (b == 8'b1111_1111 && a == 8'b11111111) begin
			 mode = mode + 1;
		end

		if(a == 8'b11111111) begin 
			b = b + 1;
		end 

		a = a + 1;
	end
endmodule