module data_memory(i_clk, i_addr, i_data, i_we, o_data);
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 5; //32 4-byte words 

input                     i_clk, i_we;
input   [ADDR_WIDTH-1:0]  i_addr;
input   [DATA_WIDTH-1:0]  i_data;
output reg  [DATA_WIDTH-1:0]  o_data;

reg [(DATA_WIDTH-1):0] data_mem [31:0];

initial $readmemh("data_mem_init.hex",data_mem);
//synchronous input
always@(posedge i_clk)begin
	if(i_we) begin
		data_mem[i_addr] <= i_data;
	end 
end

//asynchronous output
always@(*)begin
	o_data = data_mem [i_addr];
end

endmodule