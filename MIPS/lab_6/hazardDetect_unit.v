module hazardDetect_unit 	(i_Rs,i_Rt,
							i_Rd_Ex, i_Rd_Mem, i_Rd_WB,
							i_RegWr_Ex,i_RegWr_Mem,i_RegWr_WB,
							i_MemRd_Ex,
							o_ForwardA, o_ForwardB, o_Stall
							);

input [4:0] i_Rs,i_Rt;
input [4:0] i_Rd_Ex, i_Rd_Mem, i_Rd_WB;
input 		i_RegWr_Ex,i_RegWr_Mem,i_RegWr_WB;
input 		i_MemRd_Ex;

output reg [1:0] o_ForwardA, o_ForwardB;
output reg o_Stall;


//Process data hazard......................................................

//check op Rs
always @(*) begin
	if     (i_Rs != 0 && i_Rs == i_Rd_Ex && i_RegWr_Ex)   o_ForwardA = 1;
	else if(i_Rs != 0 && i_Rs == i_Rd_Mem && i_RegWr_Mem) o_ForwardA = 2;
	else if(i_Rs != 0 && i_Rs == i_Rd_WB && i_RegWr_WB) 	o_ForwardA = 3;
	else 													o_ForwardA = 0;
end

//check op Rs
always @(*) begin
	if     (i_Rt != 0 && i_Rt == i_Rd_Ex && i_RegWr_Ex)   o_ForwardB = 1;
	else if(i_Rt != 0 && i_Rt == i_Rd_Mem && i_RegWr_Mem) o_ForwardB = 2;
	else if(i_Rt != 0 && i_Rt == i_Rd_WB && i_RegWr_WB) 	o_ForwardB = 3;
	else 													o_ForwardB = 0;
end

//RAW (generate stall signal)
always @(*)begin
	if(i_MemRd_Ex && ((o_ForwardB == 1) || (o_ForwardA == 1))) o_Stall = 1;
	else o_Stall = 0;
end

/////////////////////////////////////////////////////////////////////////////


endmodule