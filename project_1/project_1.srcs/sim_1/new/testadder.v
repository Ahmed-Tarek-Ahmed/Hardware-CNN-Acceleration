`timescale 1ns / 1ps


module testadder;

reg [11:0] in1;
wire [2:0] o;

AdderTree #(.n(4),.size(3)) T (.in(in1),.out(o));

initial 
begin
in1 = 'b010010111111;
#1



$finish;
end

endmodule
