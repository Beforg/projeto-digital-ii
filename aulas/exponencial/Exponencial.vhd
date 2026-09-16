library ieee;
use ieee.std_logic_1164.all;
use iee.numeric_std.all;;

entity Exponencial is
	port(
		x: in std_logic_vector(2 downto 0);
		y: in std_logic_vector(2 downto 0);
		clock: in std_logic;
		start: in std_logic;
		result: out std_logic_vector(19 downto 0)
	);
end Exponencial;

architecture behavior of Exponencial is
	signal fmux_mult, fmux_comp,, out_sub: std_logic_vector(2 downto 0);
	signal out_ffsub, out_ffmul, out_mul: std_logic_vector(19 downto 0);
	signal enable: std_logic;
begin
	out_mul <= std_logic_vector(unsigned(x) * unsigned(out_ff)
end behavior;