module CU(re1,im1,re2,im2,itask,outRe,outIm);

input [15:0] re1,im1,re2,im2;
input [1:0] itask;
output reg [31:0] outIm,outRe;
parameter SUM = 0, SUB = 1, MUL = 2, DIV = 3;
always @(re1,re2,im1,im2,itask)begin
	case (itask) 
		SUM: begin 	outRe = re1 + re2;	//A + B
					outIm = im1 + im2;
			end

		SUB: begin 	outRe = re1 - re2;	//A - B
					outIm = im1 - im2;
			end

		MUL: begin 	outRe = (re1 * re2) - (im1 * im2);	//A * B
					outIm = (im1 * re2) + (re1 * im2);
			end 

		DIV: begin 	outRe = ((re1 * re2) + (im1 * im2)) / ((re2 * re2) + (im2 * im2)); //A / B
					outIm = ((im1 * re2) - (im2 * re1)) / ((re2 * re2) + (im2 * im2)); 
			end
	endcase
end

endmodule 