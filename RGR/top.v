module top(i_clk,i_rst_n,o_en,o_miso,o_mosi);
input i_clk,i_rst_n;
output o_en,o_miso,o_mosi;

wire en,sck,mosi,miso;

master master1(i_clk,i_rst_n,miso,en,sck,mosi);
slave slave1(i_clk,sck,i_rst_n,mosi,en,miso);

assign o_en = en;
assign o_mosi = mosi;
assign o_miso = miso;
endmodule