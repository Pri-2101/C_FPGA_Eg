library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture behav of FSM is
    type state_type is (SA, SB, SC);  -- defining a new type called state type for our convenience, alternatively, vectors can be used
    signal PS, NS : state_type;

begin
    sync_proc: process(CLK, NS)    --- When the next state value is calculated, the system's PS value is updated on a clock high other wise reset to S1.
    begin
	if(RST = '1') then
	    PS <= SA;
	elsif(rising_edge(CLK)) then
	    PS <= NS;
	end if;
    end process sync_proc;
	
    comb_proc: process(PS, In1)  -- the next state value is calculated when the system moves to a new state or gets a new input
    begin
	Out1 <= '0'; --preassign output
	case(PS) is
	    when SA => 
		Out1 <= '0';
		if(In1 = '1') then NS <= SB; 
		else NS <= SA; 
		end if;
	    
	    when SB =>
		Out1 <= '0';
		if(In1 = '0') then NS <= SC; 
		else NS <= SB; 
		end if;
	    when SC =>
		Out1 <= '1';
		if(In1 = '1') then NS <=SA;
		else NS <= SC;
		end if;
	    when others =>
		Out1 <= '0';
		NS <= SA;
	end case;
    end process comb_proc;
end architecture behav;
