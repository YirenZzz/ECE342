module part2
	(
		input [31:0] X,
		input [31:0] Y,
		output inf, nan, zero, overflow, underflow,
		output reg[31:0] result
);
logic [127:0]EB;
assign EB=8
// Design your 32-bit Floating Point unit here. 
//First, XOR the sign bits of X & Y to get the sign of the result.
assign result[31]=X[31]^Y[31];
//Next, add the exponents of X & Y.
logic [30:23]add;
assign add[30:23]=X[30:23] + Y[30:23]
//Multiply the (23-bit) mantissas of X & Y. Along with the hidden 1 in each mantissa, this results in a 48-bit product.
logic [48:0]multi;
assign multi[48:0]=X[22:0] * Y[22:0];
//Round the 48-bit product by truncating the least significant 23-bits. You should be left with a 25-bit number; 2 hidden bits and 23 mantissa bits.
logic [24:0]round;
assign round[24:0]=muti[48:23]

if(round>1'b1) begin:
	assign E[30:23]=(round+1'b1)>>1
end 
else begin:
	assign result[22:0]=round[22:0]
end 

if(E==0 && M==0) begin:
	assign zero=1'b1;
	assign result=32'b0;
end
else if(E=EB && M!=0) begin:
	assign nan=1'b1;
	assign result[31]=1'b0;
	assign result[30:23]=EB;
	assign result[22:0]=23'b0;
end
else if(E==EB && M==0) begin:
	assign inf=1'b1;
	assign result[31]=1'b0;
	assign result[30:23]=EB;
	assign result[22:0]=23'b0;
end
else if(E<0) begin:
	assign underflow=1'b1;
	assign result[31]=1'b0;
	assign result[30:23]=8'b0;
	assign result[22:0]=23'b0;
end
else if(E>EB) begin:
	assign overflow=1'b1;
	assign result[31]=1'b0;
	assign result[30:23]=EB;
	assign result[22:0]=23'b0;
end
else begin:
	assign result[31]=1'b0;
	assign result[30:23]=EB;
	assign result[22:0]=23'b0;
end 

endmodule
