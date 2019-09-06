/**Double Port RAM module**/
module double_ram#(
	parameter DATA_WIDTH = 8,
	parameter ADDR_WIDTH = 4,
	parameter RAM_DEPTH = 16
)
(	
	input                       WCLK,   //write clk
	input 					    write,  //write en
	input  [ ADDR_WIDTH - 1:0 ] waddr,  //write address from full.v
	input  [ DATA_WIDTH - 1:0 ] wdata,  //write data
	input  [ ADDR_WIDTH - 1:0 ] raddr,  //read address from empty.v
	output  [ DATA_WIDTH - 1:0 ] rdata   //read data
);

reg [ DATA_WIDTH - 1:0 ] RAM [ RAM_DEPTH - 1:0 ];  //double Port ram


always @ ( posedge WCLK )
begin
	if ( write == 1'b1 )
	begin
		RAM [ waddr ] <= wdata; 
	end
	else
	begin
		RAM [ waddr ] <= RAM [ waddr ];
	end
end

assign rdata = RAM [ raddr ];

endmodule