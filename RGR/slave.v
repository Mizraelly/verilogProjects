module slave(i_clk,i_sck,i_rst_n,i_mosi,i_en_n,o_miso);
input i_clk,i_rst_n,i_sck,i_en_n,i_mosi;
output o_miso;

reg [7:0] ascii_word_rom [255:0];			//rom
reg [7:0] par_reg1,par_reg2,shift_reg;		//reg	
reg [2:0] syn_reg_sck_ff, syn_reg_cs_ff; 	//init double flopping
reg [1:0] mosi_sync_ff;//
wire sck_detect,cs_detect;	//wire that use to detect rise front				
assign sck_detect = ~syn_reg_sck_ff[2] & syn_reg_sck_ff[1]; //detect rise front
assign cs_detect = ~syn_reg_cs_ff[2] & syn_reg_cs_ff[1];	//detect rise front

wire count_f; 							//need to detect count overflow
wire wr_par_reg,wr_wd_to_par_reg,wr_wd_to_sh,en_sh_reg,inc_reg,en_miso,en_cnt,res_cnt; //output of state machine

assign o_miso = en_miso ? shift_reg[7] : 1'bz;

count count1(sck_detect,i_rst_n,res_cnt,en_cnt,count_f);
stateMac MAC1(i_clk,sck_detect,i_rst_n,cs_detect,count_f,wr_par_reg,wr_wd_to_par_reg,wr_wd_to_sh,en_sh_reg,inc_reg,en_miso,en_cnt,res_cnt);

initial $readmemh("romASCII.hex",ascii_word_rom);


always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping sck
	if (~i_rst_n) begin
		// reset
		syn_reg_sck_ff <= 3'b0;
	end	else begin
		syn_reg_sck_ff <= {syn_reg_sck_ff[1:0],i_sck};
	end
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping chip select
	if (~i_rst_n) begin
		// reset
		syn_reg_cs_ff <= 3'b111;
	end	else begin
		syn_reg_cs_ff <= {syn_reg_cs_ff[1:0],i_en_n};
	end
end

always @(posedge i_clk or negedge i_rst_n) begin 				//double flopping i_mosi (addr)
	if(~i_rst_n) mosi_sync_ff <= 2'b0;
	else mosi_sync_ff <= {mosi_sync_ff[0],i_mosi};
end

always @(posedge i_clk,negedge i_rst_n) begin 					//descript par_reg1 
	if(~i_rst_n) par_reg1 <= 8'b0;
	else if(wr_par_reg) par_reg1 <= shift_reg;
	else if (inc_reg) par_reg1 <= par_reg1 + 1'b1;
end

always @(posedge i_clk, negedge i_rst_n) begin 					//descript par_reg2
	if(~i_rst_n) par_reg2 <= 8'b0;
	else if(wr_wd_to_par_reg) par_reg2 <= ascii_word_rom[par_reg1[7:0]];
end

always @(posedge i_clk or negedge i_rst_n) begin 				//descript shift register
	if(~i_rst_n) shift_reg <= 8'b0;
	else if (wr_wd_to_sh) shift_reg <= par_reg2;
	else if (en_sh_reg & sck_detect) shift_reg <= {shift_reg[6:0],mosi_sync_ff[1]};
end

endmodule