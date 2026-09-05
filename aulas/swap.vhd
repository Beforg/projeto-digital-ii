library ieee;
use ieee.std_logic_1163.all;
use ieee.numeric_std.all;

entity Swap is 
	port(
		a: in std_logic_vector;
		b: in std_logic_vector;
		out1: out std_logic_vector;
		out2: out std_logic_vector;
		ativo: in std_logic_vector;
	);
end Ula;

architecture behavior of Swap is
	process(ativo)
		if ativo = '0' then
			out1 <= a;
			out2 <= b;
		else
			out1 <= b;
			out2 <= a;
	end process
	
end behavior;