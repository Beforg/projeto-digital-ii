library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	-- Fio de saida do Reg. Contador, Fio de saida do Mux do contador, Fio de saida do Subtrator
	signal out_ffsub, fmux_comp, out_sub: std_logic_vector(2 downto 0);
	-- Saida do Mux de multiplicacao, fio de saida do acumulador da mult. e resultado da multiplicacao
	signal fmux_mult, out_ffmul, out_mul: std_logic_vector(19 downto 0);
	-- enable para as memorias
	signal enable: std_logic;
	signal conta_inteira : unsigned(22 downto 0);
begin
	conta_inteira <= unsigned(x) * unsigned(out_ffmul);
	out_mul <= std_logic_vector(conta_inteira(19 downto 0)); 
	out_sub <= std_logic_vector(unsigned(out_ffsub) - 1);
	enable <= '0' when out_ffsub = "000" else '1';
	fmux_comp <= y when start = '1' else out_sub;
	fmux_mult <= std_logic_vector(to_unsigned(1, 20)) when start = '0' else out_mul;
	
	process(clock)
	begin
		if rising_edge(clock) then
			if enable = '1' or start = '1' then
				out_ffmul <= fmux_mult;
				out_ffsub <= fmux_comp;
			end if;
		end if;
	end process;
	result <= out_ffmul;
end behavior;