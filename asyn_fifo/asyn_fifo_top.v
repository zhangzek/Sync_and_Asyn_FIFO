`timescale 1 ns/ 1 ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ZHANG ZEKUN
// 
// Create Date: 2019/08/30 15:01:16
// Design Name: 
// Module Name: top
// Project Name:  Asynchronous FIFO
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 1.0 - 8.27 File Created 
// Revision 2.0 - 8.29 File Changed 
// Revision 3.0 - 8.30 Finish over
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module asyn_fifo_top#(
	parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 4,
	parameter RAM_DEPTH = 16
)
(
	input 					      WCLK,
	input                         WRSTn,
	input                         RCLK,
	input                         RRSTn,
	input                         write,
	input                         read,
	input  [ DATA_WIDTH - 1 : 0 ] wdata,
	output [ DATA_WIDTH - 1 : 0 ] rdata,
	output                        full,
	output                        empty
);

wire [ ADDR_WIDTH : 0 ]    wpt;
wire [ ADDR_WIDTH : 0 ]    rpt;
wire [ ADDR_WIDTH : 0 ]    rp2_wpt;
wire [ ADDR_WIDTH : 0 ]    wp2_rpt;
wire [ ADDR_WIDTH - 1: 0 ] waddr;
wire [ ADDR_WIDTH - 1: 0 ] raddr;

double_ram#(.DATA_WIDTH(DATA_WIDTH),
			.ADDR_WIDTH(ADDR_WIDTH),
			.RAM_DEPTH(RAM_DEPTH)) 
	ram_module (.WCLK(WCLK),
	            .write(write),
				.waddr(waddr),
				.wdata(wdata),
				.raddr(raddr),
				.rdata(rdata));
r2w_sync #(.ADDR_WIDTH(ADDR_WIDTH))
	r2w_module (.WCLK(WCLK),
				.WRSTn(WRSTn),
				.rpt(rpt),
				.rp2_wpt(rp2_wpt));
w2r_sync #(.ADDR_WIDTH(ADDR_WIDTH))
	w2r_module (.RCLK(RCLK),
				.RRSTn(RRSTn),
				.wpt(wpt),
				.wp2_rpt(wp2_rpt));
full#(.ADDR_WIDTH(ADDR_WIDTH)) 
	full_module(.WCLK(WCLK),
				.WRSTn(WRSTn),
				.write(write),
				.rp2_wpt(rp2_wpt),
				.wpt(wpt),
				.waddr(waddr),
				.full(full));
empty #(.ADDR_WIDTH(ADDR_WIDTH))
	empty_module(.RCLK(RCLK),
				 .RRSTn(RRSTn),
				 .read(read),
				 .wp2_rpt(wp2_rpt),
				 .rpt(rpt),
				 .raddr(raddr),
				 .empty(empty));


endmodule




