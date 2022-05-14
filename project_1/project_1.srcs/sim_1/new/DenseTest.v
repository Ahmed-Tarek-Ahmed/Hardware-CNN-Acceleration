`timescale 1ns / 1ps


module DenseTest;
wire [31:0]Input=1;
reg  clock=1;
wire enable=0;
wire [159:0] Output;
wire [31:0] ttt;
wire [31:0] temp;
wire [31:0] sum;

Dense_Seq #(32) A(Input,enable,clock,Output);
integer i;

initial 
begin
#1;
clock=0;
force enable=1;
#1;
for (i=0;i<448;i=i+1) begin
clock=1;
#1;
clock=0;
#1;

end
$display("%b",Output[159:0]);
$finish;
end
endmodule
