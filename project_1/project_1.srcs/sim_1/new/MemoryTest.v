`timescale 1ns / 1ps


module MemoryTest;
reg [8:0] counter = 0; 
reg clk = 1; 
wire [31:0] t5 ;

DenseW4 W4(.clka(clk),.addra(counter),.douta(t5));

initial begin

clk=1;
#1;
force clk=0;
#1;
force clk=1;
#10;
$display("%b",t5);
force clk=0;
#10;
force clk=1;

$finish;
end
endmodule
