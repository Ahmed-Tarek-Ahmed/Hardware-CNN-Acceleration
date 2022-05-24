`timescale 1ns / 1ps


module Class#(parameter insize = 32,parameter outsize = 3)(
    input [insize*5-1:0] INPUT,
    output reg [outsize-1:0] Out
    );
    
    
 reg [outsize+insize-1:0] temp1,temp2,temp3;   
    
always@*
     begin
     
     
     if ($signed(INPUT[insize-1:0])>$signed(INPUT[2*insize-1:insize]))
         begin
         temp1={3'b000,INPUT[insize-1:0]};
      end
      else begin
         temp1={3'b001,INPUT[2*insize-1:insize]};
      end
      
      
      if ($signed(INPUT[3*insize-1:2*insize])>$signed(INPUT[4*insize-1:3*insize]))
        begin
          temp2={3'b010,INPUT[3*insize-1:2*insize]};
        end
       else begin
          temp2={3'b011,INPUT[4*insize-1:3*insize]};
       end
    
     if ($signed(temp1[insize-1:0])>$signed(temp2[insize-1:0]))
    begin
        temp3 = temp1;
    end
    else begin
    temp3 = temp2;
    end
    
    if($signed(temp3[insize-1:0])>$signed(INPUT[5*insize-1:insize*4]))
    begin
    
    Out = temp3[outsize+insize-1:insize];
    
    end
    else begin
    Out = 'b100;
    end
    
    
    
   end 
endmodule