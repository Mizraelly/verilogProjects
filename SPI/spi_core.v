module spi_core 
	#(	parameter DATA_WIDTH = 32,
	  	parameter DELAY_WIDTH = 32)
	(i_clk, i_rst_n, i_start, i_data_length, i_data, i_delay, o_mosi, o_sck, o_start, o_finish);

input 						i_clk;
input 						i_rst_n;

input		 				i_start;
input 	[3:0] 				i_data_length;
input	[DATA_WIDTH-1:0] 	i_data;
input 	[DELAY_WIDTH-1:0]	i_delay;

output reg					o_mosi;
output reg					o_sck;
output reg					o_start;
output reg					o_finish;


localparam STATE_WIDTH = 3;

localparam IDLE = 0;
localparam LOAD_DATA = 1;
localparam OUTPUT_DATA = 2;
localparam POSEDGE_SCK = 3;
localparam POSEDGE_DELAY = 4;
localparam NEGEDGE_SCK = 5;
localparam NEGEDGE_DELAY = 6;
localparam END_DATA_TRANS = 7;


reg [STATE_WIDTH-1:0]		next_state, state;

// add 1 MSB to shift register (o_mosi)
reg [DATA_WIDTH-1:0] 		shift_register;

reg [3:0] 					cnt_data_length;
reg [DELAY_WIDTH-1:0] 		cnt_delay;

/////////////////////////////////////////////////////////
// data length counter description:

always @(posedge i_clk, negedge i_rst_n) begin
	if(~i_rst_n)
		cnt_data_length <= 0;
	else if (state == IDLE)
		cnt_data_length <= 0;
	else if (state == OUTPUT_DATA)
		cnt_data_length <= cnt_data_length + 1'b1;
	else 
		cnt_data_length <= cnt_data_length;
end

/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
// delay counter description:

always @(posedge i_clk, negedge i_rst_n) begin
	if(~i_rst_n)
		cnt_delay <= 0;
	else if (state == POSEDGE_SCK || state == NEGEDGE_SCK)
		cnt_delay <= 0;
	else if (state == POSEDGE_DELAY || state == NEGEDGE_DELAY)
		cnt_delay <= cnt_delay + 1'b1;
	else 
		cnt_delay <= cnt_delay;
end


/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
// o_start and o_finish description:

// o_start
always @(posedge i_clk, negedge i_rst_n) begin
	if(~i_rst_n)
		o_start <= 1'b0;
	else if (state == IDLE)
		o_start <= 1'b0;
	else if (state == LOAD_DATA)
		o_start <= 1'b1;
	else
		o_start <= o_start;
end

// o_finish
always @(posedge i_clk, negedge i_rst_n) begin
	if(~i_rst_n)
		o_finish <= 1'b0;
	else if (state == IDLE)
		o_finish <= 1'b0;
	else if (state == END_DATA_TRANS)
		o_finish <= 1'b1;
	else 
		o_finish <= o_finish;
end

/////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////
// shift register description:

// main shifter:
always @(posedge i_clk, negedge i_rst_n) begin
	if(~i_rst_n)
		shift_register <= 0; 
	else if (state == LOAD_DATA)
		shift_register <= i_data;
	else if (state == OUTPUT_DATA)
		shift_register <= {shift_register[DATA_WIDTH-2:0],1'b0};
	else
		shift_register <= shift_register;
end

// 1 bit reg o_mosi:
always @(posedge i_clk, negedge i_rst_n) begin
	if(~i_rst_n)
		o_mosi <= 1'b0;
	else if (state == OUTPUT_DATA)
		o_mosi <= shift_register[DATA_WIDTH-1];
	else 
		o_mosi <= o_mosi;
end

/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
// SCK description:

always @(posedge i_clk, negedge i_rst_n) begin
	if (~i_rst_n)
		o_sck <= 1'b0;
	else if (state == IDLE)
		o_sck <= 1'b0;
	else if (state == POSEDGE_SCK) 
		o_sck <= 1'b1;
	else if (state == NEGEDGE_SCK)
		o_sck <= 1'b0;
	else 
		o_sck <= o_sck;
end

/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
// State machine description:
//

//----------------------------------
// Sequential block:
always @(posedge i_clk, negedge i_rst_n) begin
	if (~i_rst_n)
		state <= IDLE;
	else
		state <= next_state;
end

//----------------------------------


//----------------------------------
// Combinational block:

always @* 
begin
	case (state)
		IDLE: begin
			if (i_start)
				next_state = LOAD_DATA;
			else
				next_state = IDLE;
		end

		LOAD_DATA: begin
			next_state = OUTPUT_DATA;
		end

		OUTPUT_DATA: begin
			next_state = POSEDGE_SCK;
		end

		POSEDGE_SCK: begin
			next_state = POSEDGE_DELAY;
		end

		POSEDGE_DELAY: begin
			if (cnt_delay < i_delay)
				next_state = POSEDGE_DELAY;
			else
				next_state = NEGEDGE_SCK;
		end

		NEGEDGE_SCK: begin
			next_state = NEGEDGE_DELAY;
		end

		NEGEDGE_DELAY: begin
			if (cnt_delay < i_delay)
				next_state = NEGEDGE_DELAY;
			else if (cnt_data_length < i_data_length)
				next_state = OUTPUT_DATA;
			else 
				next_state = END_DATA_TRANS;
		end

		END_DATA_TRANS: begin
			next_state = IDLE;
		end

		default: begin
			next_state = IDLE;
		end
	endcase
end

//----------------------------------

/////////////////////////////////////////////////////////

endmodule