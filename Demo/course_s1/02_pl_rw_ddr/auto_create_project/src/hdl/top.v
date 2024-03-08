`timescale 1ns / 1ps

module top(  
  output [0:0]	DDR4_act_n,
  output [16:0]	DDR4_adr,
  output [1:0]	DDR4_ba,
  output [0:0]	DDR4_bg,
  output [0:0]	DDR4_ck_c,
  output [0:0]	DDR4_ck_t,
  output [0:0]	DDR4_cke,
  output [0:0]	DDR4_cs_n,
  inout [7:0]	DDR4_dm_n,
  inout [63:0]	DDR4_dq,
  inout [7:0]	DDR4_dqs_c,
  inout [7:0]	DDR4_dqs_t,
  output [0:0]	DDR4_odt,
  output [0:0]	DDR4_reset_n,
  input [0:0]	sys_clk_n,
  input [0:0]	sys_clk_p
    );
	
	
(*mark_debug="true"*) wire error;	
	
wire rst_n;	
wire M_AXI_ACLK;
// Master Write Address
wire [0:0]  M_AXI_AWID;
(*mark_debug="true"*)wire [31:0] M_AXI_AWADDR;
(*mark_debug="true"*)wire [7:0]  M_AXI_AWLEN;    // Burst Length: 0-255
(*mark_debug="true"*)wire [2:0]  M_AXI_AWSIZE;   // Burst Size: Fixed 2'b011
(*mark_debug="true"*)wire [1:0]  M_AXI_AWBURST;  // Burst Type: Fixed 2'b01(Incremental Burst)
wire        M_AXI_AWLOCK;   // Lock: Fixed 2'b00
wire [3:0]  M_AXI_AWCACHE;  // Cache: Fiex 2'b0011
wire [2:0]  M_AXI_AWPROT;   // Protect: Fixed 2'b000
wire [3:0]  M_AXI_AWQOS;    // QoS: Fixed 2'b0000
wire [0:0]  M_AXI_AWUSER;   // User: Fixed 32'd0
(*mark_debug="true"*)wire        M_AXI_AWVALID;
(*mark_debug="true"*)wire        M_AXI_AWREADY;

// Master Write Data
(*mark_debug="true"*)wire [63:0] M_AXI_WDATA;
(*mark_debug="true"*)wire [7:0]  M_AXI_WSTRB;
(*mark_debug="true"*)wire        M_AXI_WLAST;
(*mark_debug="true"*)wire [0:0]  M_AXI_WUSER;
(*mark_debug="true"*)wire        M_AXI_WVALID;
(*mark_debug="true"*)wire        M_AXI_WREADY;

// Master Write Response
wire [0:0]   M_AXI_BID;
(*mark_debug="true"*)wire [1:0]   M_AXI_BRESP;
(*mark_debug="true"*)wire [0:0]   M_AXI_BUSER;
(*mark_debug="true"*)wire         M_AXI_BVALID;
(*mark_debug="true"*)wire         M_AXI_BREADY;
    
// Master Read Address
wire [0:0]  M_AXI_ARID;
(*mark_debug="true"*)wire [31:0] M_AXI_ARADDR;
(*mark_debug="true"*)wire [7:0]  M_AXI_ARLEN;
(*mark_debug="true"*)wire [2:0]  M_AXI_ARSIZE;
(*mark_debug="true"*)wire [1:0]  M_AXI_ARBURST;
wire        M_AXI_ARLOCK;
wire [3:0]  M_AXI_ARCACHE;
wire [2:0]  M_AXI_ARPROT;
wire [3:0]  M_AXI_ARQOS;
wire [0:0]  M_AXI_ARUSER;
(*mark_debug="true"*)wire        M_AXI_ARVALID;
(*mark_debug="true"*)wire        M_AXI_ARREADY;
    
// Master Read Data 
wire [0:0]   M_AXI_RID;
(*mark_debug="true"*)wire [63:0]  M_AXI_RDATA;
(*mark_debug="true"*)wire [1:0]   M_AXI_RRESP;
(*mark_debug="true"*)wire         M_AXI_RLAST;
(*mark_debug="true"*)wire [0:0]   M_AXI_RUSER;
(*mark_debug="true"*)wire         M_AXI_RVALID;
(*mark_debug="true"*)wire         M_AXI_RREADY;

(*mark_debug="true"*)wire wr_burst_data_req;
(*mark_debug="true"*)wire wr_burst_finish;
(*mark_debug="true"*)wire rd_burst_finish;
(*mark_debug="true"*)wire rd_burst_req;
(*mark_debug="true"*)wire wr_burst_req;
(*mark_debug="true"*)wire[9:0] rd_burst_len;
(*mark_debug="true"*)wire[9:0] wr_burst_len;
(*mark_debug="true"*)wire[31:0] rd_burst_addr;
(*mark_debug="true"*)wire[31:0] wr_burst_addr;
(*mark_debug="true"*)wire rd_burst_data_valid;
(*mark_debug="true"*)wire[63 : 0] rd_burst_data;
(*mark_debug="true"*)wire[63 : 0] wr_burst_data;

mem_test
#(
	.MEM_DATA_BITS(64),
	.ADDR_BITS(27)
)
mem_test_m0
(
	.rst(~rst_n),                                 
	.mem_clk(M_AXI_ACLK),                             
	.rd_burst_req(rd_burst_req),               
	.wr_burst_req(wr_burst_req),               
	.rd_burst_len(rd_burst_len),               
	.wr_burst_len(wr_burst_len),               
	.rd_burst_addr(rd_burst_addr),        
	.wr_burst_addr(wr_burst_addr),        
	.rd_burst_data_valid(rd_burst_data_valid),  
	.wr_burst_data_req(wr_burst_data_req),  
	.rd_burst_data(rd_burst_data),  
	.wr_burst_data(wr_burst_data),    
	.rd_burst_finish(rd_burst_finish),   
	.wr_burst_finish(wr_burst_finish),

	.error(error)
); 
aq_axi_master u_aq_axi_master
(
	.ARESETN(rst_n),
	.ACLK(M_AXI_ACLK),
	
	.M_AXI_AWID(M_AXI_AWID),
	.M_AXI_AWADDR(M_AXI_AWADDR),     
	.M_AXI_AWLEN(M_AXI_AWLEN),
	.M_AXI_AWSIZE(M_AXI_AWSIZE),
	.M_AXI_AWBURST(M_AXI_AWBURST),
	.M_AXI_AWLOCK(M_AXI_AWLOCK),
	.M_AXI_AWCACHE(M_AXI_AWCACHE),
	.M_AXI_AWPROT(M_AXI_AWPROT),
	.M_AXI_AWQOS(M_AXI_AWQOS),
	.M_AXI_AWUSER(M_AXI_AWUSER),
	.M_AXI_AWVALID(M_AXI_AWVALID),
	.M_AXI_AWREADY(M_AXI_AWREADY),
	
	.M_AXI_WDATA(M_AXI_WDATA),
	.M_AXI_WSTRB(M_AXI_WSTRB),
	.M_AXI_WLAST(M_AXI_WLAST),
	.M_AXI_WUSER(M_AXI_WUSER),
	.M_AXI_WVALID(M_AXI_WVALID),
	.M_AXI_WREADY(M_AXI_WREADY),
	
	.M_AXI_BID(M_AXI_BID),
	.M_AXI_BRESP(M_AXI_BRESP),
	.M_AXI_BUSER(M_AXI_BUSER),
	.M_AXI_BVALID(M_AXI_BVALID),
	.M_AXI_BREADY(M_AXI_BREADY),
	
	.M_AXI_ARID(M_AXI_ARID),
	.M_AXI_ARADDR(M_AXI_ARADDR),
	.M_AXI_ARLEN(M_AXI_ARLEN),
	.M_AXI_ARSIZE(M_AXI_ARSIZE),
	.M_AXI_ARBURST(M_AXI_ARBURST),
	.M_AXI_ARLOCK(M_AXI_ARLOCK),
	.M_AXI_ARCACHE(M_AXI_ARCACHE),
	.M_AXI_ARPROT(M_AXI_ARPROT),
	.M_AXI_ARQOS(M_AXI_ARQOS),
	.M_AXI_ARUSER(M_AXI_ARUSER),
	.M_AXI_ARVALID(M_AXI_ARVALID),
	.M_AXI_ARREADY(M_AXI_ARREADY),
	
	.M_AXI_RID(M_AXI_RID),
	.M_AXI_RDATA(M_AXI_RDATA),
	.M_AXI_RRESP(M_AXI_RRESP),
	.M_AXI_RLAST(M_AXI_RLAST),
	.M_AXI_RUSER(M_AXI_RUSER),
	.M_AXI_RVALID(M_AXI_RVALID),
	.M_AXI_RREADY(M_AXI_RREADY),
	
	.MASTER_RST(~rst_n),
	
	.WR_START(wr_burst_req),
	.WR_ADRS({wr_burst_addr[28:0],3'd0}),
	.WR_LEN({wr_burst_len,3'd0}), 
	.WR_READY(),
	.WR_FIFO_RE(wr_burst_data_req),
	.WR_FIFO_EMPTY(1'b0),
	.WR_FIFO_AEMPTY(1'b0),
	.WR_FIFO_DATA(wr_burst_data),
	.WR_DONE(wr_burst_finish),
	
	.RD_START(rd_burst_req),
	.RD_ADRS({rd_burst_addr[28:0],3'd0}),
	.RD_LEN({rd_burst_len,3'd0}), 
	.RD_READY(),
	.RD_FIFO_WE(rd_burst_data_valid),
	.RD_FIFO_FULL(1'b0),
	.RD_FIFO_AFULL(1'b0),
	.RD_FIFO_DATA(rd_burst_data),
	.RD_DONE(rd_burst_finish),
	.DEBUG()                                         
);

	
design_1_wrapper ps_block
(
    	
	.S_AXI_araddr       (M_AXI_ARADDR          ),
	.S_AXI_arburst      (M_AXI_ARBURST         ),
	.S_AXI_arcache      (M_AXI_ARCACHE         ),
	.S_AXI_arid         (M_AXI_ARID            ),
	.S_AXI_arlen        (M_AXI_ARLEN           ),
	.S_AXI_arlock       (M_AXI_ARLOCK          ),
	.S_AXI_arprot       (M_AXI_ARPROT          ),
	.S_AXI_arqos        (M_AXI_ARQOS           ),
	.S_AXI_arready      (M_AXI_ARREADY         ),
	.S_AXI_arsize       (M_AXI_ARSIZE          ),
	.S_AXI_arvalid      (M_AXI_ARVALID         ),
	.S_AXI_rdata        (M_AXI_RDATA           ),
	.S_AXI_rid          (M_AXI_RID             ),
	.S_AXI_rlast        (M_AXI_RLAST           ),
	.S_AXI_rready       (M_AXI_RREADY          ),
	.S_AXI_rresp        (M_AXI_RRESP           ),
	.S_AXI_rvalid       (M_AXI_RVALID          ),		
	.S_AXI_awaddr       (M_AXI_AWADDR          ),
	.S_AXI_awburst      (M_AXI_AWBURST         ),
	.S_AXI_awcache      (M_AXI_AWCACHE         ),
	.S_AXI_awid         (M_AXI_AWID            ),
	.S_AXI_awlen        (M_AXI_AWLEN           ),
	.S_AXI_awlock       (M_AXI_AWLOCK          ),
	.S_AXI_awprot       (M_AXI_AWPROT          ),
	.S_AXI_awqos        (M_AXI_AWQOS           ),
	.S_AXI_awready      (M_AXI_AWREADY         ),
	.S_AXI_awsize       (M_AXI_AWSIZE          ),
	.S_AXI_awvalid      (M_AXI_AWVALID         ),
	.S_AXI_bid          (M_AXI_BID             ),
	.S_AXI_bready       (M_AXI_BREADY          ),
	.S_AXI_bresp        (M_AXI_BRESP           ),
	.S_AXI_bvalid       (M_AXI_BVALID          ),
	.S_AXI_wdata        (M_AXI_WDATA           ),
	.S_AXI_wlast        (M_AXI_WLAST           ),
	.S_AXI_wready       (M_AXI_WREADY          ),
	.S_AXI_wstrb        (M_AXI_WSTRB           ),
	.S_AXI_wvalid       (M_AXI_WVALID          ),
	
	.DDR4_act_n         (DDR4_act_n    ),
	.DDR4_adr           (DDR4_adr      ),
	.DDR4_ba            (DDR4_ba       ),
	.DDR4_bg            (DDR4_bg       ),
	.DDR4_ck_c          (DDR4_ck_c     ),
	.DDR4_ck_t          (DDR4_ck_t     ),
	.DDR4_cke           (DDR4_cke      ),
	.DDR4_cs_n          (DDR4_cs_n     ),
	.DDR4_dm_n          (DDR4_dm_n     ),
	.DDR4_dq            (DDR4_dq       ),
	.DDR4_dqs_c         (DDR4_dqs_c    ),
	.DDR4_dqs_t         (DDR4_dqs_t    ),
	.DDR4_odt           (DDR4_odt      ),
	.DDR4_reset_n       (DDR4_reset_n  ),
	.sys_clk_p(sys_clk_p),
	.sys_clk_n(sys_clk_n),
	.axi_resetn(rst_n),
	.axi_clk(M_AXI_ACLK)
);
endmodule
