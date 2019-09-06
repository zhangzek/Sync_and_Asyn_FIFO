`timescale 1 ns/ 1 ps
module on_clk_fifo_tb();
	reg CLK;
	reg RSTn;
	reg write;
	reg read;
	reg [7:0] iData;
	
	wire [7:0] oData;
	wire full;
	wire empty;


initial
begin
	CLK <= 1'b0;
	forever #100 CLK <= ~CLK;
end


initial 
begin
	RSTn = 0;
	iData = 0;
	#100 RSTn = 1;
end
	
always @ (posedge CLK or negedge RSTn)
begin
	iData <= iData + 1'b1;
end

always @ (posedge CLK or negedge RSTn)
begin
	if (!RSTn)
		write = 0;
	else if (!full)
	begin
		write = 1;
	end
	else 
		write = 0;
end

always @ (posedge CLK or negedge RSTn)
begin
	if (!RSTn)
		read = 0;
	else if (!empty)
		read = 1;
	else 
		read = 0;
end


on_clk_fifo fifo (.CLK(CLK),
				  .RSTn(RSTn),
				  .write(write),
				  .read(read),
				  .iData(iData),
				  .full(full),
				  .empty(empty),
				  .oData(oData));
				  
endmodule