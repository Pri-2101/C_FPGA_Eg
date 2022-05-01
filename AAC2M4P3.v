module FSM
#(parameter state_width = 2,
    SA = 2'b00,
    SB = 2'b01,
    SC = 2'b10
)
(//ports
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);

    reg [state_width -1:0]current_state;
    reg [state_width -1:0]next_state;

    //combinational logic i.e. calculating the next state
    always@(In1 or current_state)
    begin
        case(current_state)
	    SA: begin
	        if(In1 == 1) 
		    next_state = SB;
	        if(In1 == 0) 
		    next_state = SA;
	        Out1 = 0;
	    	end
	    
	    SB: begin
	        if(In1) 
		    next_state = SB;
	        if(In1 == 0) 
		    next_state = SC;
	        Out1 = 0;
		end
	   
	    SC:	begin
	        if(In1) 
		    next_state = SA;
	        if(In1 == 0) 
		    next_state = SC;
	        Out1 = 1;
		end
	   
	    default:
	    begin
	        next_state = SA;
		Out1 = 0;
	    end
	endcase
    end

    // sync process
    always@(posedge CLK or negedge RST)
    begin
        if(RST == 0)
	    current_state = SA;
	else
	    current_state = next_state;
    end
endmodule