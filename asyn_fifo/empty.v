module empty#(
	parameter ADDR_WIDTH = 4
)
(
	input                           RRSTn,
	input                           RCLK,
	input                           read,
	input      [ ADDR_WIDTH : 0 ]   wp2_rpt,
	output reg [ ADDR_WIDTH : 0 ]   rpt,
	output reg [ ADDR_WIDTH - 1:0 ] raddr,
	output reg                      empty
);

reg  [ ADDR_WIDTH :0 ] rbin;
wire [ ADDR_WIDTH :0 ] rbin_next;
wire [ ADDR_WIDTH :0 ] rgray_next;
wire                   empty_reg;

always @ ( posedge RCLK or negedge RRSTn )
begin
	if (!RRSTn)
	begin
		rpt <= 0;
		rbin <= 0;
	end
	else 
	begin
		rpt <= rgray_next;
		rbin <= rbin_next;
	end
end

assign rbin_next = ( !empty ) ? ( rbin + read ) : rbin;
assign rgray_next = ( rbin_next >> 1 ) ^ rbin_next;
//assign raddr = rbin [ ADDR_WIDTH - 1:0 ];

always @ ( posedge RCLK or negedge RRSTn )
begin
	if (read)
	begin
	   raddr <= rbin [ ADDR_WIDTH - 1:0 ];
	end
	
end

always @ ( posedge RCLK or negedge RRSTn )
begin
	if (!RRSTn)
	begin
		empty <= 0;
	end
	else
	begin
		empty <= empty_reg;
	end
end

assign empty_reg = ( rgray_next == wp2_rpt );

endmodule 