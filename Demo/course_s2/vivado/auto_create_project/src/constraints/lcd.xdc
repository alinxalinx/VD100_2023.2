set_property PACKAGE_PIN F23 [get_ports {lcd_ref_clk_p}]
set_property IOSTANDARD LVDS15 [get_ports {lcd_ref_clk_p}]
create_clock -period 5.000 -name lcd_ref_clk_p -waveform {0.000 2.500} [get_ports lcd_ref_clk_p]

set_property DIFF_TERM_ADV TERM_100 [get_ports lcd_ref_clk_p]

set_property PACKAGE_PIN A23 [get_ports {clkout1_p[0]}]
#set_property PACKAGE_PIN A24 [get_ports {clkout1_n[0]}]
set_property IOSTANDARD LVDS15 [get_ports {clkout1_p[0]}]
#set_property IOSTANDARD LVDS15 [get_ports {clkout1_n[0]}]

set_property PACKAGE_PIN F22 [get_ports {dataout1_p_0[0]}]
#set_property PACKAGE_PIN G23 [get_ports {dataout1_n_0[0]}]

set_property PACKAGE_PIN A20 [get_ports {dataout1_p_1[0]}]
#set_property PACKAGE_PIN A21 [get_ports {dataout1_n_1[0]}]

set_property PACKAGE_PIN C22 [get_ports {dataout1_p_2[0]}]
#set_property PACKAGE_PIN B22 [get_ports {dataout1_n_2[0]}]

set_property PACKAGE_PIN A25 [get_ports {dataout1_p_3[0]}]
#set_property PACKAGE_PIN A26 [get_ports {dataout1_n_3[0]}]

set_property IOSTANDARD LVDS15 [get_ports {dataout1_p_*[0]}]
#set_property IOSTANDARD LVDS15 [get_ports {dataout1_n[*]}]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lcd/tx_clkgen/pll_clkout0]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lcd/tx_clkgen/clkoutphy_out]

set_property PACKAGE_PIN E27 [get_ports {lcd_resetb}]
set_property IOSTANDARD LVCMOS15 [get_ports {lcd_resetb}]

set_property PACKAGE_PIN E24 [get_ports {lcd_en[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {lcd_en[0]}]
set_property PACKAGE_PIN D24 [get_ports {lcd_sync[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {lcd_sync[0]}]

#set_property PACKAGE_PIN E22 [get_ports {lcd_i2c_scl_io}]
#set_property IOSTANDARD LVCMOS15 [get_ports {lcd_i2c_scl_io}]
#set_property PACKAGE_PIN H24 [get_ports {lcd_i2c_sda_io}]
#set_property IOSTANDARD LVCMOS15 [get_ports {lcd_i2c_sda_io}]

#set_property PULLUP true [get_ports lcd_i2c_scl_io]
#set_property PULLUP true [get_ports lcd_i2c_sda_io]

set_property PACKAGE_PIN C24 [get_ports {lcd_pwm}]
set_property IOSTANDARD LVCMOS15 [get_ports {lcd_pwm}]

#set_false_path -to [get_pins {lcd/tx_channel1/tx_enable_sync_reg[*]/CLR}]
#set_false_path -to [get_pins {lcd/tx_channel1/txc_piso/tx_data_reg[*]/D}]
#set_false_path -to [get_pins {lcd/tx_channel1/txc_piso/rd_last_reg[*]/D}]
#set_false_path -to [get_pins {lcd/tx_channel1/txd[*].piso/tx_data_reg[*]/D}]
#set_false_path -to [get_pins {lcd/tx_channel1/txd[*].piso/rd_last_reg[*]/D}]