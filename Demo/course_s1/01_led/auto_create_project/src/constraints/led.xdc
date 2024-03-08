set_property PACKAGE_PIN AB23 [get_ports sys_clk_p]
set_property PACKAGE_PIN F21 [get_ports rst_n]
set_property PACKAGE_PIN E20 [get_ports led]
set_property IOSTANDARD LVCMOS15 [get_ports led]
set_property IOSTANDARD LVCMOS15 [get_ports rst_n]
set_property IOSTANDARD LVDS15 [get_ports sys_clk_p]

create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]