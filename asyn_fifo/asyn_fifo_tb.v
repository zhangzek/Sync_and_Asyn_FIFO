module asyn_fifo_tb();

parameter DATA_WIDTH = 8;

	reg                         WCLK;
	reg                         WRSTn;
	reg                         RCLK;
	reg                         RRSTn;
	reg                         write;
	reg                         read;
	reg  [ DATA_WIDTH - 1 : 0 ] wdata;
	wire [ DATA_WIDTH - 1 : 0 ] rdata;
	wire                        full;
	wire                        empty;
	//integer                     i = 0;
	
initial 
begin
	WCLK <= 0;
	forever #100 WCLK = ~WCLK;
end

initial 
begin
	RCLK <= 0;
	forever #200 RCLK = ~RCLK;
end

initial 
begin
	WRSTn = 0;
	wdata = 0;
	#100 WRSTn = 1;
end

initial
begin
	RRSTn = 0;
	#100 RRSTn = 1;
end


always @ ( posedge WCLK or negedge WRSTn )
begin
	wdata <= wdata + 1'b1;
end

//always  @(posedge WCLK or negedge WRSTn)
//begin
//      if(WRSTn==1'b0)
//      begin
//         i <= 0;
//      end
//      else if(!full)
//      begin
//         i = i+1;
//      end
//      else begin
//         i <= i;
//      end
//end

//always @ (*)
//begin
//    if (!full)
//        wdata = i;
//    else 
//        wdata = 0;
//end


always @ ( full or WRSTn )
begin
	if (!WRSTn)
	begin
		write <= 0;
	end
	else if (!full)
	begin
		write <= 1;
	end
	else 
	begin
		write <= 0;
	end
end

always @ ( empty or RRSTn )
begin
	if (!RRSTn)
	begin
		read <= 0;
		
	end
	
	else if (!empty)
	begin
		read <= 1;
	end 
	else 
	begin
		read <= 0;
	end
end



asyn_fifo_top asyn_fifo(.WCLK(WCLK),
						.WRSTn(WRSTn),
						.RCLK(RCLK),
						.RRSTn(RRSTn),
						.write(write),
						.read(read),
						.wdata(wdata),
						.rdata(rdata),
						.full(full),
						.empty(empty));

endmodule