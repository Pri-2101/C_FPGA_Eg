module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output [3:0]Q,        // Parallel Output 	
    output RCO            // Ripple Carry Output (Terminal Count)
); 

    //wire [3:0]Q;
    reg [3:0] count;
    wire CE;

    assign CE = ENP & ENT & LOAD_n; 

    wire tc_conc;
    assign tc_conc = {ENT,count};
    assign RCO = &(tc_conc);

    always@(CLR_n)
	begin
    	    count = CLR_n?4'b0000:count;
	end
    
    assign Q = count;
    always@(posedge(CLK))
    begin
	if(LOAD_n == 0)
	    count = D;
	
	else
	begin
	    if(CE == 1)
	        count = count + 1;
	    else
	    begin
    	        if(CE == 0)
	            count = count;
                else
	            count = 0;
	    end
	end
	    
    end
endmodule