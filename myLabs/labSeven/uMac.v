module uMac(i_a1,i_a2,i_b1,i_b2,i_clk,i_rst_n,i_mode,i_task,o_out1,o_out2);
input [15:0] i_a2 , i_a1, i_b2, i_b1;
input i_clk,i_rst_n,i_mode;
input [1:0] i_task;
output[31:0] o_out2 , o_out1;

reg [31:0] out1,out2;
parameter Complex = 1, Simple = 0;

wire [31:0] outAU1,outAU2,outRe,outIm;


assign o_out1 = out1;
assign o_out2 = out2;

AU AU1(i_a1,i_a2,i_b1,i_b2,i_task,outAU1,outAU2);
CU CU1(i_a1,i_a2,i_b1,i_b2,i_task,outRe,outIm);

always@(posedge i_clk , negedge i_rst_n) begin
	if (~i_rst_n) begin
		// reset
		out1 <= 32'b0;
		out2 <= 32'b0;
	end else begin
		case (i_mode)
			Simple: begin 	out1 <= outAU1;
							out2 <= outAU2; end
				
			Complex:begin 	out1 <= outRe;
							out2 <= outIm; end 
					
		endcase
	end
end
endmodule