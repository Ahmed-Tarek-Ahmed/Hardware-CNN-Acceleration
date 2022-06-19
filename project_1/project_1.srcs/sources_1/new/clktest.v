`timescale 1ns / 1ps



module clktest(
    input sysclk_p,sysclk_n,
    output [2:0] test
    );
    
     
      wire locked;
      wire INPUTCLK;
      wire res;     
      reg [30:0]counter=0;
      SystemClk SysClk
      (
      .sysclk_p(sysclk_p),
      .sysclk_n(sysclk_n),
      .dout(INPUTCLK)
      );
      

         always@(posedge INPUTCLK)begin
            counter=counter+'b1;
         end
         assign test[2]=counter>1000000000?0:1;
         assign test[1]='b1;
         assign test[0]='b0;
endmodule
