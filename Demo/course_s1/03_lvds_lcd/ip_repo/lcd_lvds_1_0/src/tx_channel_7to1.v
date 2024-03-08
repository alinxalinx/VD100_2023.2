//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Filename: tx_channel_7to1.v
//  /   /        Date Last Modified:  04/03/2017
// /___/   /\    Date Created: 02/27/2017
// \   \  /  \
//  \___\/\___\
//
// Device    :  Ultrascale
//
// Purpose   :  Transmit interface with 7-to-1 serialization
//
// Parameters:  LINES - Integer - Default = 5
//                 - # of output data lines
//                 - Range 1 to 24
//              DATA_FORMAT - String - Default = "PER_CLOCK"
//                 - Selects format of data bus to map sequential bits
//                   either on a clock or line basis.  When PER_CLOCK is
//                   used bits 0 to LINES-1 are the first bits transmitted
//                   from each lane.  When PER_LINE is used bits 0 to 6
//                   are the 7 sequential bits transmitted on line 0
//                 - Range = "PER_CLOCK" or "PER_LINE"
//              CLK_PATTERN - Binary - Default = 7'b1100011
//                 - Sets the clock pattern to be transmitted for alignment
//                 - Range = 0 to 2^7-1 typically 7'b1100011 or 7'b1100001
//              TX_SWAP_MASK - Binary - Default = 16'b0
//                 - Binary value indicating if an output line is inverted
//
// Reference:	XAPPxxx
//
// Revision History:
//    Rev 1.0 - Initial Release (knagara)
//    Rev 0.9 - Early Access Release (mcgett)
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

module tx_channel_7to1 # (
      parameter  LINES        = 5,            // Number of output lines
      parameter  DATA_FORMAT  = "PER_CLOCK",  // Data format selection either PER_CLOCK or PER_LINE
      parameter  CLK_PATTERN  = 7'b1100011,   // Transmit clock bit pattern
      parameter  TX_SWAP_MASK = 16'b0,        // Allows P/N outputs to be inverted to ease PCB routing
      parameter  SIM_DEVICE = "ULTRASCALE"    // Set for the family <ULTRASCALE | ULTRASCALE_PLUS>
   )
   (
      input [(LINES*7)-1:0] px_data,       // 7-bit pixel data synchronous to px_clk
      input                 px_reset,      // Reset for pixel logic synchronus to px_clk
      input                 div_reset,      // Reset for pixel logic synchronus to px_clk
      input                 px_clk,        // Pixel clock running at 1/7 transmit rate
      input                 tx_locked,    // Transmit clock running at 1/2 transmit rate
      input                 tx_clkdiv2,    // Transmit clock running at 1/2 transmit rate
      input                 tx_clkdiv4,    // Transmit clock running at 1/4 transmit rate
      input                 intf_rdy,       // Transmit clk N-side
      output                tx_enable,     //tx enable
      output [3:0]          tx_data_clk,   //parallel data clk
      output [4*4-1:0]      tx_data       //parallel data
);

wire [(LINES*7)-1:0] px_formatted;
reg  [7:0]   tx_enable_sync;

// 
// Synchronize px_reset to tx_clkdiv4 domain and delay for FIFO read
//
always @ (posedge tx_clkdiv4 or posedge div_reset)
begin
   if (div_reset) begin
      tx_enable_sync <= 8'b0;
   end
   else begin
      tx_enable_sync <= {1'b1, tx_enable_sync[7:1]};
   end
end
assign tx_enable = tx_enable_sync[0];

//
// Reformat data based on the following
//
// PER_CLOCK - 5 Lines Example
//    - [ 4:0 ] - Transmitted on 1st clock edge
//    - [ 9:5 ] - Transmitted on 2nd clock edge
//    - [14:10] - Transmitted on 3rd clock edge
//    - [19:15] - Transmitted on 4th clock edge
//    - [24:20] - Transmitted on 5th clock edge
//    - [29:25] - Transmitted on 6th clock edge
//    - [34:30] - Transmitted on 7th clock edge
//
// PER_LINE - 5 Lines Example
//    - [ 6:0 ] - Transmitted on 1st line ( 0,  1,  2,  3,  4,  5,  6)
//    - [13:7 ] - Transmitted on 2nd line ( 7,  8,  9, 10, 11, 12, 13)
//    - [20:14] - Transmitted on 3rd line (14, 15, 16, 17, 18, 18, 20)
//    - [27:21] - Transmitted on 4th line (21, 22, 23, 24, 25, 26, 27)
//    - [34:28] - Transmitted on 5th line (28, 29, 30, 31, 32, 33, 34)
genvar i,j;
generate
   for (i=0; i<LINES; i=i+1) begin:loop0 
      for (j=0; j < 7 ; j=j+1) begin :loop1
         if (DATA_FORMAT == "PER_CLOCK")
             assign px_formatted[7*i+j] = px_data[LINES*j+i];
         else 
             assign px_formatted[7*i+j] = px_data[7*i+j];
      end
   end
endgenerate

//
// Clock Output
//
tx_piso_7to1 # (
      .TX_SWAP_MASK (1'b0)
    )
    txc_piso  (
      .px_data    (CLK_PATTERN),
      .px_reset   (px_reset),
      .div_reset  (div_reset),
      .px_clk     (px_clk),
      .tx_data    (tx_data_clk),
      .intf_rdy   (intf_rdy),
      .tx_clkdiv4 (tx_clkdiv4),
      .tx_clkdiv2 (tx_clkdiv2)
    );

// 
// Data Output
//
generate
   for (i = 0 ; i < LINES ; i = i+1) begin : txd
      tx_piso_7to1 # (
            .TX_SWAP_MASK (TX_SWAP_MASK[i])
          )
          piso  (
            .px_data    (px_formatted[((i+1)*7)-1 -:7]),
            .px_reset   (px_reset),
            .div_reset  (div_reset),
            .px_clk     (px_clk),
            .tx_data    (tx_data[i*4+:4]),
            .intf_rdy   (intf_rdy),
            .tx_clkdiv4 (tx_clkdiv4),
            .tx_clkdiv2 (tx_clkdiv2)
          );
   end
endgenerate





endmodule
