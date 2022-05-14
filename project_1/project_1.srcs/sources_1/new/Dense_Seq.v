`timescale 1ns / 1ps


module Dense_Seq#(parameter Input_size = 32)(
input [Input_size-1:0] In,
input enable,
input clk,

output [Input_size*5-1:0] Out);

reg  signed [Input_size-1:0] Sum1;
reg  signed [Input_size-1:0] Sum2;
reg  signed [Input_size-1:0] Sum3;
reg  signed [Input_size-1:0] Sum4;
reg  signed [Input_size-1:0] Sum5;
reg  [8:0] counter = 0; 
reg  signed [Input_size-1:0] temp1;
reg  signed [Input_size-1:0] temp2;
reg  signed [Input_size-1:0] temp3;
reg  signed [Input_size-1:0] temp4;
reg  signed [Input_size-1:0] temp5;

wire signed [Input_size-1:0] t1;
wire signed [Input_size-1:0] t2;
wire signed [Input_size-1:0] t3;
wire signed [Input_size-1:0] t4;
wire signed [Input_size-1:0] t5;

assign Out={Sum1,Sum2,Sum3,Sum4,Sum5};
DenseW0 W0(.clka(clk),.addra(counter),.douta(t1));
DenseW1 W1(.clka(clk),.addra(counter),.douta(t2));
DenseW2 W2(.clka(clk),.addra(counter),.douta(t3));
DenseW3 W3(.clka(clk),.addra(counter),.douta(t4));
DenseW4 W4(.clka(clk),.addra(counter),.douta(t5));

initial begin
Sum1 = 0;
Sum2 = 0;
Sum3 = 0;
Sum4 = 0;
Sum5 = 0;
end

always@(negedge clk)
begin
if (enable == 1)begin

temp1 = t1 * In;
temp2 = t2 * In;
temp3 = t3 * In;
temp4 = t4 * In;
temp5 = t5 * In;
Sum1 = Sum1+temp1;
Sum2 = Sum2+temp2;
Sum3 = Sum3+temp3;
Sum4 = Sum4+temp4;
Sum5 = Sum5+temp5;

counter = counter+1;
end
end

endmodule
