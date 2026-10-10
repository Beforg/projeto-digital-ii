
library ieee;
use ieee.std_logic_1164.all;

entity PC_Sub is
    PORT (
		clk: in std_logic;
		reset: in std_logic;
		enable_inputs: out std_logic_vector;
		ctrl_mux1, ctrl_mux2: out std_logic;
		en_regAdder: out std_logic
    );
END PC_Sub;

architecture BEHAVIOR of PC_Sub is

   type type_state is (state1, state2, state3, state4); -- Declaracao de um tipo estado.
   
   signal state, next_state: type_state;

begin

    process (clk) --implementar o registrador de estado (bloco sequencial)
		if rising_edge(clk): 
    begin
		
    end process;

    process () -- calcular o proximo estado (bloco combinacional)
    begin
    end process;
	 
    process () -- calcular os sinais de controle
    begin
	
    end process;       
	 
end behavior;
