//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.3
//  \   \        Filename: tx_piso_1to7 .v
//  /   /        Date Last Modified:  06/06/2022
// /___/   /\    Date Created: 02/27/2017
// \   \  /  \
//  \___\/\___\
//
// Device    :  Ultrascale
//
// Purpose   :  Transmit Parallel In Serial Out with 1 to 7 conversion
//
// Parameters:  TX_SWAP_MASK - Binary - Default = 16'b0
//                 - Binary value indicating if an output line is inverted
//
// Reference:	XAPPxxx
//
// Revision History:
//    Rev 1.3 - Add SIM_DEVICE to allow code to work with ULTRASCALE_PLUS  (jimt)
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

module tx_piso_7to1 # (
      parameter  TX_SWAP_MASK = 1'b0  // Allows P/N outputs to be inverted pinswap to ease PCB routing 0=normal, 1=swapped

   )
   (
      input [6:0] px_data,       // 7-bit pixel data
      input       px_reset,      // Reset for pixel logic synchronus to px_clk
      input       div_reset,      // Reset for pixel logic synchronus to px_clk
      input       px_clk,        // Pixel clock running at 1/7 transmit rate
      input       intf_rdy,        // Pixel clock running at 1/7 transmit rate
      input       tx_clkdiv2,    // Transmit clock running at 1/2 transmit rate
      input       tx_clkdiv4,    // Transmit clock running at 1/4 transmit rate
      output reg  [3:0]  tx_data       // Transmit output N-side
   );

reg  [3:0]  wr_addr;
reg  [3:0]  rd_addr;
wire [6:0]  rd_curr;
reg  [6:1]  rd_last;
reg  [7:0]  rd_state;

reg          rden ;
wire         empty ;
wire         intf_px_rdy_sync ;
wire         intf_div_rdy_sync ;

wire         oserdes_out;

reg          wr_en ;
reg  [6:0]   wr_data;


// endgenerate
async2sync#
(
	.SYNC_STAGE (3),
	.WIDTH 		(1),
	.RESET_INIT_VALUE(0)
)pxclk_async2sync_inst
(
  .data_in		(intf_rdy),  
  .clk_sync		(px_clk),
  .rstn_sync	(~px_reset),
  .data_out		(intf_px_rdy_sync)

); 

async2sync#
(
	.SYNC_STAGE (3),
	.WIDTH 		(1),
	.RESET_INIT_VALUE(0)
)divclk_async2sync_inst
(
  .data_in		(intf_rdy),  
  .clk_sync		(tx_clkdiv4),
  .rstn_sync	(~div_reset),
  .data_out		(intf_div_rdy_sync)

); 


always @ (posedge px_clk)
begin
   if (px_reset) begin
       wr_en  <= 0;
   end else begin
	if (intf_px_rdy_sync)
		wr_en <= 1 ;
	else
		wr_en  <= 0;
	end
end

always @ (posedge px_clk)
begin
   if (px_reset) begin
       wr_data  <= 0;
   end else begin
	if (intf_px_rdy_sync)
		wr_data <= {px_data[6] ^ TX_SWAP_MASK,px_data[5] ^ TX_SWAP_MASK,px_data[4] ^ TX_SWAP_MASK,px_data[3] ^ TX_SWAP_MASK,px_data[2] ^ TX_SWAP_MASK,px_data[1] ^ TX_SWAP_MASK,px_data[0] ^ TX_SWAP_MASK} ;
	else
		wr_data  <= 0;
	end
end


	 
xpm_fifo_async #(
   .CDC_SYNC_STAGES      (2),        
   .DOUT_RESET_VALUE     ("0"),      
   .ECC_MODE             ("no_ecc"), 
   .FIFO_MEMORY_TYPE     ("auto"),   
   .FIFO_READ_LATENCY    (0),        
   .FIFO_WRITE_DEPTH     (32),  
   .FULL_RESET_VALUE     (0),        
   .PROG_EMPTY_THRESH    (10),       
   .PROG_FULL_THRESH     (10),       
   .RD_DATA_COUNT_WIDTH  (6),       
   .READ_DATA_WIDTH      (7),        
   .READ_MODE            ("fwft"),    
   .RELATED_CLOCKS       (0),        
   .USE_ADV_FEATURES     ("070F"),   
   .WAKEUP_TIME          (0),        
   .WRITE_DATA_WIDTH     (7),        
   .WR_DATA_COUNT_WIDTH  (6)        
)
fifo_async_inst (
   .rst            (px_reset),
   .wr_clk         (px_clk),
   .wr_en          (wr_en),
   .din            (wr_data),
   .rd_clk         (tx_clkdiv4),
   .rd_en          (rden ),
   .dout           (rd_curr),
   .empty          (empty),
   .full           (),
   .almost_empty   (),
   .almost_full    (),
   .wr_data_count  (),
   .rd_data_count  (),    
   .prog_empty     (),
   .prog_full      (),    
   .data_valid     (),
   .dbiterr        (),
   .sbiterr        (),
   .overflow       (),
   .underflow      (),
   .wr_ack         (),   
   .wr_rst_busy    (),   
   .rd_rst_busy    (),
   .injectdbiterr  (1'b0),
   .injectsbiterr  (1'b0),   
   .sleep          (1'b0)   
   ); 
//
// Store last read data for one cycle
//
always @ (posedge tx_clkdiv4)
begin
    if (rden)
        rd_last[6:1] <= rd_curr[6:1];
end

//
// Read state machine and gear box
//
always @ (posedge tx_clkdiv4)
begin
   if (div_reset | ~intf_div_rdy_sync) begin
       rd_addr  <= 4'b0;
       rd_state <= 8'h1;
       rden <= 0;
   end else begin
       case (rd_state ) 
		 8'h1 : begin 
				if (~empty)
					rd_state <= 8'h2;
            end
         8'h2 : begin 
			rden <= 1 ;
            tx_data <= rd_curr[3:0];
            rd_state<= rd_state<<1;
            end
         8'h4 : begin 
			rden <= 0 ;
            tx_data <= {rd_curr[0], rd_last[6:4]};
            rd_state<= rd_state<<1;
            end
         8'h8 : begin 
			rden <= 1 ;
            tx_data <= rd_last[4:1];
            rd_state<= rd_state<<1;
            end
         8'h10 : begin 
			rden <= 0 ;
            tx_data <= {rd_curr[1:0], rd_last[6:5]};
            rd_state<= rd_state<<1;
            end
         8'h20 : begin 
			rden <= 1 ;
            tx_data <= rd_last[5:2];
            rd_state<= rd_state<<1;
            end
         8'h40 : begin 
			rden <= 0 ;
            tx_data <= {rd_curr[2:0], rd_last[6]};
            rd_state<= rd_state<<1;
            end
         8'h80 : begin 
			rden <= 1 ;
            tx_data <= rd_last[6:3];
            rd_state<= 8'h2;
            end
       endcase
   end
end



endmodule
  
