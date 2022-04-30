`timescale 1ns / 1ps

module conv_TB #(parameter n_inputs = 1,parameter size = 32,DP=4,SL=2);
reg [size*n_inputs-1:0] weights;
reg [size*n_inputs-1:0] data;
wire [size-1:0]  Out;
wire [2*size+n_inputs-2:0]  Temp;

Convolution #(.size(size),.n_inputs(n_inputs),.DP(DP),.SL(SL)) u1(
.weights(weights),
.data  (data),
.Out    (Out),
.Temp (Temp)
);
initial begin

#10;
weights='b11011110110101000111011111111100;
   data='b10101110000001111010010001100101;
#10;
$display("%b",Out);
$display("%b",Temp);
$finish;
end
endmodule
