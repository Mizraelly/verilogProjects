`timescale 1ns/1ps
module master(i_clk,i_rst_n,i_miso,o_en,o_sck,o_mosi);
input i_clk,i_rst_n,i_miso;
output o_en,o_sck,o_mosi;

reg [7:0] shift_reg_miso,shift_reg_mosi;
reg [4:0] count_data_reg;
reg [7:0] data_reg [31:0];
reg [6:0] sck_gen;
reg [2:0] sync_reg_miso_ff;
reg [2:0] sync_reg_sck_ff,sync_reg_cs_ff;
wire sck_detect,cs_detect,out_sck_gen;

parameter PERIOD = 20;
reg en;
				
assign sck_detect = ~sync_reg_sck_ff[2] & sync_reg_sck_ff[1]; //detect rise front SCK
assign cs_detect = ~sync_reg_cs_ff[2] & sync_reg_cs_ff[1];	//detect rise front CS

assign o_en = en;
assign out_sck_gen = sck_gen[6];
assign o_sck = out_sck_gen;
assign o_mosi = shift_reg_mosi[7]; 


parameter ADDR = 0;
reg [7:0] addr;
reg [3:0] counter_sck;
reg rst_cnt;
always @(posedge i_clk or negedge i_rst_n or negedge rst_cnt) begin
	if (~i_rst_n | ~rst_cnt) begin
		// reset
		counter_sck <= 8'd0;
	end else if (sck_detect) begin
		counter_sck <= counter_sck + 1'b1;
	end
end

initial begin
	en = 1;
	rst_cnt = 0;
	addr <= ADDR;
	#50 en = 0;
	rst_cnt = 1;
	forever #(PERIOD / 2) begin
		if(counter_sck == 8) begin
			if(shift_reg_miso == 0) begin
				en = 1;
				addr = addr + 25; 
				#2 shift_reg_mosi <= addr;
				#40 en = 0;
			end
		rst_cnt = 0;
		#4 rst_cnt = 1;
		end
	end
end


always @(posedge i_clk or negedge i_rst_n) begin 			//descript count that need to div i_clk (sck gen)
	if (~i_rst_n) 		sck_gen <= 7'd0;
	else if(~o_en)		sck_gen <= sck_gen + 1'b1;
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping sck
	if (~i_rst_n) begin
		// reset
		sync_reg_sck_ff <= 3'd0;
	end	else begin
		sync_reg_sck_ff <= {sync_reg_sck_ff[1:0],out_sck_gen};
	end
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping chip select
	if (~i_rst_n) begin
		// reset
		sync_reg_cs_ff <= 3'b111;
	end	else begin
		sync_reg_cs_ff <= {sync_reg_cs_ff[1:0],en};
	end
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping MISO
	if (~i_rst_n) begin
		// reset
		sync_reg_miso_ff <= 2'd0;
	end	else begin
		sync_reg_miso_ff <= {sync_reg_miso_ff[0],i_miso};
	end
end

always@(posedge i_clk , negedge i_rst_n)begin 				// descript shift reg MISO 
	if(~i_rst_n) shift_reg_miso <= 8'd0;
	else if(sck_detect) shift_reg_miso <= {shift_reg_miso[6:0],sync_reg_miso_ff[1]};
end

always@(posedge i_clk,negedge i_rst_n)begin 						// descript shift reg MOSI
 	if(~i_rst_n) shift_reg_mosi <= 8'd0;
	else if(sck_detect) shift_reg_mosi <= {shift_reg_mosi[6:0],0};
end

always @(posedge i_clk or negedge i_rst_n)begin 				//descript counter for data_reg
	if (~i_rst_n) count_data_reg <= 5'd0;
	else if(cs_detect) count_data_reg <= count_data_reg + 1'b1;
end

always @(posedge i_clk) begin 			  	//write data in data_reg
	 if(cs_detect) data_reg[count_data_reg] <= shift_reg_miso;
end
endmodule