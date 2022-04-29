`timescale 1ns / 1ps



module MaxPoolUnit
   #(parameter In_size = 3,n_inputs = 2)
    (
    input [In_size*n_inputs - 1:0] in,
    output reg signed [In_size -1 :0] Out
    );
   integer i;
   reg signed [In_size - 1:0] temp;
   reg signed [In_size - 1:0] temp2;
   always @(in) begin
   temp = in[In_size - 1:0];
   temp2 = in[2*In_size-1:In_size];
        Out = temp > temp2 ? temp:temp2;
   if(Out < 0)
      Out = 0;
   end
endmodule
