library ieee;
use ieee.std_logic_1164.all;

entity muxB is 
  generic (
  	datawidth: natural:= 8
  );
  port (
	Crtl_mux1: in std_logic;
	z: in std_logic_vector ((datawidth-1) downto 0);
    y: in std_logic_vector ((datawidth-1) downto 0);
	outMux: out std_logic_vector ((datawidth-1) downto 0)
  );
end muxB;

architecture mux2  of muxB is
begin
  outMux <= z when Crtl_mux1 = '0'else
             y; 		
end mux2;

