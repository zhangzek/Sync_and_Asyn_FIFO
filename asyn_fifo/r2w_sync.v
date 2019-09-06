/**Read to Write Sync module**/
module r2w_sync#(
	parameter ADDR_WIDTH = 4
)
(
	input 						  WRSTn,    //write RSTn
	input 					      WCLK,     //write CLK
	input      [ ADDR_WIDTH : 0 ] rpt,      //output to write port gray
	output reg [ ADDR_WIDTH : 0 ] rp2_wpt   //D trigger sync with two levels,second level
);


reg [ ADDR_WIDTH : 0 ] rp1_wpt;         //frist level
//reg [ ADDR_WIDTH : 0 ] rp2_wpt; 

always @ ( posedge WCLK or negedge WRSTn )
begin
	if ( !WRSTn )
	begin
		{ rp2_wpt,rp1_wpt } <= 0;
	end
	else 
	begin
		{ rp2_wpt,rp1_wpt } <= { rp1_wpt,rpt };
	end
end

endmodule