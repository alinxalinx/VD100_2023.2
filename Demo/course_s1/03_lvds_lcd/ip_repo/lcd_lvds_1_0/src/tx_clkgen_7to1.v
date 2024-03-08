//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Filename: tx_clkgen_7to1.v
//  /   /        Date Last Modified:  04/03/2017
// /___/   /\    Date Created: 02/27/2017
// \   \  /  \
//  \___\/\___\
//
// Device    :  Ultrascale
//
// Purpose   :  Transmit clock generation for 1-to-7 serialization
//
// Parameters:  CLKIN_PERIOD - Real - Default = 6.600
//                 - Period in nanoseconds of the transmit clock clkin
//                 - Range = 6.364 to 17.500
//              USE_PLL - String - Default = "FALSE"
//                 - Selects either PLL or MMCM for clocking
//                 - Range = "FALSE" or "TRUE"
//
// Reference:	XAPPxxx
//
// Revision History:
//    Rev 1.0 - Initial Release (knagara)
//    Rev 0.9 - Early Access Release (mcgett)
//
//////////////////////////////////////////////////////////////////////////////
//
//  Disclaimer:
//
// This disclaimer is not a license and does not grant any rights to the
// materials distributed herewith. Except as otherwise provided in a valid
// license issued to you by Xilinx, and to the maximum extent permitted by
// applicable law:
//
// (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND
// XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR
// STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY,
// NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx
// shall not be liable (whether in contract or tort, including negligence, or
// under any other theory of liability) for any loss or damage of any kind or
// nature related to, arising under or in connection with these materials,
// including for any direct, or any indirect, special, incidental, or
// consequential loss or damage (including loss of data, profits, goodwill, or
// any type of loss or damage suffered as a result of any action brought by a
// third party) even if such damage or loss was reasonably foreseeable or
// Xilinx had been advised of the possibility of the same.
//
// Critical Applications:
//
// Xilinx products are not designed or intended to be fail-safe, or for use in
// any application requiring fail-safe performance, such as life-support or
// safety devices or systems, class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any other applications
// that could lead to death, personal injury, or severe property or
// environmental damage (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and liability of any use of
// Xilinx products in Critical Applications, subject only to applicable laws
// and regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
// AT ALL TIMES.
//
//////////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

module tx_clkgen_7to1 # (
         parameter real CLKIN_PERIOD = 6.600,  // Clock period (ns) of transmit clock
         parameter      USE_PLL      = "TRUE" // Selects either PLL or MMCM for clocking FALSE or TRUE
     )
     (
         input    clkin,                       // Transmit pixel clock
         input    reset,                       // Asynchronous interface reset 
         input    clkoutphyen,                       // Asynchronous interface reset 
         output   pll_clkout0_out,                      // Pixel clock 
         output   pll_clkout1_out,                  // Transmit Clock divide by two  (px_clk * 3.50)
         output   cmt_locked,                  // Transmit Clock divide by four (px_clk * 1.75)
         output   clkoutphy_out                   // PLL/MMCM locked output
     );

//
// Set VCO multiplier for PLL/MMCM 
//  2  - if clock_period is greater than 600 MHz/7
//  1  - if clock period is <= 600 MHz/7 
//
localparam VCO_MULTIPLIER = (CLKIN_PERIOD >3.247) ? 2 : 1; 

wire   px_pllmmcm; 
wire   tx_pllmmcm_div2; 
wire   locked_fb; 

//
// Instantiate PLL or MMCM
//
// generate
// if (USE_PLL == "FALSE") begin                   // use an MMCM
   // MMCME3_BASE # (
         // .CLKIN1_PERIOD      (CLKIN_PERIOD),
         // .BANDWIDTH          ("OPTIMIZED"),
         // .CLKFBOUT_MULT_F    (111.375),
         // .CLKOUT0_DIVIDE_F   (0.075),
         // .CLKOUT0_DUTY_CYCLE (0.5),
         // .CLKOUT0_PHASE      (0.0),
         // .DIVCLK_DIVIDE      (20),
         // .REF_JITTER1        (0.100)
      // )
      // tx_mmcm (
         // .CLKFBOUT       (px_pllmmcm),
         // .CLKFBOUTB      (),
         // .CLKOUT0        (tx_pllmmcm_div2),
         // .CLKOUT0B       (),
         // .CLKOUT1        (),
         // .CLKOUT1B       (),
         // .CLKOUT2        (),
         // .CLKOUT2B       (),
         // .CLKOUT3        (),
         // .CLKOUT3B       (),
         // .CLKOUT4        (),
         // .CLKOUT5        (),
         // .CLKOUT6        (),
         // .LOCKED         (cmt_locked),
         // .CLKFBIN        (px_clk),
         // .CLKIN1         (clkin),
         // .PWRDWN         (1'b0),
         // .RST            (reset)
     // );
   // end else begin           // Use a PLL
   // PLLE3_BASE # (
         // .CLKIN_PERIOD       (CLKIN_PERIOD),
         // .CLKFBOUT_MULT      (7*VCO_MULTIPLIER),
         // .CLKFBOUT_PHASE     (0.0),
         // .CLKOUT0_DIVIDE     (2*VCO_MULTIPLIER),
         // .CLKOUT0_DUTY_CYCLE (0.5),
         // .REF_JITTER         (0.100),
         // .DIVCLK_DIVIDE      (1)
      // )
      // tx_pll (
          // .CLKFBOUT       (px_pllmmcm),
          // .CLKOUT0        (tx_pllmmcm_div2),
          // .CLKOUT0B       (),
          // .CLKOUT1        (),
          // .CLKOUT1B       (),
          // .CLKOUTPHY      (),
          // .LOCKED         (cmt_locked),
          // .CLKFBIN        (px_clk),
          // .CLKIN          (clkin),
          // .CLKOUTPHYEN    (1'b0),
          // .PWRDWN         (1'b0),
          // .RST            (reset)
      // );
   // end
// endgenerate

  XPLL
  #(
    .CLKFBOUT_MULT        (14),
//    .CLKFBOUT_MULT        (7*VCO_MULTIPLIER),
    .CLKFBOUT_PHASE       (0.000),
    .CLKIN_PERIOD         (5),
//    .CLKOUT0_DIVIDE       (2*4*VCO_MULTIPLIER),
    .CLKOUT0_DIVIDE       (16),
    .CLKOUT1_DIVIDE       (28),
//    .CLKOUT1_DIVIDE       (2*7*VCO_MULTIPLIER),
    .CLKOUT2_DIVIDE       (28),
    .CLKOUT3_DIVIDE       (28),
    .CLKOUTPHY_DIVIDE     ("DIV4"),
    .DIVCLK_DIVIDE        (1),
    .CLKOUT0_PHASE        (0.0),
    .CLKOUT0_PHASE_CTRL   (2'b00),
    .CLKOUT3_PHASE_CTRL   (2'b00),
    .CLKOUT1_PHASE        (0.0),
    .CLKOUT3_PHASE        (0.0),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .REF_JITTER           (0.010))
  xpll_pll0_inst
    // Output clocks
   (
    .CLKOUT0             (pll_clkout0),
    .CLKOUT1             (pll_clkout1),
    .CLKOUT2             (),
    .CLKOUT3             (),
    .CLKOUTPHY           (clkoutphy_out),
    .LOCKED              (cmt_locked),
    .LOCKED1_DESKEW      (),
    .LOCKED2_DESKEW      (),
    .LOCKED_FB           (locked_fb),
     // Input clock control
    .CLKIN               (clkin),
    .CLKOUTPHYEN         (clkoutphyen),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (),
    .DRDY                (),
    .DWE                 (1'b0),
    // RIU ports
    .RIU_RD_DATA         (),
    .RIU_VALID           (),
    .RIU_ADDR            (8'h0),
    .RIU_CLK             (1'b0),
    .RIU_NIBBLE_SEL      (1'b0),
    .RIU_WR_DATA         (16'h0),
    .RIU_WR_EN           (1'b0),
    // Other control and status signals
    .CLKFB1_DESKEW       (1'b0),
    .CLKFB2_DESKEW       (1'b0),
    .CLKIN1_DESKEW       (1'b0),
    .CLKIN2_DESKEW       (1'b0),
    .CLKOUTPHY_CASC_IN   (1'b0),
    .CLKOUTPHY_CASC_OUT  (),
    .PSCLK               (0),
    .PSEN                (0),
    .PSINCDEC            (0),
    .PWRDWN              (1'b0),
    .PSDONE              (),
    .RST                 (0)
);

  BUFGCE # (
  .SIM_DEVICE ("VERSAL_AI_CORE_ES1"),
  .STARTUP_SYNC ("TRUE")
  )
  pll_clkout0_buf
   ( .O   (pll_clkout0_out),
     .CE   (locked_fb),
     .I    (pll_clkout0)
   );

  BUFGCE # (
  .SIM_DEVICE ("VERSAL_AI_CORE_ES1"),
  .STARTUP_SYNC ("TRUE")
  )
  pll_clkout1_buf
   ( .O   (pll_clkout1_out),
     .CE   (locked_fb),
     .I    (pll_clkout1)
   );

   
endmodule
