module count(i_clk,sck_detect,i_rst_n,i_rst_mac,i_en,o_cnt_f);
input i_clk,sck_detect,i_rst_n,i_rst_mac,i_en;
output o_cnt_f;

reg [3:0] counter;
parameter cntNum = 8;

assign o_cnt_f = (counter == cntNum); // cnt_f = 1 if counter == cnt

always @(posedge i_clk or negedge i_rst_n ) begin
	if (~i_rst_n | i_rst_mac) begin
		// reset
		counter <= 3'b0;
	end else begin
		if(i_en & sck_detect) counter <= counter + 1'b1;
	end
end
endmodule