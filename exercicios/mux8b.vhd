library ieee;
use ieee.std_logic_1164.ALL;

entity mux_8b is 
	generic(
		datawidth: natural:= 8 -- padronizando largura
	);
	port(
		x: in std_logic_vector(datawidth);
		ctrlMux: in std_logic;
		outMux1: out std_logic_vector(datawidth)
	);
end mux_8b;

architecture behavior of mux_8b is
begin
	outMux1 <= x when ctrlMux = '0' else
			(0=>'1', others=>'0');
end behavior;