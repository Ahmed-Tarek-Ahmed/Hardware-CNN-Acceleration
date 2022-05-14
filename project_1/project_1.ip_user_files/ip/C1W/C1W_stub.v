// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat May 14 18:00:52 2022
// Host        : Ahmed running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/University/gp/GITverilog/Hardware-CNN-Acceleration-/project_1/project_1.srcs/sources_1/ip/C1W/C1W_stub.v
// Design      : C1W
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module C1W(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[6:0],douta[511:0]" */;
  input clka;
  input [6:0]addra;
  output [511:0]douta;
endmodule
