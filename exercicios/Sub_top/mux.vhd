library ieee;
use ieee.std_logic_1164.all;

entity mux is 
  generic (
  	datawidth: natural:= 8
  );
  port (
	Crtl_mux1: in std_logic;
	x: in std_logic_vector ((datawidth-1) downto 0);
	outMux: out std_logic_vector ((datawidth-1) downto 0)
  );
end mux;

architecture mux1  of mux is
begin
  outMux <= x when Crtl_mux1 = '0'else
             (0=>'1', others=> '0'); 		
end mux1;

