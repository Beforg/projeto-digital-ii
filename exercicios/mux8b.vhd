library ieee;
use ieee.std_logic_1164.ALL;

entity mux_8b is 
	port(
		x: in std_logic_vector(7 downto 0);
		ctrlMux: in std_logic;
		outMux1: out std_logic_vector(7 downto 0)
	);
end mux_8b;

architecture behavior of mux_8b is
begin
	outMux1 <= x when ctrlMux = '0' else
			"00000001";
end behavior;