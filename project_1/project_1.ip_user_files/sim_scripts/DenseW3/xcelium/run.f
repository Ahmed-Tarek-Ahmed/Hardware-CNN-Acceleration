-makelib xcelium_lib/xil_defaultlib -sv \
  "E:/Youssef/GraduationProject/Xilinix/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "E:/Youssef/GraduationProject/Xilinix/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/DenseW3/sim/DenseW3.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib
