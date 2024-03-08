`timescale 1ps/1ps

module async2sync#
(
	parameter SYNC_STAGE = 3,
	parameter WIDTH = 3,
	parameter RESET_INIT_VALUE = {WIDTH{1'b0}}
)
(
  input [WIDTH-1:0]		data_in,  
  input	 clk_sync,
  input	 rstn_sync,
  output [WIDTH-1:0]	data_out

);

  reg [WIDTH-1:0] sync_data [SYNC_STAGE-1:0];

  genvar i;
  generate for(i=0;i<SYNC_STAGE;i=i+1)
  begin:data_sync
	always @(posedge clk_sync) 
	begin
		if (!rstn_sync)
			sync_data[i] <= RESET_INIT_VALUE[i];
		else
		begin
			if (i==0)
				sync_data[i] <= data_in ;
			else
				sync_data[i] <= sync_data[i-1] ;
		end
	end
  end	
  endgenerate
  assign data_out = sync_data[SYNC_STAGE-1];


endmodule