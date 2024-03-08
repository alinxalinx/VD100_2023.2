//////////////////////////////////////////////////////////////////////////////
//
// Revision History:
//    Rev 0.1
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

module lcd_dual_lvds (
   input         tx_refclk,     // lvds reference clock
   input         tx_reset,      // reset (active high)
   input         mode,
   input         lcd_hs,
   input         lcd_vs,
   input         lcd_de,
   input[23:0]   lcd_odata_rgb,
   output        lcd_pclk,
   output        tx_locked,
   //lvds ports  
   input         clkoutphyen,
   input         intf_rdy,
   output        parallel_clk,
   output        pll_clkoutphy_in,
   output        tx_enable,     //tx enable
   output  [3:0] tx_clk_data,   //parallel data clk
   output [15:0] tx_data       //parallel data
) ;  



localparam   SIM_DEVICE   = "ULTRASCALE_PLUS" ; // Set for the family <ULTRASCALE | 

// Wires

wire            tx_px_clk;
wire            tx_clkdiv2;
wire            tx_clkdiv4;


reg      [3:0]  tx_div_locked;
reg      [3:0]  tx_px_locked;
wire            tx_div_reset;
wire            tx_px_reset;
wire            tx_reset_int;

reg     [27:0]  tx_px_data1;

wire    [7:0]   tx_px_data1_r;
wire    [7:0]   tx_px_data1_g;
wire    [7:0]   tx_px_data1_b;

assign tx_px_data1_r = lcd_odata_rgb[23:16];
assign tx_px_data1_g = lcd_odata_rgb[15:8];
assign tx_px_data1_b = lcd_odata_rgb[7:0];

assign parallel_clk     = tx_clkdiv4 ;
assign pll_clkoutphy_in = tx_clkdiv2 ;
assign pll_locked_in = tx_clkdiv2 ;
//-------------------------------------------------------------------------------
// 
// Begin two channel transmit example 
//

//
// Transmit reset Logic
//
assign tx_reset_int   = tx_reset;
assign lcd_pclk       = tx_px_clk;
//
// Transmit Clock Generator, only one required per design source
// all transmit interfaces
//
tx_clkgen_7to1 #(
        .CLKIN_PERIOD  ( 5),   // Reference clock period
        .USE_PLL       ("TRUE")   // Use MMCM instead of PLL
     )
     tx_clkgen (
        .clkin             (tx_refclk),
        .reset             (tx_reset_int),
        .clkoutphyen       (clkoutphyen),
        .pll_clkout0_out   (tx_clkdiv4),   // Transmit pixel clock for internal logic
        .pll_clkout1_out   (tx_px_clk),  // Transmit clock at 1/2 data rate
        .clkoutphy_out     (tx_clkdiv2),  // Transmit clock at 1/4 data rate
        .cmt_locked        (tx_locked)
     );

//
// Synchronize locked status to TX px_clk domain
//
always @ (posedge tx_px_clk or negedge tx_locked) //cr993494
begin
    if (!tx_locked)
       tx_px_locked <= 4'b000;
    else
       tx_px_locked <= {1'b1,tx_px_locked[3:1]};
end
assign tx_px_reset = ~tx_px_locked[0] ;


always @ (posedge tx_clkdiv4 or negedge tx_locked) //cr993494
begin
    if (!tx_locked)
       tx_div_locked <= 4'b000;
    else
       tx_div_locked <= {1'b1,tx_div_locked[3:1]};
end
assign tx_div_reset = ~tx_div_locked[0] ;

//
// TX Channel 1
//
tx_channel_7to1 #(
      .LINES          (4),           // 4 Data Lines
      .DATA_FORMAT    ("PER_LINE"),  // PER_CLOCK or PER_LINE data formatting
      .CLK_PATTERN    (7'b1100011),  // Clock bit pattern
      .TX_SWAP_MASK   (5'h0),        // Output inversion for P/N swap 0=Non Inverted, 1=Inverted
      .SIM_DEVICE     (SIM_DEVICE)
   )
   tx_channel1 (
      .px_data        (tx_px_data1),
      .px_reset       (tx_px_reset),
      .px_clk         (tx_px_clk),
      .div_reset      (tx_div_reset),
      .intf_rdy       (intf_rdy),
      .tx_locked      (tx_locked),
      .tx_clkdiv2     (tx_clkdiv2),
      .tx_clkdiv4     (tx_clkdiv4),
      .tx_enable      (tx_enable),
      .tx_data_clk    (tx_clk_data),
      .tx_data        (tx_data)
   );

//
// Transmit Data Generation
//
always @ (posedge tx_px_clk)
begin
   if (tx_px_reset) begin
      tx_px_data1[ 6:0 ] <= 7'h01;
      tx_px_data1[13:7 ] <= 7'h02;
      tx_px_data1[20:14] <= 7'h03;
      tx_px_data1[27:21] <= 7'h04;
   end
   else if(mode == 1'b0)begin //VESA Format2
      tx_px_data1[ 6:0 ] <= {tx_px_data1_r[0],tx_px_data1_r[1],tx_px_data1_r[2],tx_px_data1_r[3],tx_px_data1_r[4],tx_px_data1_r[5],tx_px_data1_g[0]};
      tx_px_data1[13:7 ] <= {tx_px_data1_g[1],tx_px_data1_g[2],tx_px_data1_g[3],tx_px_data1_g[4],tx_px_data1_g[5],tx_px_data1_b[0],tx_px_data1_b[1]};
      tx_px_data1[20:14] <= {tx_px_data1_b[2],tx_px_data1_b[3],tx_px_data1_b[4],tx_px_data1_b[5],lcd_hs,lcd_vs,lcd_de};
      tx_px_data1[27:21] <= {tx_px_data1_r[6],tx_px_data1_r[7],tx_px_data1_g[6],tx_px_data1_g[7],tx_px_data1_b[6],tx_px_data1_b[7],1'b0};
   end
   else if(mode == 1'b1)begin //VESA Format1
      tx_px_data1[ 6:0 ] <= {tx_px_data1_r[2],tx_px_data1_r[3],tx_px_data1_r[4],tx_px_data1_r[5],tx_px_data1_r[6],tx_px_data1_r[7],tx_px_data1_g[2]};
      tx_px_data1[13:7 ] <= {tx_px_data1_g[3],tx_px_data1_g[4],tx_px_data1_g[5],tx_px_data1_g[6],tx_px_data1_g[7],tx_px_data1_b[2],tx_px_data1_b[3]};
      tx_px_data1[20:14] <= {tx_px_data1_b[4],tx_px_data1_b[5],tx_px_data1_b[6],tx_px_data1_b[7],lcd_hs,lcd_vs,lcd_de};
      tx_px_data1[27:21] <= {tx_px_data1_r[0],tx_px_data1_r[1],tx_px_data1_g[0],tx_px_data1_g[1],tx_px_data1_b[0],tx_px_data1_b[1],1'b0};
   end
end


endmodule
