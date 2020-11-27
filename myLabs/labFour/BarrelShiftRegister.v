module BarrelShiftRegister(o_out, i_clk, i_load, i_res_n, i_direction_right, i_data, i_shift_emount);
input i_clk, i_load, i_res_n, i_direction_right; 
input [7:0] i_data;
input [3:0] i_shift_emount;
output reg [15:0] o_out;

always@ (posedge i_clk, negedge i_res_n)begin
	if (~i_res_n)
		o_out <= 16'b0;
	else if (i_load) 
		o_out[7:0] <= i_data[7:0];
	else begin
		case(i_shift_emount)
			4'd1:
			if(i_direction_right)begin
			 o_out <= {o_out[0], o_out[15:1]};
			 end else begin
			 o_out <= {o_out[14:0], o_out[15]};
			end
			4'd2:
			if(i_direction_right)begin
			 o_out <= {o_out[1:0], o_out[15:2]};
			 end else begin
			 o_out <= {o_out[13:0], o_out[15:14]};
			end
			4'd3:
			if(i_direction_right)begin
			 o_out <= {o_out[2:0], o_out[15:3]};
			 end else begin
			 o_out <= {o_out[12:0], o_out[15:13]};
			end
			4'd4:
			if(i_direction_right)begin
			 o_out <= {o_out[3:0], o_out[15:4]};
			 end else begin
			 o_out <= {o_out[11:0], o_out[15:12]};
			end
			4'd5:
			if(i_direction_right)begin
			 o_out <= {o_out[4:0], o_out[15:5]};
			 end else begin
			 o_out <= {o_out[10:0], o_out[15:11]};
			end
			4'd6:
			if(i_direction_right)begin
			 o_out <= {o_out[5:0], o_out[15:6]};
			 end else begin
			 o_out <= {o_out[9:0], o_out[15:10]};
			end
			4'd7:
			if(i_direction_right)begin
			 o_out <= {o_out[6:0], o_out[15:7]};
			 end else begin
			 o_out <= {o_out[8:0], o_out[15:9]};
			end
			4'd8:
			if(i_direction_right)begin
			 o_out <= {o_out[7:0], o_out[15:8]};
			 end else begin
			 o_out <= {o_out[7:0], o_out[15:8]};
			end
			4'd9:
			if(i_direction_right)begin
			 o_out <= {o_out[8:0], o_out[15:9]};
			 end else begin
			 o_out <= {o_out[6:0], o_out[15:7]};
			end
			4'd10:
			if(i_direction_right)begin
			 o_out <= {o_out[9:0], o_out[15:10]};
			 end else begin
			 o_out <= {o_out[5:0], o_out[15:6]};
			end
			4'd11:
			if(i_direction_right)begin
			 o_out <= {o_out[10:0], o_out[15:11]};
			 end else begin
			 o_out <= {o_out[4:0], o_out[15:5]};
			end
			4'd12:
			if(i_direction_right)begin
			 o_out <= {o_out[11:0], o_out[15:12]};
			 end else begin
			 o_out <= {o_out[3:0], o_out[15:4]};
			end
			4'd13:
			if(i_direction_right)begin
			 o_out <= {o_out[12:0], o_out[15:13]};
			 end else begin
			 o_out <= {o_out[2:0], o_out[15:3]};
			end
			4'd14:
			if(i_direction_right)begin
			 o_out <= {o_out[13:0], o_out[15:14]};
			 end else begin
			 o_out <= {o_out[1:0], o_out[15:2]};
			end
			4'd15:
			if(i_direction_right)begin
			 o_out <= {o_out[14:0], o_out[15]};
			 end else begin
			 o_out <= {o_out[0], o_out[15:1]};
			end
		endcase
	end
end
endmodule