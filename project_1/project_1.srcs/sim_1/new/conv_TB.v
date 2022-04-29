`timescale 1ns / 1ps

module conv_TB #(parameter n_inputs = 2,parameter size = 32,DP=4);
reg [size*n_inputs-1:0] weights;
reg [size*n_inputs-1:0] data;
wire [size-1:0]  Out;
wire [2*size+n_inputs-2:0]  Temp;

Convolution #(.size(size),.n_inputs(n_inputs),.DP(DP)) u1(
.weights(weights),
.data  (data),
.Out    (Out),
.Temp (Temp)
);
initial begin

#10;
weights='b1111111111101101110010111001011000000011011011110100110110010011;
   data='b1111111100110101110111010110111011111110110101000111011111111100;
#10;
$display("%b",Out);
$display("%b",Temp);
$finish;
end
endmodule
