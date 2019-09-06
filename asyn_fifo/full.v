module full#(
	parameter ADDR_WIDTH = 4
)
(
	input                           WRSTn,
	input                           WCLK,
	input                           write,
	input      [ ADDR_WIDTH : 0 ]   rp2_wpt,
	output reg [ ADDR_WIDTH : 0 ]   wpt,
	output     [ ADDR_WIDTH - 1:0 ] waddr,
	output reg                      full
);

reg  [ ADDR_WIDTH :0 ] wbin;
wire [ ADDR_WIDTH :0 ] wbin_next;
wire [ ADDR_WIDTH :0 ] wgray_next;
wire                   full_reg;

always @ ( posedge WCLK or negedge WRSTn )
begin
	if (!WRSTn)
	begin
		wpt <= 0;
		wbin <= 0;
	end
	else 
	begin
		wpt <= wgray_next;
		wbin <= wbin_next;
	end
end

assign wbin_next = ( !full ) ? ( wbin + write ) : wbin;
assign wgray_next = ( wbin_next >> 1 ) ^ wbin_next;
assign waddr = wbin [ ADDR_WIDTH - 1:0 ];


always @ ( posedge WCLK or negedge WRSTn )
begin
	if (!WRSTn)
	begin
		full <= 0;
	end
	else
	begin
		full <= full_reg;
	end
end

assign full_reg = ( wgray_next == { -rp2_wpt [ ADDR_WIDTH : ADDR_WIDTH - 1],rp2_wpt [ ADDR_WIDTH - 2:0]});

endmodule 