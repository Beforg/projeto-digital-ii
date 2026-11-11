library ieee; 
use ieee.std_logic_1164.all; 
entity control is 
	port ( 
		clk : in std_logic; 
		input : in std_logic; 
		enable, enable_out, sel_mux, sel_mux_out : in std_logic
		);
end control;

architecture behavior of control is
type state_type is (INIT,SUM,SUB,FIM);
signal current_state, next_state: state_type;
begin

	process(clk) -- registrador estado
	begin 
		if rising_edge(clk) then
			current_state <= next_state
	end process
	process() -- Proximo estado
	begin
		next_state <= state
		case state is 
			when INIT <=
			when SUM <=
			when SUB <=
			when FIM <=
			
			
	end process
	process() -- saidas

end architecture;