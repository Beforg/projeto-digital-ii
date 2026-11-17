library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port (
        clk_top       : in  std_logic;
        rst_top       : in  std_logic;
        start_top     : in  std_logic;
        x: in std_logic_vector(7 downto 0);
		  y: in std_logic_vector(3 downto 0);
        result_top    : out std_logic_vector(7 downto 0)
    );
end entity;

architecture structural of top_level is
component operativa is 
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
end component;

component controle is
    port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        start     : in  std_logic;
        count_fim : in  std_logic; -- Flag que avisa que a contagem acabou
        sel_init  : out std_logic;
        enable    : out std_logic
    );
end component;

signal fio_count_fim, fio_enable, fio_sel_ini: std_logic; 
begin
	OP:operativa
		port map(
			x_in => x,
			y_in => y,
			result => result_top,
			count_fim=> fio_count_fim,
			enable => fio_enable,
			sel_init => fio_sel_ini,
			clk => clk_top
		);
	CTRL:controle
		port map(
			clk => clk_top,
			rst => rst_top,
			start => start_top,
			count_fim => fio_count_fim,
			sel_init => fio_sel_ini,
			enable => fio_enable
		);
	
end architecture;