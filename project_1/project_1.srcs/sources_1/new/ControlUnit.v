`timescale 1ns / 1ps

module ControlUnit #(
        parameter 
        size = 16,
        FilterConv1No = 16,
        FilterConv1 = 16,
        MC1Depth = 3,   // 128/16
        MC2Depth = 6,  // Column in C2 log2(64)
        Conv1_Cycles = 119,
        Conv2_Cycles = 448,
        MemBlockCellNo = 8,
        MemBlockCellSize = 16, //bits
        Wr_MemBlkDepth = 6, // log2(56) 56==> no of memory cells
        r_MemBlkDepth = 3, //// log2(7) 7==> no of memory Rows
        BlkMemRows = 7,
        DeseMemDepth = 9
        )
        (
        input clk,reset,
        output reg ExtMode,EnR2,denseEnable,
        output reg[MC1Depth - 1:0] MC1_Address,
        output reg[MC2Depth - 1:0] MC2_Address,
        output reg [2:0] EnableBus, 
        output reg [Wr_MemBlkDepth - 1:0] Wr_MemBlk1_Address,
        output reg [Wr_MemBlkDepth - 1:0] Wr_MemBlk2_Address,
        output reg [Wr_MemBlkDepth - 1:0] Wr_MemBlk3_Address,
        output reg [r_MemBlkDepth - 1:0] r_MemBlk1_Address,
        output reg [r_MemBlkDepth - 1:0] r_MemBlk2_Address,
        output reg [r_MemBlkDepth - 1:0] r_MemBlk3_Address,
        output reg [DeseMemDepth - 1:0] r_Dese_Adress,
        output WC2EN
        );  
        
        reg [31:0] Counter1 = 0;
        
        integer Counter2 = 0;
        integer BlkCounter = 0;
        integer c = 0;
        
        reg [MC1Depth - 1:0]MC1_Depth = 'b1000;//--------//
        reg [MC2Depth - 1:0]MC2_Depth = 'b1000000;
        reg [Wr_MemBlkDepth - 1:0]MemBlk1_Depth = 'b111111;
        reg [Wr_MemBlkDepth - 1:0]MemBlk2_Depth = 'b111111;
        reg [Wr_MemBlkDepth - 1:0]MemBlk3_Depth = 'b111111;
        reg [r_MemBlkDepth - 1:0]r_MemBlk1_Depth = 'b111;
        reg [r_MemBlkDepth - 1:0]r_MemBlk2_Depth = 'b111;
        reg [r_MemBlkDepth - 1:0]r_MemBlk3_Depth = 'b111;
        reg Conv_mode;
        

        assign WC2EN = Counter1 >= Conv1_Cycles-1 ? 'b1:'b0;
        
        initial begin
        Conv_mode = 0;
        MC1_Address = 0;
        MC2_Address = {MC2Depth{1'b1}};
        EnableBus = 'b100;
        Wr_MemBlk1_Address = {Wr_MemBlkDepth{1'b1}};  //{Wr_MemBlkDepth{1'b1}}
        Wr_MemBlk2_Address = 0;
        Wr_MemBlk3_Address = 0;
        r_MemBlk1_Address = {r_MemBlkDepth{1'b1}};
        r_MemBlk2_Address = {r_MemBlkDepth{1'b1}};
        r_MemBlk3_Address = {r_MemBlkDepth{1'b1}};
        r_Dese_Adress = 0;
        denseEnable = 0;
        
        //#1;
        end
always@(posedge clk)begin
            if(reset == 1)begin
            Conv_mode = 0;
            MC1_Address = 0;
            MC2_Address = {MC2Depth{1'b1}};
            EnableBus = 'b000; ////////
            Wr_MemBlk1_Address = {Wr_MemBlkDepth{1'b1}};
            Wr_MemBlk2_Address = 0;
            Wr_MemBlk3_Address = 0;
            r_MemBlk1_Address = {r_MemBlkDepth{1'b1}};
            r_MemBlk2_Address = {r_MemBlkDepth{1'b1}};
            r_MemBlk3_Address = {r_MemBlkDepth{1'b1}};
            r_Dese_Adress = 0;
            denseEnable = 0;
            Counter1 = 0;
            Counter2 = 0;
            BlkCounter = 0;
            c = 0;
            
            end
            else begin
            if(Counter1 >= Conv1_Cycles)begin
                Conv_mode = 1;
                Counter2 <= Counter2 + 1;
                if(Counter2 == 0 || Counter2 == 1)begin
                    Wr_MemBlk3_Address = Wr_MemBlk3_Address + 'b1;
                    EnableBus = 'b001;
                end
         
                if(Counter2 == 2)begin
                    EnableBus = 'b000;
                    EnR2='b1;
                    end
                if(Counter2 >= 2)begin
                    denseEnable = 1;
                    r_Dese_Adress = r_Dese_Adress + 'b1;
                    end
                if(Counter2 >= Conv2_Cycles)begin
                    Counter2 = 0;
                    Conv_mode = 0;
                    Counter1 = 0;
                    Wr_MemBlk1_Address = 0;
                    Wr_MemBlk2_Address = 0;
                    Wr_MemBlk3_Address = 0;
                    r_Dese_Adress = 0;
                    EnableBus = 'b000; ///////
                end     
            end
            else begin
            Counter1 = Counter1 + 1;
            Conv_mode = 0;
            r_MemBlk1_Address = {r_MemBlkDepth{1'b1}};
            r_MemBlk2_Address = {r_MemBlkDepth{1'b1}};
            r_MemBlk3_Address = {r_MemBlkDepth{1'b1}};
            end 
             if(Conv_mode == 0)begin // Convolution-1 Mode ----------->
                //#0.1; //Possible Delay ??
                if(EnableBus == 'b000)///
                    EnableBus = 'b100;////
                MC1_Address = MC1_Address + 'b1;
                if(MC1_Address == MC1_Depth)
                    MC1_Address = 0;
                if(Counter1==2)
                    EnR2='b0;
                
                if(Counter1==3)
                        denseEnable='b0;
                
                if(Counter1 >= 2)begin // Assuming the right Cycle
                    BlkCounter <= BlkCounter + 1;
                    if(EnableBus == 'b100 || EnableBus == 'b101)
                        Wr_MemBlk1_Address = Wr_MemBlk1_Address + 'b1;
                    if(EnableBus == 'b010)
                        Wr_MemBlk2_Address = Wr_MemBlk2_Address + 'b1;
                    if(EnableBus == 'b001 || EnableBus == 'b101)begin
                        Wr_MemBlk3_Address = Wr_MemBlk3_Address + 'b1;
                    end
                    //#1 //Possible Delay ???
                    if(BlkCounter%8 == 0 && BlkCounter != 0)begin
                        
                        if(EnableBus == 'b100 || EnableBus == 'b101)begin
                            BlkCounter = 0;
                            EnableBus = 'b010;
                            c = c + 1;
                        end
                        else if(EnableBus == 'b010)begin
                            BlkCounter = 0;
                            if(c == BlkMemRows)begin
                            EnableBus = 'b001;
                            c = 0;
                            end
                            else EnableBus = 'b101;
                        end
                        else begin
                            BlkCounter = 0;
                            EnableBus = 'b101;                            
                        end
                    end
                end
             end
             else begin   // Convolution-2 Mode
             
             MC2_Address = MC2_Address + 'b1;
             if(MC2_Address == MC2_Depth)begin
                 MC2_Address = 0; 
             //#1 //Possible Delay
//                c = c + 1;
//                if(c == 2**MC2Depth)begin
//                c = 0;
                r_MemBlk1_Address = r_MemBlk1_Address + 'b1;
                r_MemBlk2_Address = r_MemBlk2_Address + 'b1;
                r_MemBlk3_Address = r_MemBlk3_Address + 'b1;
//                if(r_MemBlk1_Depth == r_MemBlk1_Address)begin
//                    r_MemBlk1_Address = 0;
//                    r_MemBlk2_Address = 0;
//                    r_MemBlk3_Address = 0;
//                end
//                end
                end
             end
      end
end
always@(negedge clk)begin
    ExtMode <= Conv_mode;
end
endmodule
