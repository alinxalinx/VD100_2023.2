# Hierarchical cell: lcd_lvds_group
proc create_hier_cell_lcd_lvds_group { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_lcd_lvds_group() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lcd_ref

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:vid_io_rtl:1.0 lcd_vid_io


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 Data_pins_0_p_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_0_n_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_1_p_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_1_n_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_2_p_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_2_n_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_3_p_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_3_n_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_4_p_0
  create_bd_pin -dir O -from 0 -to 0 Data_pins_4_n_0
  create_bd_pin -dir O lcd_pclk

  # Create instance: constant_gnd, and set properties
  set constant_gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_gnd ]
  set_property CONFIG.CONST_VAL {0} $constant_gnd


  # Create instance: util_ds_buf_1, and set properties
  set util_ds_buf_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_1 ]

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_0


  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_1


  # Create instance: constant_vcc, and set properties
  set constant_vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_vcc ]

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {3} \
    CONFIG.DIN_WIDTH {16} \
    CONFIG.DOUT_WIDTH {4} \
  ] $xlslice_4


  # Create instance: advanced_io_wizard_0, and set properties
  set advanced_io_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:advanced_io_wizard:1.0 advanced_io_wizard_0 ]
  set_property -dict [list \
    CONFIG.BUS0_DIR {TX} \
    CONFIG.BUS0_IO_TYPE {DIFF} \
    CONFIG.BUS0_SIG_TYPE {Clk Fwd} \
    CONFIG.BUS1_DIR {TX} \
    CONFIG.BUS1_IO_TYPE {DIFF} \
    CONFIG.BUS1_NUM_PINS {1} \
    CONFIG.BUS2_DIR {TX} \
    CONFIG.BUS2_IO_TYPE {DIFF} \
    CONFIG.BUS3_DIR {TX} \
    CONFIG.BUS3_IO_TYPE {DIFF} \
    CONFIG.BUS4_DIR {TX} \
    CONFIG.BUS4_IO_TYPE {DIFF} \
    CONFIG.BUS_DIR {0} \
    CONFIG.BUS_IOTYPE {2} \
    CONFIG.DATA_SPEED {700} \
    CONFIG.DIFF_IO_STD {DIFF_SSTL12} \
    CONFIG.INPUT_CLK_FREQ {200.000} \
    CONFIG.PLL_IN_CORE {0} \
    CONFIG.TX_SERIALIZATION_FACTOR {4} \
  ] $advanced_io_wizard_0


  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {7} \
    CONFIG.DIN_TO {4} \
    CONFIG.DIN_WIDTH {16} \
    CONFIG.DOUT_WIDTH {4} \
  ] $xlslice_5


  # Create instance: lcd_lvds_0, and set properties
  set lcd_lvds_0 [ create_bd_cell -type ip -vlnv user.org:user:lcd_lvds:1.0 lcd_lvds_0 ]

  # Create instance: xlslice_7, and set properties
  set xlslice_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_7 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {15} \
    CONFIG.DIN_TO {12} \
    CONFIG.DIN_WIDTH {16} \
    CONFIG.DOUT_WIDTH {4} \
  ] $xlslice_7


  # Create instance: xlslice_6, and set properties
  set xlslice_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_6 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {11} \
    CONFIG.DIN_TO {8} \
    CONFIG.DIN_WIDTH {16} \
    CONFIG.DOUT_WIDTH {4} \
  ] $xlslice_6


  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_2 [get_bd_intf_pins lcd_ref] [get_bd_intf_pins util_ds_buf_1/CLK_IN_D]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins lcd_vid_io] [get_bd_intf_pins lcd_lvds_0/lcd_vid_io]

  # Create port connections
  connect_bd_net -net advanced_io_wizard_0_Data_pins_0_n [get_bd_pins advanced_io_wizard_0/Data_pins_0_n] [get_bd_pins Data_pins_0_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_0_p [get_bd_pins advanced_io_wizard_0/Data_pins_0_p] [get_bd_pins Data_pins_0_p_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_1_n [get_bd_pins advanced_io_wizard_0/Data_pins_1_n] [get_bd_pins Data_pins_1_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_1_p [get_bd_pins advanced_io_wizard_0/Data_pins_1_p] [get_bd_pins Data_pins_1_p_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_2_n [get_bd_pins advanced_io_wizard_0/Data_pins_2_n] [get_bd_pins Data_pins_2_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_2_p [get_bd_pins advanced_io_wizard_0/Data_pins_2_p] [get_bd_pins Data_pins_2_p_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_3_n [get_bd_pins advanced_io_wizard_0/Data_pins_3_n] [get_bd_pins Data_pins_3_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_3_p [get_bd_pins advanced_io_wizard_0/Data_pins_3_p] [get_bd_pins Data_pins_3_p_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_4_n [get_bd_pins advanced_io_wizard_0/Data_pins_4_n] [get_bd_pins Data_pins_4_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_4_p [get_bd_pins advanced_io_wizard_0/Data_pins_4_p] [get_bd_pins Data_pins_4_p_0]
  connect_bd_net -net advanced_io_wizard_0_intf_rdy [get_bd_pins advanced_io_wizard_0/intf_rdy] [get_bd_pins lcd_lvds_0/intf_rdy]
  connect_bd_net -net advanced_io_wizard_0_shared_pll_clkoutphyen_out [get_bd_pins advanced_io_wizard_0/shared_pll_clkoutphyen_out] [get_bd_pins lcd_lvds_0/clkoutphyen]
  connect_bd_net -net lcd_clk_1 [get_bd_pins lcd_lvds_0/lcd_pclk] [get_bd_pins lcd_pclk]
  connect_bd_net -net lcd_lvds_0_parallel_clk [get_bd_pins lcd_lvds_0/parallel_clk] [get_bd_pins advanced_io_wizard_0/ctrl_clk] [get_bd_pins advanced_io_wizard_0/parallel_clk]
  connect_bd_net -net lcd_lvds_0_pll_clkoutphy_in [get_bd_pins lcd_lvds_0/pll_clkoutphy_in] [get_bd_pins advanced_io_wizard_0/shared_bank0_pll_clkoutphy_in]
  connect_bd_net -net lcd_lvds_0_tx_clk_data [get_bd_pins lcd_lvds_0/tx_clk_data] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_0]
  connect_bd_net -net lcd_lvds_0_tx_data [get_bd_pins lcd_lvds_0/tx_data] [get_bd_pins xlslice_4/Din] [get_bd_pins xlslice_5/Din] [get_bd_pins xlslice_6/Din] [get_bd_pins xlslice_7/Din]
  connect_bd_net -net lcd_lvds_0_tx_enable [get_bd_pins lcd_lvds_0/tx_enable] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net lcd_lvds_0_tx_locked [get_bd_pins lcd_lvds_0/tx_locked] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins advanced_io_wizard_0/shared_bank0_pll_locked_in]
  connect_bd_net -net util_ds_buf_1_IBUF_OUT [get_bd_pins util_ds_buf_1/IBUF_OUT] [get_bd_pins lcd_lvds_0/tx_refclk]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res] [get_bd_pins lcd_lvds_0/tx_reset]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_1/Res] [get_bd_pins advanced_io_wizard_0/rst]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins constant_gnd/dout] [get_bd_pins lcd_lvds_0/mode] [get_bd_pins advanced_io_wizard_0/t_Data_pins_0] [get_bd_pins advanced_io_wizard_0/t_Data_pins_1] [get_bd_pins advanced_io_wizard_0/t_Data_pins_2] [get_bd_pins advanced_io_wizard_0/t_Data_pins_3] [get_bd_pins advanced_io_wizard_0/t_Data_pins_4]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins constant_vcc/dout] [get_bd_pins advanced_io_wizard_0/en_vtc]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins xlslice_4/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_1]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins xlslice_5/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_2]
  connect_bd_net -net xlslice_6_Dout [get_bd_pins xlslice_6/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_3]
  connect_bd_net -net xlslice_7_Dout [get_bd_pins xlslice_7/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_4]

  # Restore current instance
  current_bd_instance $oldCurInst
}
  # Create interface ports
  set DDR4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 DDR4 ]

  set sys [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys

  set mipi_phy_if_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0 ]

  set cam1_i2c [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 cam1_i2c ]

  set cam2_i2c [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 cam2_i2c ]

  set lcd_ref [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lcd_ref ]

  set mdio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio ]

  set rgmii [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii ]

  set mipi_phy_if_1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_1 ]

  set pl_led [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 pl_led ]

  set pl_key [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 pl_key ]


  # Create ports
  set cam1_gpio [ create_bd_port -dir O -from 0 -to 0 cam1_gpio ]
  set cam2_gpio [ create_bd_port -dir O -from 0 -to 0 cam2_gpio ]
  set dataout1_p_1 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_1 ]
  set dataout1_n_0 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_0 ]
  set dataout1_p_0 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_0 ]
  set dataout1_p_3 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_3 ]
  set dataout1_n_2 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_2 ]
  set dataout1_p_2 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_2 ]
  set clkout1_n [ create_bd_port -dir O -from 0 -to 0 clkout1_n ]
  set clkout1_p [ create_bd_port -dir O -from 0 -to 0 clkout1_p ]
  set dataout1_n_1 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_1 ]
  set dataout1_n_3 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_3 ]
  set lcd_en [ create_bd_port -dir O -from 0 -to 0 -type data lcd_en ]
  set lcd_sync [ create_bd_port -dir O -from 0 -to 0 -type data lcd_sync ]
  set phy_reset_n [ create_bd_port -dir O -from 0 -to 0 -type rst phy_reset_n ]
  
  # Create instance: axi_noc_0, and set properties
  set axi_noc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc:1.0 axi_noc_0 ]
  set_property -dict [list \
    CONFIG.CONTROLLERTYPE {DDR4_SDRAM} \
    CONFIG.MC_CASLATENCY {22} \
    CONFIG.MC_CHAN_REGION1 {NONE} \
    CONFIG.MC_COMPONENT_WIDTH {x16} \
    CONFIG.MC_ECC_SCRUB_SIZE {4096} \
    CONFIG.MC_EN_INTR_RESP {TRUE} \
    CONFIG.MC_F1_TFAW {30000} \
    CONFIG.MC_F1_TFAWMIN {30000} \
    CONFIG.MC_F1_TRCD {13750} \
    CONFIG.MC_F1_TRCDMIN {13750} \
    CONFIG.MC_F1_TRRD_L {11} \
    CONFIG.MC_F1_TRRD_L_MIN {11} \
    CONFIG.MC_F1_TRRD_S {9} \
    CONFIG.MC_F1_TRRD_S_MIN {9} \
    CONFIG.MC_INPUTCLK0_PERIOD {5000} \
    CONFIG.MC_MEMORY_SPEEDGRADE {DDR4-3200AA(22-22-22)} \
    CONFIG.MC_SYSTEM_CLOCK {No_Buffer} \
    CONFIG.MC_TFAW {30000} \
    CONFIG.MC_TFAWMIN {30000} \
    CONFIG.MC_TRC {45750} \
    CONFIG.MC_TRCD {13750} \
    CONFIG.MC_TRCDMIN {13750} \
    CONFIG.MC_TRCMIN {45750} \
    CONFIG.MC_TRP {13750} \
    CONFIG.MC_TRPMIN {13750} \
    CONFIG.MC_TRRD_L {11} \
    CONFIG.MC_TRRD_L_MIN {11} \
    CONFIG.MC_TRRD_S {9} \
    CONFIG.MC_TRRD_S_MIN {9} \
    CONFIG.MC_USER_DEFINED_ADDRESS_MAP {16RA-2BA-1BG-10CA} \
    CONFIG.NUM_CLKS {7} \
    CONFIG.NUM_MC {1} \
    CONFIG.NUM_MCP {4} \
    CONFIG.NUM_MI {0} \
    CONFIG.NUM_SI {9} \
  ] $axi_noc_0


  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {MC_3 {read_bw {4096} write_bw {4096} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /axi_noc_0/S00_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {MC_2 {read_bw {4096} write_bw {4096} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /axi_noc_0/S01_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {MC_0 {read_bw {4096} write_bw {4096} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /axi_noc_0/S02_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {MC_1 {read_bw {4096} write_bw {4096} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /axi_noc_0/S03_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {MC_3 {read_bw {500} write_bw {500} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_rpu} \
 ] [get_bd_intf_pins /axi_noc_0/S04_AXI]

  set_property -dict [ list \
   CONFIG.REGION {0} \
   CONFIG.CONNECTIONS {MC_2 {read_bw {500} write_bw {500} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_pmc} \
 ] [get_bd_intf_pins /axi_noc_0/S05_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {MC_0 {read_bw {500} write_bw {500} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /axi_noc_0/S06_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {MC_1 {read_bw {500} write_bw {500} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /axi_noc_0/S07_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {MC_2 {read_bw {500} write_bw {500} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /axi_noc_0/S08_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S01_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S02_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S03_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S04_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S05_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk5]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S06_AXI:S07_AXI:S08_AXI} \
 ] [get_bd_pins /axi_noc_0/aclk6]

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.4 mipi_csi2_rx_subsyst_0 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {4} \
    CONFIG.CMN_NUM_PIXELS {4} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_CONTROLLER_REG_IF {true} \
    CONFIG.C_DPHY_LANES {4} \
    CONFIG.C_HS_SETTLE_NS {145} \
    CONFIG.DPY_LINE_RATE {1000} \
    CONFIG.SupportLevel {1} \
    CONFIG.VFB_TU_WIDTH {96} \
  ] $mipi_csi2_rx_subsyst_0


  # Create instance: clk_wizard_0, and set properties
  set clk_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard:1.0 clk_wizard_0 ]
  set_property -dict [list \
    CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
    CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
    CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
    CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
    CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
    CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
    CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {300.000,200.000,150.000,125.000,100.000,100.000,100.000} \
    CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
    CONFIG.CLKOUT_USED {true,true,true,true,false,false,false} \
    CONFIG.PRIM_IN_FREQ {200.000} \
    CONFIG.PRIM_SOURCE {No_buffer} \
  ] $clk_wizard_0


  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [list \
    CONFIG.NUM_MI {12} \
    CONFIG.NUM_SI {1} \
  ] $axi_smc


  # Create instance: rst_clk_wizard_0_150M, and set properties
  set rst_clk_wizard_0_150M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wizard_0_150M ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {1} \
    CONFIG.DIN_TO {1} \
  ] $xlslice_1


  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [list \
    CONFIG.C_HAS_ASYNC_CLK {1} \
    CONFIG.C_VTG_MASTER_SLAVE {1} \
  ] $v_axi4s_vid_out_0


  # Create instance: lcd_lvds_group
  create_hier_cell_lcd_lvds_group [current_bd_instance .] lcd_lvds_group

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.2 v_tc_0 ]
  set_property CONFIG.enable_detection {false} $v_tc_0


  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_0 ]
  set_property -dict [list \
    CONFIG.c_include_mm2s_dre {1} \
    CONFIG.c_include_s2mm {0} \
    CONFIG.c_m_axis_mm2s_tdata_width {24} \
    CONFIG.c_mm2s_max_burst_length {32} \
  ] $axi_vdma_0


  # Create instance: axi_vdma_1, and set properties
  set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_1 ]
  set_property -dict [list \
    CONFIG.c_include_mm2s {0} \
    CONFIG.c_m_axi_s2mm_data_width {128} \
    CONFIG.c_s2mm_linebuffer_depth {2048} \
    CONFIG.c_s2mm_max_burst_length {32} \
  ] $axi_vdma_1


  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property CONFIG.CONST_VAL {0} $xlconstant_1


  # Create instance: mipi_csi2_rx_subsyst_1, and set properties
  set mipi_csi2_rx_subsyst_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:5.4 mipi_csi2_rx_subsyst_1 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {4} \
    CONFIG.CMN_NUM_PIXELS {4} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_CONTROLLER_REG_IF {true} \
    CONFIG.C_DPHY_LANES {4} \
    CONFIG.C_HS_SETTLE_NS {145} \
    CONFIG.DPY_LINE_RATE {1000} \
    CONFIG.SupportLevel {0} \
    CONFIG.VFB_TU_WIDTH {96} \
  ] $mipi_csi2_rx_subsyst_1


  # Create instance: axi_vdma_2, and set properties
  set axi_vdma_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_2 ]
  set_property -dict [list \
    CONFIG.c_include_mm2s {0} \
    CONFIG.c_m_axi_s2mm_data_width {128} \
    CONFIG.c_s2mm_linebuffer_depth {2048} \
    CONFIG.c_s2mm_max_burst_length {32} \
  ] $axi_vdma_2


  # Create instance: v_demosaic_0, and set properties
  set v_demosaic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_demosaic:1.1 v_demosaic_0 ]
  set_property -dict [list \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_DATA_WIDTH {10} \
    CONFIG.MAX_ROWS {1080} \
    CONFIG.SAMPLES_PER_CLOCK {4} \
  ] $v_demosaic_0


  # Create instance: v_demosaic_1, and set properties
  set v_demosaic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_demosaic:1.1 v_demosaic_1 ]
  set_property -dict [list \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_DATA_WIDTH {10} \
    CONFIG.MAX_ROWS {1080} \
    CONFIG.SAMPLES_PER_CLOCK {4} \
  ] $v_demosaic_1


  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [list \
    CONFIG.M_HAS_TKEEP {1} \
    CONFIG.M_HAS_TLAST {1} \
    CONFIG.M_TDATA_NUM_BYTES {12} \
    CONFIG.M_TUSER_WIDTH {1} \
    CONFIG.S_HAS_TKEEP {0} \
    CONFIG.S_HAS_TLAST {1} \
    CONFIG.S_TDATA_NUM_BYTES {15} \
    CONFIG.S_TUSER_WIDTH {1} \
    CONFIG.TDATA_REMAP {tdata[109:102],tdata[99:92],tdata[119:112],tdata[79:72],tdata[69:62],tdata[89:82],tdata[49:42],tdata[39:32],tdata[59:52],tdata[19:12],tdata[9:2],tdata[29:22]} \
  ] $axis_subset_converter_0


  # Create instance: axis_subset_converter_1, and set properties
  set axis_subset_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_1 ]
  set_property -dict [list \
    CONFIG.M_HAS_TKEEP {1} \
    CONFIG.M_HAS_TLAST {1} \
    CONFIG.M_TDATA_NUM_BYTES {12} \
    CONFIG.M_TUSER_WIDTH {1} \
    CONFIG.S_HAS_TKEEP {0} \
    CONFIG.S_HAS_TLAST {1} \
    CONFIG.S_TDATA_NUM_BYTES {15} \
    CONFIG.S_TUSER_WIDTH {1} \
    CONFIG.TDATA_REMAP {tdata[109:102],tdata[99:92],tdata[119:112],tdata[79:72],tdata[69:62],tdata[89:82],tdata[49:42],tdata[39:32],tdata[59:52],tdata[19:12],tdata[9:2],tdata[29:22]} \
  ] $axis_subset_converter_1


  # Create instance: gmii_to_rgmii_0, and set properties
  set gmii_to_rgmii_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:gmii_to_rgmii:4.1 gmii_to_rgmii_0 ]
  set_property CONFIG.SupportLevel {Include_Shared_Logic_in_Core} $gmii_to_rgmii_0


  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: led_gpio, and set properties
  set led_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 led_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {1} \
  ] $led_gpio


  # Create instance: key_gpio, and set properties
  set key_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 key_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_INPUTS {1} \
    CONFIG.C_GPIO_WIDTH {1} \
    CONFIG.C_INTERRUPT_PRESENT {1} \
  ] $key_gpio


  # Create instance: cam0_rst_gpio, and set properties
  set cam0_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 cam0_rst_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_DOUT_DEFAULT {0x00000001} \
    CONFIG.C_GPIO_WIDTH {1} \
  ] $cam0_rst_gpio


  # Create instance: cam1_rst_gpio, and set properties
  set cam1_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 cam1_rst_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_DOUT_DEFAULT {0x00000001} \
    CONFIG.C_GPIO_WIDTH {1} \
  ] $cam1_rst_gpio


  # Create instance: rgmii_reset_0, and set properties
  set block_name rgmii_reset
  set block_cell_name rgmii_reset_0
  if { [catch {set rgmii_reset_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $rgmii_reset_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }



  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports sys] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net CLK_IN_D_0_2 [get_bd_intf_ports lcd_ref] [get_bd_intf_pins lcd_lvds_group/lcd_ref]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_DDR4_0 [get_bd_intf_ports DDR4] [get_bd_intf_pins axi_noc_0/CH0_DDR4_0]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins axi_vdma_2/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_smc_M01_AXI [get_bd_intf_pins axi_smc/M01_AXI] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_smc_M02_AXI [get_bd_intf_pins axi_smc/M02_AXI] [get_bd_intf_pins axi_vdma_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_smc_M03_AXI [get_bd_intf_pins axi_smc/M03_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_smc_M04_AXI [get_bd_intf_pins axi_smc/M04_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_1/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_smc_M05_AXI [get_bd_intf_pins axi_smc/M05_AXI] [get_bd_intf_pins v_demosaic_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_smc_M06_AXI [get_bd_intf_pins axi_smc/M06_AXI] [get_bd_intf_pins v_demosaic_1/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_smc_M07_AXI [get_bd_intf_pins axi_smc/M07_AXI] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net axi_smc_M08_AXI [get_bd_intf_pins axi_smc/M08_AXI] [get_bd_intf_pins key_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_smc_M09_AXI [get_bd_intf_pins axi_smc/M09_AXI] [get_bd_intf_pins led_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_smc_M10_AXI [get_bd_intf_pins axi_smc/M10_AXI] [get_bd_intf_pins cam0_rst_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_smc_M11_AXI [get_bd_intf_pins axi_smc/M11_AXI] [get_bd_intf_pins cam1_rst_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_noc_0/S06_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM] [get_bd_intf_pins axi_noc_0/S08_AXI]
  connect_bd_intf_net -intf_net axi_vdma_2_M_AXI_S2MM [get_bd_intf_pins axi_vdma_2/M_AXI_S2MM] [get_bd_intf_pins axi_noc_0/S07_AXI]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axis_subset_converter_1_M_AXIS [get_bd_intf_pins axis_subset_converter_1/M_AXIS] [get_bd_intf_pins axi_vdma_2/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net gmii_to_rgmii_0_MDIO_PHY [get_bd_intf_ports mdio] [get_bd_intf_pins gmii_to_rgmii_0/MDIO_PHY]
  connect_bd_intf_net -intf_net gmii_to_rgmii_0_RGMII [get_bd_intf_ports rgmii] [get_bd_intf_pins gmii_to_rgmii_0/RGMII]
  connect_bd_intf_net -intf_net key_gpio_GPIO [get_bd_intf_ports pl_key] [get_bd_intf_pins key_gpio/GPIO]
  connect_bd_intf_net -intf_net led_gpio_GPIO [get_bd_intf_ports pl_led] [get_bd_intf_pins led_gpio/GPIO]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out] [get_bd_intf_pins v_demosaic_0/s_axis_video]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_1_video_out [get_bd_intf_pins mipi_csi2_rx_subsyst_1/video_out] [get_bd_intf_pins v_demosaic_1/s_axis_video]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_ports mipi_phy_if_0] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net mipi_phy_if_1_1 [get_bd_intf_ports mipi_phy_if_1] [get_bd_intf_pins mipi_csi2_rx_subsyst_1/mipi_phy_if]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out] [get_bd_intf_pins lcd_lvds_group/lcd_vid_io]
  connect_bd_intf_net -intf_net v_demosaic_0_m_axis_video [get_bd_intf_pins v_demosaic_0/m_axis_video] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net v_demosaic_1_m_axis_video [get_bd_intf_pins v_demosaic_1/m_axis_video] [get_bd_intf_pins axis_subset_converter_1/S_AXIS]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_tc_0/vtiming_out] [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_0 [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_0] [get_bd_intf_pins axi_noc_0/S00_AXI]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_1 [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_1] [get_bd_intf_pins axi_noc_0/S01_AXI]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_2 [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_2] [get_bd_intf_pins axi_noc_0/S02_AXI]
  connect_bd_intf_net -intf_net versal_cips_0_FPD_CCI_NOC_3 [get_bd_intf_pins versal_cips_0/FPD_CCI_NOC_3] [get_bd_intf_pins axi_noc_0/S03_AXI]
  connect_bd_intf_net -intf_net versal_cips_0_GEM1_GMII [get_bd_intf_pins versal_cips_0/GEM1_GMII] [get_bd_intf_pins gmii_to_rgmii_0/GMII]
  connect_bd_intf_net -intf_net versal_cips_0_GEM1_MDIO [get_bd_intf_pins versal_cips_0/GEM1_MDIO] [get_bd_intf_pins gmii_to_rgmii_0/MDIO_GEM]
  connect_bd_intf_net -intf_net versal_cips_0_I2C0 [get_bd_intf_ports cam1_i2c] [get_bd_intf_pins versal_cips_0/I2C0]
  connect_bd_intf_net -intf_net versal_cips_0_I2C1 [get_bd_intf_ports cam2_i2c] [get_bd_intf_pins versal_cips_0/I2C1]
  connect_bd_intf_net -intf_net versal_cips_0_LPD_AXI_NOC_0 [get_bd_intf_pins versal_cips_0/LPD_AXI_NOC_0] [get_bd_intf_pins axi_noc_0/S04_AXI]
  connect_bd_intf_net -intf_net versal_cips_0_M_AXI_LPD [get_bd_intf_pins versal_cips_0/M_AXI_LPD] [get_bd_intf_pins axi_smc/S00_AXI]
  connect_bd_intf_net -intf_net versal_cips_0_PMC_NOC_AXI_0 [get_bd_intf_pins versal_cips_0/PMC_NOC_AXI_0] [get_bd_intf_pins axi_noc_0/S05_AXI]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins cam0_rst_gpio/gpio_io_o] [get_bd_pins v_demosaic_0/ap_rst_n]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_0_n [get_bd_pins lcd_lvds_group/Data_pins_0_n_0] [get_bd_ports clkout1_n]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_0_p [get_bd_pins lcd_lvds_group/Data_pins_0_p_0] [get_bd_ports clkout1_p]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_1_n [get_bd_pins lcd_lvds_group/Data_pins_1_n_0] [get_bd_ports dataout1_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_1_p [get_bd_pins lcd_lvds_group/Data_pins_1_p_0] [get_bd_ports dataout1_p_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_2_n [get_bd_pins lcd_lvds_group/Data_pins_2_n_0] [get_bd_ports dataout1_n_1]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_2_p [get_bd_pins lcd_lvds_group/Data_pins_2_p_0] [get_bd_ports dataout1_p_1]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_3_n [get_bd_pins lcd_lvds_group/Data_pins_3_n_0] [get_bd_ports dataout1_n_2]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_3_p [get_bd_pins lcd_lvds_group/Data_pins_3_p_0] [get_bd_ports dataout1_p_2]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_4_n [get_bd_pins lcd_lvds_group/Data_pins_4_n_0] [get_bd_ports dataout1_n_3]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_4_p [get_bd_pins lcd_lvds_group/Data_pins_4_p_0] [get_bd_ports dataout1_p_3]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins axi_vdma_0/mm2s_introut] [get_bd_pins versal_cips_0/pl_ps_irq0]
  connect_bd_net -net axi_vdma_1_s2mm_introut [get_bd_pins axi_vdma_1/s2mm_introut] [get_bd_pins versal_cips_0/pl_ps_irq2]
  connect_bd_net -net axi_vdma_2_s2mm_introut [get_bd_pins axi_vdma_2/s2mm_introut] [get_bd_pins versal_cips_0/pl_ps_irq3]
  connect_bd_net -net cam1_rst_gpio_gpio_io_o [get_bd_pins cam1_rst_gpio/gpio_io_o] [get_bd_pins v_demosaic_1/ap_rst_n]
  connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins clk_wizard_0/clk_out1] [get_bd_pins gmii_to_rgmii_0/clkin] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins rgmii_reset_0/clk]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins clk_wizard_0/clk_out2] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsyst_1/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins clk_wizard_0/clk_out3] [get_bd_pins rst_clk_wizard_0_150M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_tc_0/s_axi_aclk] [get_bd_pins axi_noc_0/aclk6] [get_bd_pins axi_smc/aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk] [get_bd_pins versal_cips_0/m_axi_lpd_aclk] [get_bd_pins mipi_csi2_rx_subsyst_1/video_aclk] [get_bd_pins axi_vdma_2/s_axi_lite_aclk] [get_bd_pins axi_vdma_2/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_2/s_axis_s2mm_aclk] [get_bd_pins v_demosaic_0/ap_clk] [get_bd_pins v_demosaic_1/ap_clk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins axis_subset_converter_1/aclk] [get_bd_pins mipi_csi2_rx_subsyst_1/lite_aclk] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk] [get_bd_pins led_gpio/s_axi_aclk] [get_bd_pins key_gpio/s_axi_aclk] [get_bd_pins cam0_rst_gpio/s_axi_aclk] [get_bd_pins cam1_rst_gpio/s_axi_aclk]
  connect_bd_net -net key_gpio_ip2intc_irpt [get_bd_pins key_gpio/ip2intc_irpt] [get_bd_pins versal_cips_0/pl_ps_irq6]
  connect_bd_net -net lcd_clk_1 [get_bd_pins lcd_lvds_group/lcd_pclk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_clkoutphy_out [get_bd_pins mipi_csi2_rx_subsyst_0/clkoutphy_out] [get_bd_pins mipi_csi2_rx_subsyst_1/clkoutphy_in]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_pll_lock_out [get_bd_pins mipi_csi2_rx_subsyst_0/pll_lock_out] [get_bd_pins mipi_csi2_rx_subsyst_1/pll_lock_in]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins gmii_to_rgmii_0/tx_reset] [get_bd_pins gmii_to_rgmii_0/rx_reset]
  connect_bd_net -net rgmii_reset_0_rstn_out [get_bd_pins rgmii_reset_0/rstn_out] [get_bd_ports phy_reset_n]
  connect_bd_net -net rst_clk_wizard_0_150M_peripheral_aresetn [get_bd_pins rst_clk_wizard_0_150M/peripheral_aresetn] [get_bd_pins v_tc_0/s_axi_aresetn] [get_bd_pins axi_smc/aresetn] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_1/video_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_1/lite_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn] [get_bd_pins led_gpio/s_axi_aresetn] [get_bd_pins key_gpio/s_axi_aresetn] [get_bd_pins cam0_rst_gpio/s_axi_aresetn] [get_bd_pins cam1_rst_gpio/s_axi_aresetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins axi_vdma_2/axi_resetn] [get_bd_pins axis_subset_converter_1/aresetn]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins axi_noc_0/sys_clk0] [get_bd_pins clk_wizard_0/clk_in1]
  connect_bd_net -net v_axi4s_vid_out_0_sof_state_out [get_bd_pins v_axi4s_vid_out_0/sof_state_out] [get_bd_pins v_tc_0/sof_state]
  connect_bd_net -net v_demosaic_0_interrupt [get_bd_pins v_demosaic_0/interrupt] [get_bd_pins versal_cips_0/pl_ps_irq4]
  connect_bd_net -net v_demosaic_1_interrupt [get_bd_pins v_demosaic_1/interrupt] [get_bd_pins versal_cips_0/pl_ps_irq5]
  connect_bd_net -net v_tc_0_irq [get_bd_pins v_tc_0/irq] [get_bd_pins versal_cips_0/pl_ps_irq1]
  connect_bd_net -net versal_cips_0_LPD_GPIO_o [get_bd_pins versal_cips_0/LPD_GPIO_o] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi0_clk [get_bd_pins versal_cips_0/fpd_cci_noc_axi0_clk] [get_bd_pins axi_noc_0/aclk0]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi1_clk [get_bd_pins versal_cips_0/fpd_cci_noc_axi1_clk] [get_bd_pins axi_noc_0/aclk1]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi2_clk [get_bd_pins versal_cips_0/fpd_cci_noc_axi2_clk] [get_bd_pins axi_noc_0/aclk2]
  connect_bd_net -net versal_cips_0_fpd_cci_noc_axi3_clk [get_bd_pins versal_cips_0/fpd_cci_noc_axi3_clk] [get_bd_pins axi_noc_0/aclk3]
  connect_bd_net -net versal_cips_0_lpd_axi_noc_clk [get_bd_pins versal_cips_0/lpd_axi_noc_clk] [get_bd_pins axi_noc_0/aclk4]
  connect_bd_net -net versal_cips_0_pl0_resetn [get_bd_pins versal_cips_0/pl0_resetn] [get_bd_pins rst_clk_wizard_0_150M/ext_reset_in] [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins rgmii_reset_0/rstn_in]
  connect_bd_net -net versal_cips_0_pmc_axi_noc_axi0_clk [get_bd_pins versal_cips_0/pmc_axi_noc_axi0_clk] [get_bd_pins axi_noc_0/aclk5]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconstant_0/dout] [get_bd_ports lcd_en]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins xlconstant_1/dout] [get_bd_ports lcd_sync]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_ports cam1_gpio]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins xlslice_1/Dout] [get_bd_ports cam2_gpio]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces versal_cips_0/FPD_CCI_NOC_0] [get_bd_addr_segs axi_noc_0/S00_AXI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces versal_cips_0/FPD_CCI_NOC_1] [get_bd_addr_segs axi_noc_0/S01_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces versal_cips_0/FPD_CCI_NOC_2] [get_bd_addr_segs axi_noc_0/S02_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces versal_cips_0/FPD_CCI_NOC_3] [get_bd_addr_segs axi_noc_0/S03_AXI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces versal_cips_0/LPD_AXI_NOC_0] [get_bd_addr_segs axi_noc_0/S04_AXI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x80010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x80080000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs axi_vdma_2/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x80050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs cam0_rst_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x80060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs cam1_rst_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x80030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs key_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x80040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs led_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x800B0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0x800B1000 -range 0x00001000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs mipi_csi2_rx_subsyst_1/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0x80090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs v_demosaic_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x800A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs v_demosaic_1/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x80020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces versal_cips_0/M_AXI_LPD] [get_bd_addr_segs v_tc_0/ctrl/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces versal_cips_0/PMC_NOC_AXI_0] [get_bd_addr_segs axi_noc_0/S05_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_noc_0/S06_AXI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs axi_noc_0/S08_AXI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vdma_2/Data_S2MM] [get_bd_addr_segs axi_noc_0/S07_AXI/C1_DDR_LOW0] -force
