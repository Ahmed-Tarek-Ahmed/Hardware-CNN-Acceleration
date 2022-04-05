`timescale 1ns / 1ps

module conv_TB #(parameter n_inputs = 2,parameter size = 4);
reg [size*n_inputs-1:0] weights;
reg [size*n_inputs-1:0] data;
wire [2*size+n_inputs-2:0]  Out;
Convolution #(.size(size),.n_inputs(n_inputs)) u1(
.weights(weights),
.data  (data),
.Out    (Out)
);
initial begin

#10;
weights='b01100110;
data='b10111011;
#10;
$finish;
end
endmodule
