module signExtend(i_data,i_en,o_data);
parameter WISIGNEXTEND = 16;
parameter WOSIGNEXTEND = 32;

input   [WISIGNEXTEND-1 : 0]  		i_data;
input 								i_en;
output  [WOSIGNEXTEND-1 : 0]  		o_data;
	
assign o_data = i_en ? { {WISIGNEXTEND{i_data[WISIGNEXTEND-1]}} , i_data } : {16'b0,i_data};
endmodule