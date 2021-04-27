module mux3in1(i_dat0, i_dat1, i_dat2, i_control, o_dat);

parameter WIDTH = 32;

input   [WIDTH-1:0]   i_dat0, i_dat1, i_dat2; 
input   [1:0]         i_control;
output  reg [WIDTH-1:0]   o_dat;
  


always @(*) begin
    case (i_control) //synthesis full_casse
        2'b00: o_dat = i_dat0;
        2'b01: o_dat = i_dat1;
        2'b10: o_dat = i_dat2;
    endcase
end
  
endmodule