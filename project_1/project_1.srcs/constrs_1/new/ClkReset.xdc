set_property PACKAGE_PIN AR40 [get_ports reset]


set_property PACKAGE_PIN AM39 [get_ports {class[2]}]
set_property PACKAGE_PIN AN39 [get_ports {class[1]}]
set_property PACKAGE_PIN AR37 [get_ports {class[0]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets reset_IBUF]



set_property IOSTANDARD LVCMOS18 [get_ports {class[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {class[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {class[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports reset]


create_clock -period 5.000 -name sysclk_p [get_ports sysclk_p]
set_property PACKAGE_PIN H19 [get_ports sysclk_p]
set_property PACKAGE_PIN G18 [get_ports sysclk_n]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sysclk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sysclk_n]


