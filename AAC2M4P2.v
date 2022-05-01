module RAM128x32 
#(parameter Data_width = 32, Addr_width = 7) 
(  //ports
    input wire clk,
    input wire we,
    input wire [(Addr_width-1):0] address, 
    input wire [(Data_width-1):0] d,
    output wire [(Data_width - 1):0] q
  );
 
    //output [(Data_width - 1) :0]q;
    

    reg [(Data_width - 1) :0]RAM[(2**Addr_width) - 1:0];
    reg [(Data_width - 1):0]data_reg;

    always@(posedge clk)
    begin
	if(we == 1)
	    RAM[address] <= d;
	    data_reg <= RAM[address];
    end

   
    assign q = RAM[address];
    
endmodule