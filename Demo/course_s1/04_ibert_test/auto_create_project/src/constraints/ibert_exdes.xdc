##------------------------------------------------------------------------------
##  (c) Copyright 2017-2018 AMD, Inc. All rights reserved.
##
##  This file contains confidential and proprietary information
##  of AMD, Inc. and is protected under U.S. and
##  international copyright and other intellectual property
##  laws.
##
##  DISCLAIMER
##  This disclaimer is not a license and does not grant any
##  rights to the materials distributed herewith. Except as
##  otherwise provided in a valid license issued to you by
##  AMD, and to the maximum extent permitted by applicable
##  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
##  WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
##  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
##  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
##  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
##  (2) AMD shall not be liable (whether in contract or tort,
##  including negligence, or under any other theory of
##  liability) for any loss or damage of any kind or nature
##  related to, arising under or in connection with these
##  materials, including for any direct, or any indirect,
##  special, incidental, or consequential loss or damage
##  (including loss of data, profits, goodwill, or any type of
##  loss or damage suffered as a result of any action brought
##  by a third party) even if such damage or loss was
##  reasonably foreseeable or AMD had been advised of the
##  possibility of the same.
##
##  CRITICAL APPLICATIONS
##  AMD products are not designed or intended to be fail-
##  safe, or for use in any application requiring fail-safe
##  performance, such as life-support or safety devices or
##  systems, Class III medical devices, nuclear facilities,
##  applications related to the deployment of airbags, or any
##  other applications that could lead to death, personal
##  injury, or severe property or environmental damage
##  (individually and collectively, "Critical
##  Applications"). Customer assumes the sole risk and
##  liability of any use of AMD products in Critical
##  Applications, subject only to applicable laws and
##  regulations governing limitations on product liability.
##
##  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
##  PART OF THIS FILE AT ALL TIMES.
##------------------------------------------------------------------------------
## Unbonded QUAD and REFCLK locations are
## GTYP_QUAD_X0Y0 GTYP_QUAD_X0Y1
## GTYP_REFCLK_X0Y0 GTYP_REFCLK_X0Y1 GTYP_REFCLK_X0Y2 GTYP_REFCLK_X0Y3
## 
## 
## QUAD and REFCLK locations
## GTYP_QUAD_X0Y0 GTYP_QUAD_X0Y1
## GTYP_REFCLK_X0Y0 GTYP_REFCLK_X0Y1 GTYP_REFCLK_X0Y2 GTYP_REFCLK_X0Y3

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property PACKAGE_PIN AB23 [get_ports {sys_clk_p}]
set_property PACKAGE_PIN AC23 [get_ports {sys_clk_n}]
set_property IOSTANDARD LVDS15 [get_ports {sys_clk_p}]
set_property IOSTANDARD LVDS15 [get_ports {sys_clk_n}]
create_clock -period 5.0 [get_ports sys_clk_p]


set_property PACKAGE_PIN H7 [get_ports {ref_clk_0_p}]
set_property PACKAGE_PIN E5 [get_ports {GT_Serial_gtx_p[0]}]
set_property PACKAGE_PIN D8 [get_ports {GT_Serial_grx_p[0]}]
set_property PACKAGE_PIN C5 [get_ports {GT_Serial_gtx_p[1]}]
set_property PACKAGE_PIN B8 [get_ports {GT_Serial_grx_p[1]}]

set_property PACKAGE_PIN F2 [get_ports {GT_Serial_gtx_p[2]}]
set_property PACKAGE_PIN D2 [get_ports {GT_Serial_grx_p[2]}]
set_property PACKAGE_PIN B2 [get_ports {GT_Serial_gtx_p[3]}]
set_property PACKAGE_PIN A5 [get_ports {GT_Serial_grx_p[3]}]

set_property PACKAGE_PIN F21 [get_ports {gt_reset[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {gt_reset[0]}]
set_property PACKAGE_PIN D26 [get_ports {sfp_disable[0]}]
set_property PACKAGE_PIN D25 [get_ports {sfp_disable[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {sfp_disable[*]}]
