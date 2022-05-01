LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

--architecture

architecture behav of AAC2M2P1 is
	signal CE: std_logic;
	signal TC_Conc: std_logic_vector(4 downto 0);
	signal count: unsigned(3 downto 0) := "0000";
begin
	
	CE <= CEP AND CET AND PE;
	TC_Conc <= CET & std_logic_vector(count);
	TC <= '1' when (TC_Conc = "11111") else '0';
	Q <= std_logic_vector(count);

	update_proc: process(SR, CP, CEP, CET, PE, P)
	begin
	if(rising_edge(CP)) then
		if (SR = '0') then 
			count <= "0000";
		elsif (PE = '0') then 
			count <= unsigned(P);
		elsif (CE = '1') then
			count <= count + 1;
		elsif (CE = '0') then
			count <= count;
		else
			count <= "0000";
		end if;	
	end if;
	end process update_proc;

end architecture behav; 