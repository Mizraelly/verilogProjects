module stateMac(i_clk,i_sck_detect,i_rst_n,i_en_n,i_count_f,o_en_write_par_reg,o_en_write_word_to_par_reg,o_en_write_word_to_shreg,o_en_shift_reg,o_inc_reg,o_en_miso,o_en_count,o_res_count);
input i_clk,i_rst_n,i_en_n,i_count_f,i_sck_detect;
output reg o_en_write_par_reg,o_en_write_word_to_par_reg,o_en_write_word_to_shreg,o_en_shift_reg,o_en_miso,o_en_count,o_res_count,o_inc_reg;

reg [2:0] state,nextState; 
parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5, G = 6;

always @(posedge i_clk or negedge i_rst_n or posedge i_en_n) begin
	if (~i_rst_n | i_en_n) begin
		// reset
		state <= A;
	end else begin
		state <= nextState;
	end
end

always @(*) begin 
	if (~i_rst_n | i_en_n) begin
		// reset
		nextState = A;
	end else begin
		case (state)
			A: if(i_count_f)	nextState = B;   // State A wait 'i_count_f' (while counter count eight impulse SCK)
			B: 					nextState = C;	 // enable write addr to par_reg1
			C: 					nextState = D;	 // disable write addr to par_reg1 and enable write word to par_reg2
			D: 					nextState = E;	 // enable write word to shift_reg
			E: if(i_count_f)	nextState = F;	 // enable shift_reg, enable miso tri -> transfer word to master
			F: if(i_sck_detect)	nextState = G;   // disable transfer
			G: 					nextState = C;
		endcase
	end
end

always @(*) begin
	if (~i_rst_n | i_en_n) begin
		// reset
		begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 1;
				o_en_miso = 0;
				o_en_count = 1;
				o_res_count = 0;
				o_inc_reg = 0;
			end
	end else begin
		case (state)
			A:	begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 1;
				o_en_miso = 0;
				o_en_count = 1;
				o_res_count = 0;
				o_inc_reg = 0;
			end
			B:	begin
				o_en_write_par_reg = 1;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 0;
				o_en_miso = 0;
				o_en_count = 0;
				o_res_count = 1;
				o_inc_reg = 0;
			end
			C:	begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 1;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 0;
				o_en_miso = 0;
				o_en_count = 0;
				o_res_count = 1;
				o_inc_reg = 0;
			end
			D:	begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 1;
				o_en_shift_reg = 0;
				o_en_miso = 0;
				o_en_count = 0;
				o_res_count = 1;
				o_inc_reg = 0;
			end
			E:	begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 1;
				o_en_miso = 1;
				o_en_count = 1;
				o_res_count = 0;
				o_inc_reg = 0;
			end
			F:	begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 0;
				o_en_miso = 0;
				o_en_count = 0;
				o_res_count = 1;
				o_inc_reg = 0;
			end
			G:	begin
				o_en_write_par_reg = 0;
				o_en_write_word_to_par_reg = 0;
				o_en_write_word_to_shreg = 0;
				o_en_shift_reg = 0;
				o_en_miso = 0;
				o_en_count = 0;
				o_res_count = 1;
				o_inc_reg = 1;
			end
		endcase
	end
end

endmodule