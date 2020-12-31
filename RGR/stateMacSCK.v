module stateMacSCK(clk,rst_n,miso_zero,cnt_sck_done,cnt_done,cnt_en,sck_en,rstSCK,write_addr_en,addr_cnt_en,en_cnt_sck,en,write_word_to_rom );
input clk,rst_n,miso_zero,cnt_done,cnt_sck_done;
output reg sck_en,cnt_en,write_addr_en,addr_cnt_en,en_cnt_sck,rstSCK,en,write_word_to_rom;

reg[2:0] state,next_state;

parameter A = 0, B = 1, C= 2 , D = 3, E= 4, F = 5, G = 6,H = 7;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		// reset
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	if (~rst_n) begin
		// reset
		state = A;
	end else begin
		case (state)
			A: 					 	next_state = B; //активує периферію Cs = 0,загружає в sh_reg_mosi адресу
			B:	if(cnt_sck_done)	next_state = C; //дозволяє формувати SCK,чекає 8 імпульсів SCK,поки передасться адреса
			C:						next_state = D; //скидає лічильник імпульсів CSK
			D:  if(cnt_sck_done)	next_state = E; //рахує 8 імпульсів SCK
			E:  if(miso_zero)		next_state = F; //перевіряє якщо 0 то СS = 1, витримуєм його декілька тактів
				else 				next_state = H; //інакше записуємо в память слово
			F:	if(cnt_done) 		next_state = G; //витримуємо декілька тактів CS = 1
			G:  					next_state = A; //інкрементуємо адресу,вертаємось в стан A
			H:						next_state = C; //записуємо слово в память
			default: next_state = A;
		endcase
	end
end

always@* begin
	if(~rst_n) begin
		state = A;
	end else begin
		case (state)
			A: begin
				en = 0;
				write_addr_en = 1;
				sck_en = 0;
				rstSCK = 1;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 1;
				write_word_to_rom = 0;
			end
			B: begin
				en = 0;
				write_addr_en = 0;
				sck_en = 1;
				rstSCK = 0;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 1;
				write_word_to_rom = 0;
			end
			C: begin
				en = 0;
				write_addr_en = 0;
				sck_en = 1;
				rstSCK = 0;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 0;
				write_word_to_rom = 0;
			end
			D: begin
				en = 0;
				write_addr_en = 0;
				sck_en = 1;
				rstSCK = 0;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 1;
				write_word_to_rom = 0;
			end
			E: begin
				en = 0;
				write_addr_en = 0;
				sck_en = 1;
				rstSCK = 0;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 0;
				write_word_to_rom = 0;
			end
			F: begin
				en = 1;
				write_addr_en = 0;
				sck_en = 0;
				rstSCK = 1;
				cnt_en = 1;
				addr_cnt_en = 0;
				en_cnt_sck = 0;
				write_word_to_rom = 0;
			end
			G: begin
				en = 1;
				write_addr_en = 0;
				sck_en = 0;
				rstSCK = 1;
				cnt_en = 1;
				addr_cnt_en = 1;
				en_cnt_sck = 0;
				write_word_to_rom = 0;
			end
			H:
			begin
				en = 0;
				write_addr_en = 0;
				sck_en = 1;
				rstSCK = 0;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 0;
				write_word_to_rom = 1;
			end
			default:
			 begin
				en = 0;
				write_addr_en = 1;
				sck_en = 0;
				rstSCK = 1;
				cnt_en = 0;
				addr_cnt_en = 0;
				en_cnt_sck = 1;
				write_word_to_rom = 0;
			end
		endcase
	end
end
endmodule