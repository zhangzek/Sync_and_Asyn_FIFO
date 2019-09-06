/**Write to Read Sync module**/
module w2r_sync#(
	parameter ADDR_WIDTH = 4
)
(
	input 						  RRSTn,    //read RSTn
	input 						  RCLK,     //reaf CLK
	input      [ ADDR_WIDTH : 0 ] wpt,      //output to read port gray
	output reg [ ADDR_WIDTH : 0 ] wp2_rpt   //D trigger sync with two levels,second level
);

reg [ ADDR_WIDTH : 0 ] wp1_rpt;         //frist level
//reg [ ADDR_WIDTH : 0 ] wp2_rpt;   

always @ ( posedge RCLK or negedge RRSTn )
begin
	if ( !RRSTn )
	begin
		{ wp2_rpt,wp1_rpt } <= 0;
	end
	else 
	begin
		{ wp2_rpt,wp1_rpt } <= { wp1_rpt,wpt};
	end
end

endmodule 