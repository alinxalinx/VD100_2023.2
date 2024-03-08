`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/23 14:48:48
// Design Name: 
// Module Name: rgmii_reset
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rgmii_reset#
(
	parameter REFCLK_HZ = 300000000,
	parameter INITIAL_HIGH_MS = 30, //ms
	parameter INITIAL_LOW_MS = 100 //ms
)
 (
	input			clk,
	input			rstn_in,
	output	reg		rstn_out

    );

localparam MS_COUNT = 	REFCLK_HZ/1000 ;

reg [31:0]		ms_cnt ;
reg [31:0]		rst_cnt ;
reg				hold ;

always @(posedge clk or negedge rstn_in)
begin
	if (~rstn_in)
		ms_cnt <= 0 ;
	else if (~hold)
	begin
		if (ms_cnt >= MS_COUNT-1)
			ms_cnt <= 0 ;
		else
			ms_cnt <= ms_cnt + 1 ;	
	end
end


always @(posedge clk or negedge rstn_in)
begin
	if (~rstn_in)
		rst_cnt <= 0 ;
	else if ((ms_cnt >= MS_COUNT-1) & ~hold)
		rst_cnt <= rst_cnt + 1 ;
end


always @(posedge clk or negedge rstn_in)
begin
	if (~rstn_in)
		rstn_out <= 1 ;
	else if (rst_cnt >= INITIAL_HIGH_MS+INITIAL_LOW_MS)
		rstn_out <= 1 ;
	else if (rst_cnt >= INITIAL_HIGH_MS)
		rstn_out <= 0 ;
end

always @(posedge clk or negedge rstn_in)
begin
	if (~rstn_in)
		hold <= 0 ;
	else if (rst_cnt >= INITIAL_HIGH_MS+INITIAL_LOW_MS)
		hold <= 1 ;
end

	
endmodule
