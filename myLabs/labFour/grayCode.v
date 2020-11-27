module grayCode(output reg [2:0] o_out,input i_clk, input i_rst_n);
reg [2:0] phase;
reg [2:0] rom [7:0];
initial $readmemh ("grayCodeFile.hex", rom);

always @(posedge i_clk or negedge i_rst_n) begin //counter description
	if (~i_rst_n) begin
		phase <= 4'b0;
	end
	else phase <= phase +1'b1;
end

always @(posedge i_clk) o_out <= rom[phase]; //rom description 
endmodule