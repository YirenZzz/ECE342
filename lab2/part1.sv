/*******************************************************/
/********************Multiplier module********************/
/*****************************************************/
// add additional modules as needs, such as full adder, and others

// multiplier module
module mult
(
	input [7:0] x, //m
	input [7:0] y, //q
	output [15:0] out,   // Result of the multiplication
	output [15:0] pp [9] // for automarker to check partial products of a multiplication 
);
	// Declare a 9-high, 16-deep array of signals holding sums of the partial products.
	// They represent the _input_ partial sums for that row, coming from above.
	// The input for thge "ninth row" is actually the final multiplier output.
	// The first row is tied to 0.
	assign pp[0] = '0;
	
	// Make another array to hold the carry signals
	logic [16:0] cin[9];
	assign cin[0] = '0;
	
	// Cin signals for the final (fast adder) row
	logic [16:8] cin_final;
	assign cin_final[8] = '0;
	
	// TODO: complete the following digital logic design of a carry save multiplier (unsigned)
	// Note: generate_hw tutorial can help you describe duplicated modules efficiently
	
	// Note: partial product of each row is the result coming out from a full adder at the end of that row
	
	// Note: a "Fast adder" operates on columns 8 through 15 of final row.
	logic [15:0]sum[9];
	assign sum[0] = '0;

	genvar i, j;
	generate
		for (i=0; i<8 ; i++) begin: partial_row
			for (j=0; j<8 ; j++) begin: partial_column
				logic xy;
				assign xy=x[j] & y[i];
				if(j==7) begin
					assign sum[i][j+1]=1'b0;
				end
				full_adder FA(
					.a(sum[i][j+1]), 
					.b(xy),
					.cin(cin[i][j]), 
					.cout(cin[i+1][j]), 
					.s(sum[i+1][j])
				);
			end
			if(i==0) begin
				assign pp[i+1][7:0]=sum[i+1][7:0];
				assign pp[i+1][15:8]=1'b0;
			end
			else begin
				assign pp[i+1][i-1:0]=pp[i][i-1:0];
				assign pp[i+1][i+7:i]=sum[i+1][7:0];
				assign pp[i+1][15:i+8]=1'b0;
			end 

		end
	endgenerate
	assign out[7:0] = pp[8][7:0];
    fast_adder fa
    (
		.a(pp[8][15:8]),        
        .b(cin[8][7:0]),
        .cin_f(1'b0),
        .cout(cin[8][16]),
        .s(out[15:8])
    );
		  
endmodule

// The following code is provided for you to use in your design

module full_adder(
    input a,
    input b,
    input cin,
    output cout,
    output s
);

assign s = a ^ b ^ cin;
assign cout = a & b | (cin & (a ^ b));

endmodule


module fast_adder 
(
    input [7:0] a,
    input [7:0] b,
    input cin_f,
    output logic cout,
    output logic [7: 0] s
);
    logic [7: 0] g;
	logic [7:0] p;
    logic [8: 0] c;
	assign c[0] = cin_f;
    assign cout = c[8];
    
	genvar i;
    generate 
        for (i = 0; i < 8; i++) begin : adder_row
		//equation reference from wiki 
            assign g[i] = a[i] & b[i];//Gi=AixBi
            assign p[i] = a[i] | b[i];//Pi=Ai+Bi
            assign c[i + 1] = g[i] | (p[i] & c[i]); //C[i+1]=Gi+(PixCi)
            assign s[i] =  a[i] ^ b[i] ^ c[i];
        end
    endgenerate

endmodule
