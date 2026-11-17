library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operativa is 
	port(
		x_in: in std_logic_vector(7 downto 0);
		y_in: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(7 downto 0);
		count_fim: out std_logic;
		-- Sinais vindos do controle
		enable: in std_logic;
		sel_init: in std_logic;
		clk: in std_logic
	);
end entity;

architecture behavioral of operativa is 
signal reg_p, mul_out, mux: std_logic_vector(7 downto 0);
signal reg_count, mux_count, sub_out: std_logic_vector(3 downto 0);

begin

	mul_out <= std_logic_vector(resize(unsigned(x_in) * unsigned(reg_p), 8));
	mux <= (0 => '1', others => '0') when sel_init = '1' else mul_out;
	mux_count <= y_in when sel_init = '1' else sub_out;
	sub_out <= std_logic_vector(unsigned(reg_count) - 1);
	
	process(clk)
	begin
		if rising_edge(clk) then
			if enable = '1' then
				reg_p <= mux;
				reg_count <= mux_count;
			end if;
		end if;
	end process;
	result <= reg_p;
	count_fim <= '1' when reg_count = "0001" else '0';
end architecture;