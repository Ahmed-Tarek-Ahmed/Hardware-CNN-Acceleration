`timescale 1ns / 1ps

module M_TB;
reg signed [4:0] A;
reg signed [4:0] B;
wire signed [9:0] O;

Multiplier #(.insize(5)) u1(
.A (A),
.B  (B),
.Out    (O)
);

initial begin
    $monitor ("a=%d b=%d o=%d ",A,B,O);
    A=0;
    B=0;
    #5 A=3.5;B=4;
    end
    

endmodule
