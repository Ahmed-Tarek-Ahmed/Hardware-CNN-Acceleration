set_property SRC_FILE_INFO {cfile:{d:/work/college/5-Senior 2/Semester 2/Graduation Project 2/GP Codes/Hardware-CNN-Acceleration-/project_1/project_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc} rfile:../project_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:instance_name/inst} [current_design]
set_property SRC_FILE_INFO {cfile:{D:/work/college/5-Senior 2/Semester 2/Graduation Project 2/GP Codes/Hardware-CNN-Acceleration-/project_1/project_1.srcs/constrs_1/new/ClkReset.xdc} rfile:../project_1.srcs/constrs_1/new/ClkReset.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.05
set_property src_info {type:XDC file:2 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets reset_IBUF]
