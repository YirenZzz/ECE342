module part1
	(
		input [31:0] X,
		input [31:0] Y,
		output [31:0] result
);

// Design your 32-bit Floating Point unit here. 

//First, XOR the sign bits of X & Y to get the sign of the result.
assign result[31]=X[31]^Y[31];
//Next, add the exponents of X & Y.
logic [30:23]add;
assign add[30:23]=X[30:23] + Y[30:23]
//Multiply the (23-bit) mantissas of X & Y. Along with the hidden 1 in each mantissa, this results in a 48-bit product.
logic [47:0]multi;
assign multi=X[22:0] * Y[22:0];
//Round the 48-bit product by truncating the least significant 23-bits. You should be left with a 25-bit number; 2 hidden bits and 23 mantissa bits.
logic [24:0]round;
assign round[24:0]=muti[48:23]
logic normalised
assign normalised = multi[47] ? 1'b1 : 1'b0;
logic product_normalised
assign product_normalised = normalised ? multi : multi << 1;



assign result[22:0]=round[22:0]

endmodule
