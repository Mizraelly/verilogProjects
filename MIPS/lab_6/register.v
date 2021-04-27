module register (i_clk, i_data, i_en_n, i_rst_n, o_data);
parameter WIDTH = 32;

input 	  	[WIDTH-1:0] 		i_data;
input 							i_clk,i_en_n,i_rst_n;
output reg 	[WIDTH-1:0] 		o_data;

always @(posedge i_clk, negedge i_rst_n) begin
	if (~i_rst_n) begin
		o_data <= 32'b0;
	end else if(~i_en_n) begin
		o_data <= i_data;
	end
end

endmodule