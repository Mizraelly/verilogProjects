module top(i_clk,i_sck,i_rst_n,i_data,i_load,o_en,o_miso,o_mosi);
input i_clk,i_rst_n,i_sck,i_load;
input [7:0] i_data;
output o_en,o_miso,o_mosi;

wire en,mosi,miso;

master master1(i_clk,i_sck,i_rst_n,i_data,i_load,miso,en,mosi);
slave slave1(i_clk,i_sck,i_rst_n,mosi,en,miso);

assign o_en = en;
assign o_mosi = mosi;
assign o_miso = miso;
endmodule