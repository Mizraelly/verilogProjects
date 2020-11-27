module VarTwo(pin_name, pin_name1,pin_name2, out);
	input pin_name,pin_name1,pin_name2;
	output out;
	assign out = (pin_name & pin_name1) | (~pin_name & ~pin_name1 & pin_name2);
endmodule