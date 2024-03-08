set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

set_property PACKAGE_PIN F23 [get_ports {sys_clk_p}]
set_property IOSTANDARD LVDS15 [get_ports {sys_clk_p}]
create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]

set_property DIFF_TERM_ADV TERM_100 [get_ports sys_clk_p]

set_property PACKAGE_PIN A23 [get_ports {clkout1_p[0]}]
set_property IOSTANDARD LVDS15 [get_ports {clkout1_p[0]}]
set_property PACKAGE_PIN F22 [get_ports {dataout1_p_0[0]}]
set_property PACKAGE_PIN A20 [get_ports {dataout1_p_1[0]}]
set_property PACKAGE_PIN C22 [get_ports {dataout1_p_2[0]}]
set_property PACKAGE_PIN A25 [get_ports {dataout1_p_3[0]}]
set_property IOSTANDARD LVDS15 [get_ports {dataout1_p_*[0]}]




set_property PACKAGE_PIN E24 [get_ports {lcd_en}]
set_property IOSTANDARD LVCMOS15 [get_ports {lcd_en}]
set_property PACKAGE_PIN D24 [get_ports {lcd_sync}]
set_property IOSTANDARD LVCMOS15 [get_ports {lcd_sync}]

