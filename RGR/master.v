`timescale 1ns/1ps
module master(i_clk,i_sck,i_rst_n,i_data,i_load,i_miso,o_en,o_mosi);
input i_clk,i_sck,i_rst_n,i_miso,i_load;
input [7:0]i_data;
output o_en,o_mosi;

reg [7:0] shiftReg;

reg [2:0] sync_reg_sck_ff;
wire sck_detect;

parameter PERIOD = 20;
reg en;

initial begin
	en = 1;
	#50 en = 0;
end

assign sck_detect = ~sync_reg_sck_ff[2] & sync_reg_sck_ff[1];

assign o_en = en;
assign o_mosi = shiftReg [7]; 

always@(posedge i_clk, negedge i_rst_n)begin 				// descript shift reg
	if(~i_rst_n)		shiftReg <= 8'b0; 
	else if (i_load) 	shiftReg <= i_data;
	else if(sck_detect) shiftReg <= {shiftReg[6:0],i_miso};
end

always @(posedge i_clk or negedge i_rst_n) begin 			//double flopping sck 
	if (~i_rst_n)	sync_reg_sck_ff <= 3'b0;
	else			sync_reg_sck_ff <= {sync_reg_sck_ff[1:0],i_sck};
end

endmodule