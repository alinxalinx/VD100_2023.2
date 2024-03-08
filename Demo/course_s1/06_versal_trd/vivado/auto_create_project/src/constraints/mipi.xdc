set_property PACKAGE_PIN G26 [get_ports {cam1_gpio[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {cam1_gpio[0]}]
set_property PULLUP true [get_ports {cam1_gpio[0]}]

set_property PACKAGE_PIN G27  [get_ports cam1_i2c_scl_io]
set_property PACKAGE_PIN F28 [get_ports cam1_i2c_sda_io]

set_property IOSTANDARD LVCMOS15 [get_ports cam1_i2c_scl_io]
set_property IOSTANDARD LVCMOS15 [get_ports cam1_i2c_sda_io]


set_property PULLUP true [get_ports cam1_i2c_scl_io]
set_property PULLUP true [get_ports cam1_i2c_sda_io]


set_property PACKAGE_PIN H28 [get_ports {cam2_gpio[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {cam2_gpio[0]}]
set_property PULLUP true [get_ports {cam2_gpio[0]}]

set_property PACKAGE_PIN D27  [get_ports cam2_i2c_scl_io]
set_property PACKAGE_PIN C28 [get_ports cam2_i2c_sda_io]

set_property IOSTANDARD LVCMOS15 [get_ports cam2_i2c_scl_io]
set_property IOSTANDARD LVCMOS15 [get_ports cam2_i2c_sda_io]


set_property PULLUP true [get_ports cam2_i2c_scl_io]
set_property PULLUP true [get_ports cam2_i2c_sda_io]

#bank 702 N4N5
set_property PACKAGE_PIN U23 [get_ports mipi_phy_if_0_clk_p]
set_property PACKAGE_PIN T23 [get_ports mipi_phy_if_0_data_p[0]]
set_property PACKAGE_PIN R23 [get_ports mipi_phy_if_0_data_p[1]]
set_property PACKAGE_PIN L23 [get_ports mipi_phy_if_0_data_p[2]]
set_property PACKAGE_PIN M22 [get_ports mipi_phy_if_0_data_p[3]]

set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_p[0]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_n[0]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_p[1]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_n[1]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_p[2]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_n[2]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_p[3]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_n[3]]

#bank 702 N6N7
set_property PACKAGE_PIN V21 [get_ports mipi_phy_if_1_clk_p]
set_property PACKAGE_PIN T21 [get_ports mipi_phy_if_1_data_p[0]]
set_property PACKAGE_PIN R21 [get_ports mipi_phy_if_1_data_p[1]]
set_property PACKAGE_PIN N21 [get_ports mipi_phy_if_1_data_p[2]]
set_property PACKAGE_PIN K21 [get_ports mipi_phy_if_1_data_p[3]]

set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_p[0]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_n[0]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_p[1]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_n[1]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_p[2]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_n[2]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_p[3]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_n[3]]


set_property CLOCK_REGION X3Y0 [get_cells -hier -filter {name =~ *mipi_csi2_rx_subsyst_1/inst/phy/inst/inst/rxbyteclkhs_buf}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hier -filter {name =~ *mipi_csi2_rx_subsyst_0/inst/phy/inst/inst/*/inst/BANK_WRAPPER_INST0/fifo_wr_clk[0]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets -hier -filter {name =~ *mipi_csi2_rx_subsyst_1/inst/phy/inst/inst/*/inst/BANK_WRAPPER_INST0/fifo_wr_clk[0]}]


#set_property CLOCK_DEDICATED_ROUTE ANY_CMT_REGION [get_nets design_1_i/gmii_to_rgmii_0/U0/i_gmii_to_rgmii_block/gmii_clk_25m_or_2_5m_90]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/clk_wizard_0/inst/clock_primitive_inst/clkout1_primitive]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/clk_wizard_0/inst/clock_primitive_inst/clkout3_primitive]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/gmii_to_rgmii_0/U0/i_design_1_gmii_to_rgmii_0_0_clocking/gmii_clk_125m_out]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/gmii_to_rgmii_0/U0/i_design_1_gmii_to_rgmii_0_0_clocking/gmii_clk_125m_90_out]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/gmii_to_rgmii_0/U0/i_design_1_gmii_to_rgmii_0_0_clocking/gmii_clk_25m_90_out]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/gmii_to_rgmii_0/U0/i_design_1_gmii_to_rgmii_0_0_clocking/gmii_clk_25m_out]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/gmii_to_rgmii_0/U0/i_design_1_gmii_to_rgmii_0_0_clocking/clk_10_90]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/gmii_to_rgmii_0/U0/i_design_1_gmii_to_rgmii_0_0_clocking/clk_10]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ps_block/design_1_i/mipi_csi2_rx_subsyst_0/inst/phy/inst/inst/bd_d10d_phy_0_rx_support_i/slave_rx.bd_d10d_phy_0_rx_clock_module_support_i/bd_d10d_phy_0_clock_module_rx_i/inst/clock_primitive_inst/clkout1_primitive]


#set_property CLOCK_REGION X3Y0 [get_cells -hier -filter {name =~ *mipi_dphy_1/inst/inst/rxbyteclkhs_buf}]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ps_block/design_1_i/mipi_dphy_0/inst/inst/design_1_mipi_dphy_0_0_rx_support_i/slave_rx.design_1_mipi_dphy_0_0_rx_hssio_i/inst/design_1_mipi_dphy_0_0_io_wiz_rx_phy_i/inst/BANK_WRAPPER_INST0/fifo_wr_clk[0]]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ps_block/design_1_i/mipi_dphy_1/inst/inst/slave_rx.design_1_mipi_dphy_0_1_rx_hssio_i/inst/design_1_mipi_dphy_0_1_io_wiz_rx_phy_i/inst/BANK_WRAPPER_INST0/fifo_wr_clk[0]]
