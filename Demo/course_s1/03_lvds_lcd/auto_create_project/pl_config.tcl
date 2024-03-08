  # Create interface ports
  set sys [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys


  # Create ports
  set dataout1_p_0 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_0 ]
  set dataout1_p_3 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_3 ]
  set clkout1_n [ create_bd_port -dir O -from 0 -to 0 clkout1_n ]
  set clkout1_p [ create_bd_port -dir O -from 0 -to 0 clkout1_p ]
  set dataout1_n_2 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_2 ]
  set dataout1_p_2 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_2 ]
  set dataout1_n_1 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_1 ]
  set dataout1_p_1 [ create_bd_port -dir O -from 0 -to 0 dataout1_p_1 ]
  set dataout1_n_0 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_0 ]
  set dataout1_n_3 [ create_bd_port -dir O -from 0 -to 0 dataout1_n_3 ]
  set lcd_en [ create_bd_port -dir O -from 0 -to 0 -type data lcd_en ]
  set lcd_sync [ create_bd_port -dir O -from 0 -to 0 -type data lcd_sync ]
  
   # Create instance: advanced_io_wizard_0, and set properties
  set advanced_io_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:advanced_io_wizard:1.0 advanced_io_wizard_0 ]
  set_property -dict [list \
    CONFIG.BUS0_IO_TYPE {DIFF} \
    CONFIG.BUS0_SIG_TYPE {Clk Fwd} \
    CONFIG.BUS1_DIR {TX} \
    CONFIG.BUS1_IO_TYPE {DIFF} \
    CONFIG.BUS2_DIR {TX} \
    CONFIG.BUS2_IO_TYPE {DIFF} \
    CONFIG.BUS3_DIR {TX} \
    CONFIG.BUS3_IO_TYPE {DIFF} \
    CONFIG.BUS4_DIR {TX} \
    CONFIG.BUS4_IO_TYPE {DIFF} \
    CONFIG.BUS_DIR {0} \
    CONFIG.DATA_SPEED {700} \
    CONFIG.DIFF_IO_STD {DIFF_SSTL12} \
    CONFIG.INPUT_CLK_FREQ {200.000} \
    CONFIG.PLL_IN_CORE {0} \
    CONFIG.TX_SERIALIZATION_FACTOR {4} \
  ] $advanced_io_wizard_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {3} \
    CONFIG.DIN_WIDTH {16} \
  ] $xlslice_0


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {7} \
    CONFIG.DIN_TO {4} \
    CONFIG.DIN_WIDTH {16} \
  ] $xlslice_1


  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {11} \
    CONFIG.DIN_TO {8} \
    CONFIG.DIN_WIDTH {16} \
  ] $xlslice_2


  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {15} \
    CONFIG.DIN_TO {12} \
    CONFIG.DIN_WIDTH {16} \
  ] $xlslice_3


  # Create instance: const_vcc, and set properties
  set const_vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_vcc ]

  # Create instance: const_gnd, and set properties
  set const_gnd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_gnd ]
  set_property CONFIG.CONST_VAL {0} $const_gnd


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


  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [list \
    CONFIG.IN0_WIDTH {8} \
    CONFIG.IN1_WIDTH {8} \
    CONFIG.IN2_WIDTH {8} \
    CONFIG.NUM_PORTS {3} \
  ] $xlconcat_0


  # Create instance: lcd_lvds_0, and set properties
  set lcd_lvds_0 [ create_bd_cell -type ip -vlnv user.org:user:lcd_lvds:1.0 lcd_lvds_0 ]

  # Create instance: color_bar_0, and set properties
  set block_name color_bar
  set block_cell_name color_bar_0
  if { [catch {set color_bar_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $color_bar_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports sys] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]

  # Create port connections
  connect_bd_net -net advanced_io_wizard_0_Data_pins_0_n [get_bd_pins advanced_io_wizard_0/Data_pins_0_n] [get_bd_ports clkout1_n]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_0_p [get_bd_pins advanced_io_wizard_0/Data_pins_0_p] [get_bd_ports clkout1_p]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_1_n [get_bd_pins advanced_io_wizard_0/Data_pins_1_n] [get_bd_ports dataout1_n_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_1_p [get_bd_pins advanced_io_wizard_0/Data_pins_1_p] [get_bd_ports dataout1_p_0]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_2_n [get_bd_pins advanced_io_wizard_0/Data_pins_2_n] [get_bd_ports dataout1_n_1]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_2_p [get_bd_pins advanced_io_wizard_0/Data_pins_2_p] [get_bd_ports dataout1_p_1]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_3_n [get_bd_pins advanced_io_wizard_0/Data_pins_3_n] [get_bd_ports dataout1_n_2]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_3_p [get_bd_pins advanced_io_wizard_0/Data_pins_3_p] [get_bd_ports dataout1_p_2]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_4_n [get_bd_pins advanced_io_wizard_0/Data_pins_4_n] [get_bd_ports dataout1_n_3]
  connect_bd_net -net advanced_io_wizard_0_Data_pins_4_p [get_bd_pins advanced_io_wizard_0/Data_pins_4_p] [get_bd_ports dataout1_p_3]
  connect_bd_net -net advanced_io_wizard_0_intf_rdy [get_bd_pins advanced_io_wizard_0/intf_rdy] [get_bd_pins lcd_lvds_0/intf_rdy]
  connect_bd_net -net advanced_io_wizard_0_shared_pll_clkoutphyen_out [get_bd_pins advanced_io_wizard_0/shared_pll_clkoutphyen_out] [get_bd_pins lcd_lvds_0/clkoutphyen]
  connect_bd_net -net color_bar_0_de [get_bd_pins color_bar_0/de] [get_bd_pins lcd_lvds_0/lcd_de]
  connect_bd_net -net color_bar_0_hs [get_bd_pins color_bar_0/hs] [get_bd_pins lcd_lvds_0/lcd_hs]
  connect_bd_net -net color_bar_0_rgb_b [get_bd_pins color_bar_0/rgb_b] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net color_bar_0_rgb_g [get_bd_pins color_bar_0/rgb_g] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net color_bar_0_rgb_r [get_bd_pins color_bar_0/rgb_r] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net color_bar_0_vs [get_bd_pins color_bar_0/vs] [get_bd_pins lcd_lvds_0/lcd_vs]
  connect_bd_net -net const_gnd_dout [get_bd_pins const_gnd/dout] [get_bd_pins advanced_io_wizard_0/t_Data_pins_0] [get_bd_pins advanced_io_wizard_0/t_Data_pins_1] [get_bd_pins advanced_io_wizard_0/t_Data_pins_2] [get_bd_pins advanced_io_wizard_0/t_Data_pins_3] [get_bd_pins advanced_io_wizard_0/t_Data_pins_4] [get_bd_ports lcd_sync] [get_bd_pins lcd_lvds_0/mode]
  connect_bd_net -net const_vcc_dout [get_bd_pins const_vcc/dout] [get_bd_pins advanced_io_wizard_0/en_vtc] [get_bd_ports lcd_en]
  connect_bd_net -net lcd_lvds_0_lcd_pclk [get_bd_pins lcd_lvds_0/lcd_pclk] [get_bd_pins color_bar_0/clk]
  connect_bd_net -net lcd_lvds_0_parallel_clk [get_bd_pins lcd_lvds_0/parallel_clk] [get_bd_pins advanced_io_wizard_0/parallel_clk] [get_bd_pins advanced_io_wizard_0/ctrl_clk]
  connect_bd_net -net lcd_lvds_0_pll_clkoutphy_in [get_bd_pins lcd_lvds_0/pll_clkoutphy_in] [get_bd_pins advanced_io_wizard_0/shared_bank0_pll_clkoutphy_in]
  connect_bd_net -net lcd_lvds_0_tx_clk_data [get_bd_pins lcd_lvds_0/tx_clk_data] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_0]
  connect_bd_net -net lcd_lvds_0_tx_data [get_bd_pins lcd_lvds_0/tx_data] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net lcd_lvds_0_tx_enable [get_bd_pins lcd_lvds_0/tx_enable] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net lcd_lvds_0_tx_locked [get_bd_pins lcd_lvds_0/tx_locked] [get_bd_pins advanced_io_wizard_0/shared_bank0_pll_locked_in] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins lcd_lvds_0/tx_refclk]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res] [get_bd_pins advanced_io_wizard_0/rst]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_1/Res] [get_bd_pins lcd_lvds_0/tx_reset] [get_bd_pins color_bar_0/rst]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xlconcat_0/dout] [get_bd_pins lcd_lvds_0/lcd_odata_rgb]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_1]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins xlslice_1/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_2]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins xlslice_2/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_3]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins xlslice_3/Dout] [get_bd_pins advanced_io_wizard_0/data_from_fabric_Data_pins_4]
