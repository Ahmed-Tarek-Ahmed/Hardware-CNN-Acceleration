// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Mon May 30 16:51:30 2022
// Host        : DESKTOP-PCIMVFJ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top MemBlk_2 -prefix
//               MemBlk_2_ MemBlk_1_stub.v
// Design      : MemBlk_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module MemBlk_2(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[5:0],dina[255:0],clkb,enb,addrb[2:0],doutb[2047:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [5:0]addra;
  input [255:0]dina;
  input clkb;
  input enb;
  input [2:0]addrb;
  output [2047:0]doutb;
endmodule
