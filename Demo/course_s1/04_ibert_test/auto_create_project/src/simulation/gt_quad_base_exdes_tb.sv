
//------------------------------------------------------------------------------
//  (c) Copyright 2017-2018 Advanced Micro Devices, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Advanced Micro Devices, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  AMD, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) AMD shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or AMD had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  AMD products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of AMD products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------

`timescale 1 ns / 1 fs

module ibert_example_top_sim ();


wire clk_PROT0_R0;
wire clk_PROT0_R1;
wire clk_PROT0_R2;
wire clk_PROT0_R3;
wire clk_PROT0_R4;
wire clk_PROT0_R5;

reg   clk_lr0_tx = 1'b0;
reg   clk_lr0_rx = 1'b0;
reg   apb_clk = 1'b0;
reg   gtreset;
reg [3:0]  rate_sel_ip0;
reg   link_status_ip0;
reg   txusrclk_ip0;
reg   rxusrclk_ip0;
reg   rpll_lock_ip0;
reg   lcpll_lock_ip0;
reg   tx_resetdone_out_ip0;
reg   rx_resetdone_out_ip0;
reg   gpio_enable_ip0 = 1'b0;




wire [3:0] GT_Serial_RX_rxn;
wire [3:0] GT_Serial_RX_rxp;
wire [3:0] GT_Serial_TX_txn;
wire [3:0] GT_Serial_TX_txp;
real t0;
real t1;
real t2;
real t3;
real frequency;

reg [1-1 : 0]PROT_PASS = 1'h0;
reg [1-1 : 0]TB_TIMEOUT = 1'h0;


assign GT_Serial_RX_rxp[0] = GT_Serial_TX_txp[0];
assign GT_Serial_RX_rxn[0] = GT_Serial_TX_txn[0];
assign GT_Serial_RX_rxp[1] = GT_Serial_TX_txp[1];
assign GT_Serial_RX_rxn[1] = GT_Serial_TX_txn[1];
assign GT_Serial_RX_rxp[2] = GT_Serial_TX_txp[2];
assign GT_Serial_RX_rxn[2] = GT_Serial_TX_txn[2];
assign GT_Serial_RX_rxp[3] = GT_Serial_TX_txp[3];
assign GT_Serial_RX_rxn[3] = GT_Serial_TX_txn[3];

always #3.2ns clk_lr0_tx =  ~clk_lr0_tx;
 
always #3.2ns clk_lr0_rx =  ~clk_lr0_rx;
always #2.5ns apb_clk = ~ apb_clk;
 
 
 
 


  reg [10:0] link_up_ctr_ip0 = 11'd0;
  reg        link_stable_ip0 = 1'b0;
  always @(posedge apb_clk) begin
    if (link_status_ip0 !== 1'b1) begin
      link_up_ctr_ip0 <= 11'd0;
      link_stable_ip0 <= 1'b0;
    end
    else begin
      if (&link_up_ctr_ip0)
        link_stable_ip0 <= 1'b1;
      else
        link_up_ctr_ip0 <= link_up_ctr_ip0 + 11'd1;
    end
  end



initial 
  begin
              rate_sel_ip0 = 4'h0;
              gtreset = 1'b0;
      #800ns  gtreset = 1'b1;
      #60ns;
              gtreset = 1'b0;
  end

initial 
  begin
              wait(lcpll_lock_ip0);
              $display("PROT0 CONFIG0:::::: PLL LOCKED ");



assign t2 = 161.1328125 - (161.1328125)*0.01;
assign t3 = 161.1328125 + (161.1328125)*0.01;
 

              wait( tx_resetdone_out_ip0);
              $display("PROT0 CONFIG0 TX RESET DONE asserted");
              @ (posedge txusrclk_ip0) t0 = $realtime;
              @ (posedge txusrclk_ip0) t1 = $realtime;
              frequency = 1000 / (t1 - t0);
              $display("PROT0 CONFIG0 POST PLL LOCK TXUSRCLK Frequency = %g", frequency);
              if ((frequency <= t3 ) &&  (frequency >=  t2))
              $display(" TX_USER CLOCK  PROPER TX_USER_CLOCK POST PLL LOCK is %g and EXPECTED is [%g:%g]",frequency, t2 , t3);
              else
              $display(" Error: TX_USER CLOCK IS NOT PROPER TX_USER_CLOCK POST PLL LOCK is %g and EXPECTED is [%g:%g]",frequency, t2 , t3);



assign t2 = 161.1328125 - (161.1328125)*0.01;
assign t3 = 161.1328125 + (161.1328125)*0.01;
              wait( rx_resetdone_out_ip0);
              $display("PROT0 CONFIG0 RX RESET DONE asserted");
              #2000ns;
              @ (posedge rxusrclk_ip0) t0 = $realtime;
              @ (posedge rxusrclk_ip0) t1 = $realtime;
              frequency = 1000 / (t1 - t0);
              $display("PROT0 CONFIG0 POST PLL LOCK RXUSRCLK Frequency = %g", frequency);
              if ((frequency <= t3 ) &&  (frequency >=  t2 ))
              $display("RX_USER CLOCK IS  PROPER RX_USER_CLOCK POST PLL LOCK is %g and EXPECTED is [%g:%g]",frequency, t2 , t3);
              else
              $display(" Error: RX_USER CLOCK IS NOT PROPER RX_USER_CLOCK POST PLL LOCK is %g and EXPECTED is [%g:%g]",frequency, t2 , t3);


              wait(link_stable_ip0); 
              @ (posedge txusrclk_ip0) t0 = $realtime;
              @ (posedge txusrclk_ip0) t1 = $realtime;
              frequency = 1000 / (t1 - t0);
              $display("PROT0 CONFIG0 :::::: POST LINK STABLE TXUSRCLK Frequency = %g", frequency);
      #100ns;
              @ (posedge rxusrclk_ip0) t0 = $realtime;
              @ (posedge rxusrclk_ip0) t1 = $realtime;
              frequency = 1000 / (t1 - t0);
              $display("PROT0 CONFIG0:::::: POST  LINK STABLE RXUSRCLK Frequency = %g", frequency);
        $display("Time : %12d ns   PROT0 CONFIG0: simulation completed", $time);

    
       PROT_PASS[0] = 1'b1;
         
end

initial 
  begin
      frequency = 161.1328125; 
      repeat (300000) @ (posedge apb_clk);
      if (frequency <= 150 )
      repeat (1500000) @ (posedge apb_clk);
      repeat (300000) @ (posedge apb_clk);

      TB_TIMEOUT[0] = 1'b1;
      $display("Time : %12d ns   PROT0 ::::: FAIL: simulation timeout. ", $time);

end

 
 
 
assign clk_PROT0_R0       =      
                                 (rate_sel_ip0 == 4'd0) ?  clk_lr0_rx : 
 
                                 (rate_sel_ip0 > 4'd0) ?  clk_lr0_rx : 
                                   clk_lr0_rx ; 
 
 
 
 
 
 
 
 
 
 









initial
  begin
        wait(&PROT_PASS); 
        $display("Time : %12d ns   PASS: simulation completed", $time);
        $display("**  Test completed successfully"); 

  $finish;
  end

initial
begin
   wait(&TB_TIMEOUT);
   $display("** Error: Test did not complete successfully"); 
   $finish;
end
 
reg  clk_refclk0 = 1'b0;
always #3.2ns clk_refclk0 =  ~clk_refclk0;


  ibert_exdes_bd_wrapper wrapper_inst
        (.gt_reset_ip0(gtreset),
 
        .ref_clk_0_n(clk_refclk0),
        .ref_clk_0_p(~clk_refclk0),
        .GT_Serial_grx_n(GT_Serial_RX_rxn),
        .GT_Serial_grx_p(GT_Serial_RX_rxp),
        .GT_Serial_gtx_n(GT_Serial_TX_txn),
        .GT_Serial_gtx_p(GT_Serial_TX_txp),
        .link_status_ip0(link_status_ip0),
        .rpll_lock_ip0(rpll_lock_ip0),
        .lcpll_lock_ip0(lcpll_lock_ip0),
        .tx_resetdone_out_ip0(tx_resetdone_out_ip0),
        .rx_resetdone_out_ip0(rx_resetdone_out_ip0),
        .txusrclk_ip0(txusrclk_ip0),
        .rxusrclk_ip0(rxusrclk_ip0),
        .gpio_enable_ip0(gpio_enable_ip0),
        .rate_sel_ip0(rate_sel_ip0),
        .apb3clk_quad(apb_clk),
        .apb3clk_bridge(apb_clk));

endmodule


