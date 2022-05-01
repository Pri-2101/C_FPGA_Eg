module FIFO8x9(
  input clk, rst,
  input RdPtrClr, WrPtrClr, 
  input RdInc, WrInc,
  input [8:0] DataIn,
  output [8:0] DataOut,
  input rden, wren
	);
//signal declarations

	reg [8:0] fifo_array[7:0];
	reg [7:0] wrptr, rdptr;
	integer i;
	//wire [7:0] wr_cnt, rd_cnt;
	
	//Reading Process
	always@(posedge clk)
	begin
	    if(RdPtrClr == 1)
		rdptr = 0;
	    if(RdInc == 1)
		rdptr = rdptr+1;
	end

	//Writing Process
	always@(posedge clk)
	begin
	    if(rst == 1)
	    begin
		for(i = 0; i < 8; i = i+1)
		    fifo_array[i] = 0;
	    end

	    if(WrPtrClr == 1)
		wrptr = 0;

	    if(wren == 1)
		fifo_array[wrptr] = DataIn;

	    if(WrInc == 1)
		wrptr = wrptr+1;
	end

	

         assign DataOut = rden?9'bzzzzzzzzz:fifo_array[rdptr];
	
endmodule