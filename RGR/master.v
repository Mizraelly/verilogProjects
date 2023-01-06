`timescale 1ns/1ps
module master(i_clk,i_rst_n,i_miso,o_en,o_sck,o_mosi);
input i_clk,i_rst_n,i_miso;
output o_en,o_sck,o_mosi;

reg [7:0] shift_reg_miso,shift_reg_mosi;
reg [7:0] count_data_reg;
reg [7:0] data_reg [255:0];
reg [7:0] addr_reg [5:0];
wire en_write_mosi_reg;
wire addr_cnt_en;
reg [6:0] sck_gen;
reg [2:0] sync_reg_miso_ff;
reg [2:0] sync_reg_sck_ff;
reg [3:0] cnt_sck_impulse;
reg [3:0] addr_cnt;
wire sck_detect,cs_detect;

parameter PERIOD = 20;

				
initial $readmemh("romDATAmasterASCII.hex",data_reg);
initial $readmemh("romAddrMasterMosi.hex",addr_reg);

assign sck_detect = ~sync_reg_sck_ff[2] & sync_reg_sck_ff[1]; //detect rise front SCK
assign o_mosi = shift_reg_mosi[7]; 

wire cnt_cs_en,cnt_sck_en,en_cnt_sck;
parameter cnt_hole_cs = 5;
reg [3:0] cnt_cs;
wire cnt_hole_cs_done = (cnt_cs == cnt_hole_cs); // якщо нарахувало cnt_hole_cs то done = 1 


parameter SCK_COUNT = 5207;
reg [12:0] sck_cnt;
wire rst_cnt_sck = (sck_cnt == SCK_COUNT);

wire sck_out = sck_cnt[12];
assign o_sck = sck_out;

parameter SCK_CNT_IMP = 8;
wire cnt_sck_done = (SCK_CNT_IMP == cnt_sck_impulse);
wire miso_detect_zero = (~|shift_reg_miso);

wire write_word_to_rom;

stateMacSCK Mac(.clk(i_clk),
				.rst_n(i_rst_n),
				.miso_zero(miso_detect_zero),
				.cnt_sck_done(cnt_sck_done),
				.cnt_done(cnt_hole_cs_done),
				.cnt_en(cnt_cs_en),
				.sck_en(cnt_sck_en),
				.rstSCK(rst_cnt_sck_stateMac),
				.write_addr_en(en_write_mosi_reg),
				.addr_cnt_en(addr_cnt_en),
				.en_cnt_sck(en_cnt_sck),
				.en(o_en),
				.write_word_to_rom(write_word_to_rom));
		//	(clk,rst_n,miso_zero,cnt_sck_done,cnt_done,cnt_en,sck_en,rstSCK,write_addr_en,addr_cnt_en,en_cnt_sck,en);
always @(posedge i_clk, negedge i_rst_n) begin
	if (~i_rst_n | cnt_hole_cs_done) begin
		cnt_cs <= 4'd0;
	end else if (cnt_cs_en) begin
		cnt_cs <= cnt_cs + 1'b1;
	end
end

always @(posedge i_clk or negedge i_rst_n) begin //count SCK impulse
	if (~i_rst_n | cnt_sck_done) begin
		cnt_sck_impulse <= 0;
	end else if (sck_detect & en_cnt_sck) begin
		cnt_sck_impulse <= cnt_sck_impulse + 1'b1;
	end
end

always @(posedge i_clk,negedge i_rst_n)begin //divider clk -> sck 9600hz
	if(~i_rst_n | rst_cnt_sck | rst_cnt_sck_stateMac)begin
		sck_cnt <= 0;
	end else if (cnt_sck_en) begin
		sck_cnt <= sck_cnt + 1'b1;
	end
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping sck
	if (~i_rst_n) begin
		// reset
		sync_reg_sck_ff <= 3'd0;
	end else begin
		sync_reg_sck_ff <= {sync_reg_sck_ff[1:0],sck_out};
	end
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping MISO
	if (~i_rst_n) begin
		// reset
		sync_reg_miso_ff <= 2'd0;
	end else begin
		sync_reg_miso_ff <= {sync_reg_miso_ff[1:0],i_miso};
	end
end

always@(posedge i_clk , negedge i_rst_n)begin 				// descript shift reg MISO 
	if(~i_rst_n) shift_reg_miso <= 8'd0;
	else if(sck_detect) shift_reg_miso <= {shift_reg_miso[6:0],sync_reg_miso_ff[2]};
end

always@(posedge i_clk,negedge i_rst_n)begin 						// descript shift reg MOSI
 	if(~i_rst_n) shift_reg_mosi <= 8'd0;
 	else if (en_write_mosi_reg) shift_reg_mosi <= addr_reg[addr_cnt];
	else if(sck_detect) shift_reg_mosi <= {shift_reg_mosi[6:0],1'b0};
end

always @(posedge i_clk or negedge i_rst_n) begin
	if (~i_rst_n) begin
		addr_cnt <= 0;
	end else if (addr_cnt_en) begin
		addr_cnt <= addr_cnt + 1'b1;
	end
end

always @(posedge i_clk or negedge i_rst_n)begin 				//descript counter for data_reg
	if (~i_rst_n) count_data_reg <= 5'd0;
	else if(write_word_to_rom) count_data_reg <= count_data_reg + 1'b1;
end

always @(posedge i_clk) begin 			  	//write data in data_reg
	 if(write_word_to_rom) data_reg[count_data_reg] <= shift_reg_miso;
end

endmodule