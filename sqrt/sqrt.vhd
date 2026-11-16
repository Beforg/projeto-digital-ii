library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity sqrt is 
	port (
		i: in std_logic_vector(7 downto 0);
		rst: in std_logic;
		clk: in std_logic;
		enable: in std_logic;
		r_out: out std_logic_vector(7 downto 0);
		t: out std_logic
	);
end sqrt;

architecture behavioral of sqrt is 
signal reg_r, reg_d, reg_s: std_logic_vector(7 downto 0) := (others =>'0');
signal mux_out_r, mux_out_d, mux_out_s: std_logic_vector(7 downto 0);
signal sum_out_r, sum_out_d, sum_out_s, sum_out_d_s, sub_out: std_logic_vector(7 downto 0);

begin

	sum_out_r <= std_logic_vector(unsigned(reg_r) + 1);
	sum_out_d <= std_logic_vector(unsigned(reg_d) + 2);
	sum_out_s <= std_logic_vector(unsigned(reg_s) + 1);
	sum_out_d_s <= std_logic_vector(unsigned(sum_out_d) + unsigned(sum_out_s));
	sub_out <= std_logic_vector(unsigned(i) - unsigned(sum_out_d_s));
	
	mux_out_r <= (0 => '1', others => '0') when rst = '1' else 
					sum_out_r;
	mux_out_d <= (1 => '1', others => '0') when rst = '1' else 
					sum_out_d;
	mux_out_s <= (2 => '1', others => '0') when rst = '1' else 
					sum_out_d_s;
	process(clk)
	begin
		if rising_edge(clk) then
			if enable = '1' then
				reg_r <= mux_out_r;
				reg_d <= mux_out_d;
				reg_s <= mux_out_s;
			end if;
		end if;
	end process;
	r_out <= reg_r;
	t <= std_logic(sub_out(7));
end architecture;