########################################################################
# NOTE: This is a tool-generated file and should not be edited manually.
########################################################################

# Core: u_ila_0
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_MEMORY_TYPE 0 [get_debug_cores u_ila_0]
set_property C_NUM_OF_PROBES 38 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
connect_debug_port u_ila_0/clk [get_nets [list {ps_block/design_1_i/clk_wizard_0/inst/clock_primitive_inst/clk_out1} ]]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {M_AXI_ARADDR[0]} {M_AXI_ARADDR[1]} {M_AXI_ARADDR[2]} {M_AXI_ARADDR[3]} {M_AXI_ARADDR[4]} {M_AXI_ARADDR[5]} {M_AXI_ARADDR[6]} {M_AXI_ARADDR[7]} {M_AXI_ARADDR[8]} {M_AXI_ARADDR[9]} {M_AXI_ARADDR[10]} {M_AXI_ARADDR[11]} {M_AXI_ARADDR[12]} {M_AXI_ARADDR[13]} {M_AXI_ARADDR[14]} {M_AXI_ARADDR[15]} {M_AXI_ARADDR[16]} {M_AXI_ARADDR[17]} {M_AXI_ARADDR[18]} {M_AXI_ARADDR[19]} {M_AXI_ARADDR[20]} {M_AXI_ARADDR[21]} {M_AXI_ARADDR[22]} {M_AXI_ARADDR[23]} {M_AXI_ARADDR[24]} {M_AXI_ARADDR[25]} {M_AXI_ARADDR[26]} {M_AXI_ARADDR[27]} {M_AXI_ARADDR[28]} {M_AXI_ARADDR[29]} {M_AXI_ARADDR[30]} {M_AXI_ARADDR[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe1]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {M_AXI_ARBURST[0]} {M_AXI_ARBURST[1]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {M_AXI_ARLEN[0]} {M_AXI_ARLEN[1]} {M_AXI_ARLEN[2]} {M_AXI_ARLEN[3]} {M_AXI_ARLEN[4]} {M_AXI_ARLEN[5]} {M_AXI_ARLEN[6]} {M_AXI_ARLEN[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe3]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {M_AXI_ARSIZE[0]} {M_AXI_ARSIZE[1]} {M_AXI_ARSIZE[2]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {M_AXI_AWADDR[0]} {M_AXI_AWADDR[1]} {M_AXI_AWADDR[2]} {M_AXI_AWADDR[3]} {M_AXI_AWADDR[4]} {M_AXI_AWADDR[5]} {M_AXI_AWADDR[6]} {M_AXI_AWADDR[7]} {M_AXI_AWADDR[8]} {M_AXI_AWADDR[9]} {M_AXI_AWADDR[10]} {M_AXI_AWADDR[11]} {M_AXI_AWADDR[12]} {M_AXI_AWADDR[13]} {M_AXI_AWADDR[14]} {M_AXI_AWADDR[15]} {M_AXI_AWADDR[16]} {M_AXI_AWADDR[17]} {M_AXI_AWADDR[18]} {M_AXI_AWADDR[19]} {M_AXI_AWADDR[20]} {M_AXI_AWADDR[21]} {M_AXI_AWADDR[22]} {M_AXI_AWADDR[23]} {M_AXI_AWADDR[24]} {M_AXI_AWADDR[25]} {M_AXI_AWADDR[26]} {M_AXI_AWADDR[27]} {M_AXI_AWADDR[28]} {M_AXI_AWADDR[29]} {M_AXI_AWADDR[30]} {M_AXI_AWADDR[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe5]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {M_AXI_AWBURST[0]} {M_AXI_AWBURST[1]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {M_AXI_AWLEN[0]} {M_AXI_AWLEN[1]} {M_AXI_AWLEN[2]} {M_AXI_AWLEN[3]} {M_AXI_AWLEN[4]} {M_AXI_AWLEN[5]} {M_AXI_AWLEN[6]} {M_AXI_AWLEN[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 3 [get_debug_ports u_ila_0/probe7]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {M_AXI_AWSIZE[0]} {M_AXI_AWSIZE[1]} {M_AXI_AWSIZE[2]} ]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe8]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {M_AXI_BRESP[0]} {M_AXI_BRESP[1]} ]]
create_debug_port u_ila_0 probe
set_property port_width 64 [get_debug_ports u_ila_0/probe9]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {M_AXI_RDATA[0]} {M_AXI_RDATA[1]} {M_AXI_RDATA[2]} {M_AXI_RDATA[3]} {M_AXI_RDATA[4]} {M_AXI_RDATA[5]} {M_AXI_RDATA[6]} {M_AXI_RDATA[7]} {M_AXI_RDATA[8]} {M_AXI_RDATA[9]} {M_AXI_RDATA[10]} {M_AXI_RDATA[11]} {M_AXI_RDATA[12]} {M_AXI_RDATA[13]} {M_AXI_RDATA[14]} {M_AXI_RDATA[15]} {M_AXI_RDATA[16]} {M_AXI_RDATA[17]} {M_AXI_RDATA[18]} {M_AXI_RDATA[19]} {M_AXI_RDATA[20]} {M_AXI_RDATA[21]} {M_AXI_RDATA[22]} {M_AXI_RDATA[23]} {M_AXI_RDATA[24]} {M_AXI_RDATA[25]} {M_AXI_RDATA[26]} {M_AXI_RDATA[27]} {M_AXI_RDATA[28]} {M_AXI_RDATA[29]} {M_AXI_RDATA[30]} {M_AXI_RDATA[31]} {M_AXI_RDATA[32]} {M_AXI_RDATA[33]} {M_AXI_RDATA[34]} {M_AXI_RDATA[35]} {M_AXI_RDATA[36]} {M_AXI_RDATA[37]} {M_AXI_RDATA[38]} {M_AXI_RDATA[39]} {M_AXI_RDATA[40]} {M_AXI_RDATA[41]} {M_AXI_RDATA[42]} {M_AXI_RDATA[43]} {M_AXI_RDATA[44]} {M_AXI_RDATA[45]} {M_AXI_RDATA[46]} {M_AXI_RDATA[47]} {M_AXI_RDATA[48]} {M_AXI_RDATA[49]} {M_AXI_RDATA[50]} {M_AXI_RDATA[51]} {M_AXI_RDATA[52]} {M_AXI_RDATA[53]} {M_AXI_RDATA[54]} {M_AXI_RDATA[55]} {M_AXI_RDATA[56]} {M_AXI_RDATA[57]} {M_AXI_RDATA[58]} {M_AXI_RDATA[59]} {M_AXI_RDATA[60]} {M_AXI_RDATA[61]} {M_AXI_RDATA[62]} {M_AXI_RDATA[63]} ]]
create_debug_port u_ila_0 probe
set_property port_width 2 [get_debug_ports u_ila_0/probe10]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {M_AXI_RRESP[0]} {M_AXI_RRESP[1]} ]]
create_debug_port u_ila_0 probe
set_property port_width 64 [get_debug_ports u_ila_0/probe11]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {M_AXI_WDATA[0]} {M_AXI_WDATA[1]} {M_AXI_WDATA[2]} {M_AXI_WDATA[3]} {M_AXI_WDATA[4]} {M_AXI_WDATA[5]} {M_AXI_WDATA[6]} {M_AXI_WDATA[7]} {M_AXI_WDATA[8]} {M_AXI_WDATA[9]} {M_AXI_WDATA[10]} {M_AXI_WDATA[11]} {M_AXI_WDATA[12]} {M_AXI_WDATA[13]} {M_AXI_WDATA[14]} {M_AXI_WDATA[15]} {M_AXI_WDATA[16]} {M_AXI_WDATA[17]} {M_AXI_WDATA[18]} {M_AXI_WDATA[19]} {M_AXI_WDATA[20]} {M_AXI_WDATA[21]} {M_AXI_WDATA[22]} {M_AXI_WDATA[23]} {M_AXI_WDATA[24]} {M_AXI_WDATA[25]} {M_AXI_WDATA[26]} {M_AXI_WDATA[27]} {M_AXI_WDATA[28]} {M_AXI_WDATA[29]} {M_AXI_WDATA[30]} {M_AXI_WDATA[31]} {M_AXI_WDATA[32]} {M_AXI_WDATA[33]} {M_AXI_WDATA[34]} {M_AXI_WDATA[35]} {M_AXI_WDATA[36]} {M_AXI_WDATA[37]} {M_AXI_WDATA[38]} {M_AXI_WDATA[39]} {M_AXI_WDATA[40]} {M_AXI_WDATA[41]} {M_AXI_WDATA[42]} {M_AXI_WDATA[43]} {M_AXI_WDATA[44]} {M_AXI_WDATA[45]} {M_AXI_WDATA[46]} {M_AXI_WDATA[47]} {M_AXI_WDATA[48]} {M_AXI_WDATA[49]} {M_AXI_WDATA[50]} {M_AXI_WDATA[51]} {M_AXI_WDATA[52]} {M_AXI_WDATA[53]} {M_AXI_WDATA[54]} {M_AXI_WDATA[55]} {M_AXI_WDATA[56]} {M_AXI_WDATA[57]} {M_AXI_WDATA[58]} {M_AXI_WDATA[59]} {M_AXI_WDATA[60]} {M_AXI_WDATA[61]} {M_AXI_WDATA[62]} {M_AXI_WDATA[63]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe12]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {M_AXI_WSTRB[0]} {M_AXI_WSTRB[1]} {M_AXI_WSTRB[2]} {M_AXI_WSTRB[3]} {M_AXI_WSTRB[4]} {M_AXI_WSTRB[5]} {M_AXI_WSTRB[6]} {M_AXI_WSTRB[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe13]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {rd_burst_addr[0]} {rd_burst_addr[1]} {rd_burst_addr[2]} {rd_burst_addr[3]} {rd_burst_addr[4]} {rd_burst_addr[5]} {rd_burst_addr[6]} {rd_burst_addr[7]} {rd_burst_addr[8]} {rd_burst_addr[9]} {rd_burst_addr[10]} {rd_burst_addr[11]} {rd_burst_addr[12]} {rd_burst_addr[13]} {rd_burst_addr[14]} {rd_burst_addr[15]} {rd_burst_addr[16]} {rd_burst_addr[17]} {rd_burst_addr[18]} {rd_burst_addr[19]} {rd_burst_addr[20]} {rd_burst_addr[21]} {rd_burst_addr[22]} {rd_burst_addr[23]} {rd_burst_addr[24]} {rd_burst_addr[25]} {rd_burst_addr[26]} {rd_burst_addr[27]} {rd_burst_addr[28]} {rd_burst_addr[29]} {rd_burst_addr[30]} {rd_burst_addr[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 64 [get_debug_ports u_ila_0/probe14]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {rd_burst_data[0]} {rd_burst_data[1]} {rd_burst_data[2]} {rd_burst_data[3]} {rd_burst_data[4]} {rd_burst_data[5]} {rd_burst_data[6]} {rd_burst_data[7]} {rd_burst_data[8]} {rd_burst_data[9]} {rd_burst_data[10]} {rd_burst_data[11]} {rd_burst_data[12]} {rd_burst_data[13]} {rd_burst_data[14]} {rd_burst_data[15]} {rd_burst_data[16]} {rd_burst_data[17]} {rd_burst_data[18]} {rd_burst_data[19]} {rd_burst_data[20]} {rd_burst_data[21]} {rd_burst_data[22]} {rd_burst_data[23]} {rd_burst_data[24]} {rd_burst_data[25]} {rd_burst_data[26]} {rd_burst_data[27]} {rd_burst_data[28]} {rd_burst_data[29]} {rd_burst_data[30]} {rd_burst_data[31]} {rd_burst_data[32]} {rd_burst_data[33]} {rd_burst_data[34]} {rd_burst_data[35]} {rd_burst_data[36]} {rd_burst_data[37]} {rd_burst_data[38]} {rd_burst_data[39]} {rd_burst_data[40]} {rd_burst_data[41]} {rd_burst_data[42]} {rd_burst_data[43]} {rd_burst_data[44]} {rd_burst_data[45]} {rd_burst_data[46]} {rd_burst_data[47]} {rd_burst_data[48]} {rd_burst_data[49]} {rd_burst_data[50]} {rd_burst_data[51]} {rd_burst_data[52]} {rd_burst_data[53]} {rd_burst_data[54]} {rd_burst_data[55]} {rd_burst_data[56]} {rd_burst_data[57]} {rd_burst_data[58]} {rd_burst_data[59]} {rd_burst_data[60]} {rd_burst_data[61]} {rd_burst_data[62]} {rd_burst_data[63]} ]]
create_debug_port u_ila_0 probe
set_property port_width 10 [get_debug_ports u_ila_0/probe15]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {rd_burst_len[0]} {rd_burst_len[1]} {rd_burst_len[2]} {rd_burst_len[3]} {rd_burst_len[4]} {rd_burst_len[5]} {rd_burst_len[6]} {rd_burst_len[7]} {rd_burst_len[8]} {rd_burst_len[9]} ]]
create_debug_port u_ila_0 probe
set_property port_width 32 [get_debug_ports u_ila_0/probe16]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {wr_burst_addr[0]} {wr_burst_addr[1]} {wr_burst_addr[2]} {wr_burst_addr[3]} {wr_burst_addr[4]} {wr_burst_addr[5]} {wr_burst_addr[6]} {wr_burst_addr[7]} {wr_burst_addr[8]} {wr_burst_addr[9]} {wr_burst_addr[10]} {wr_burst_addr[11]} {wr_burst_addr[12]} {wr_burst_addr[13]} {wr_burst_addr[14]} {wr_burst_addr[15]} {wr_burst_addr[16]} {wr_burst_addr[17]} {wr_burst_addr[18]} {wr_burst_addr[19]} {wr_burst_addr[20]} {wr_burst_addr[21]} {wr_burst_addr[22]} {wr_burst_addr[23]} {wr_burst_addr[24]} {wr_burst_addr[25]} {wr_burst_addr[26]} {wr_burst_addr[27]} {wr_burst_addr[28]} {wr_burst_addr[29]} {wr_burst_addr[30]} {wr_burst_addr[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 64 [get_debug_ports u_ila_0/probe17]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {wr_burst_data[0]} {wr_burst_data[1]} {wr_burst_data[2]} {wr_burst_data[3]} {wr_burst_data[4]} {wr_burst_data[5]} {wr_burst_data[6]} {wr_burst_data[7]} {wr_burst_data[8]} {wr_burst_data[9]} {wr_burst_data[10]} {wr_burst_data[11]} {wr_burst_data[12]} {wr_burst_data[13]} {wr_burst_data[14]} {wr_burst_data[15]} {wr_burst_data[16]} {wr_burst_data[17]} {wr_burst_data[18]} {wr_burst_data[19]} {wr_burst_data[20]} {wr_burst_data[21]} {wr_burst_data[22]} {wr_burst_data[23]} {wr_burst_data[24]} {wr_burst_data[25]} {wr_burst_data[26]} {wr_burst_data[27]} {wr_burst_data[28]} {wr_burst_data[29]} {wr_burst_data[30]} {wr_burst_data[31]} {wr_burst_data[32]} {wr_burst_data[33]} {wr_burst_data[34]} {wr_burst_data[35]} {wr_burst_data[36]} {wr_burst_data[37]} {wr_burst_data[38]} {wr_burst_data[39]} {wr_burst_data[40]} {wr_burst_data[41]} {wr_burst_data[42]} {wr_burst_data[43]} {wr_burst_data[44]} {wr_burst_data[45]} {wr_burst_data[46]} {wr_burst_data[47]} {wr_burst_data[48]} {wr_burst_data[49]} {wr_burst_data[50]} {wr_burst_data[51]} {wr_burst_data[52]} {wr_burst_data[53]} {wr_burst_data[54]} {wr_burst_data[55]} {wr_burst_data[56]} {wr_burst_data[57]} {wr_burst_data[58]} {wr_burst_data[59]} {wr_burst_data[60]} {wr_burst_data[61]} {wr_burst_data[62]} {wr_burst_data[63]} ]]
create_debug_port u_ila_0 probe
set_property port_width 10 [get_debug_ports u_ila_0/probe18]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {wr_burst_len[0]} {wr_burst_len[1]} {wr_burst_len[2]} {wr_burst_len[3]} {wr_burst_len[4]} {wr_burst_len[5]} {wr_burst_len[6]} {wr_burst_len[7]} {wr_burst_len[8]} {wr_burst_len[9]} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {error} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {M_AXI_ARREADY} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {M_AXI_ARVALID} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {M_AXI_AWREADY} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {M_AXI_AWVALID} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {M_AXI_BREADY} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {M_AXI_BVALID} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {M_AXI_RLAST} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list {M_AXI_RREADY} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list {M_AXI_RVALID} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list {M_AXI_WLAST} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list {M_AXI_WREADY} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list {M_AXI_WVALID} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list {rd_burst_data_valid} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list {rd_burst_finish} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list {rd_burst_req} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list {wr_burst_data_req} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list {wr_burst_finish} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list {wr_burst_req} ]]

