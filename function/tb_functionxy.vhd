library ieee;
use ieee.std_logic_1164.all;

entity tb_functionxy is
end entity;

architecture sim of tb_functionxy is

component top_level is
    port (
        clk_top       : in  std_logic;
        rst_top       : in  std_logic;
        start_top     : in  std_logic;
        x: in std_logic_vector(7 downto 0);
		  y: in std_logic_vector(3 downto 0);
        result_top    : out std_logic_vector(7 downto 0)
    );
end component;

signal tb_clk, tb_rst, tb_start: std_logic;
signal tb_x, tb_result: std_logic_vector(7 downto 0);
signal tb_y: std_logic_vector(3 downto 0);

constant CLK_PERIOD : time := 20 ns;

begin

	dut: top_level
		port map(
			clk_top => tb_clk,
			rst_top => tb_rst,
			start_top => tb_start,
			x => tb_x,
			y => tb_y,
			result_top => tb_result
		);
	
	clk_process: process
	begin
		tb_clk <= '0'; 
		wait for CLK_PERIOD / 2;
		tb_clk <= '1';
		wait for CLK_PERIOD / 2;
	end process;
	
	simulation_process: process
	begin
        tb_rst <= '1';
        tb_start <= '0';
        wait for CLK_PERIOD;
        
        tb_rst <= '0';
        wait for CLK_PERIOD;

        -- Teste 1: Calcular 3 elevado a 3 (3^3 = 27)
        tb_x <= "00000011"; -- x = 3
        tb_y <= "0011"; -- y = 3
        
        -- Dá um pulso no Start para a FSM sair do INIT e ir para CALC
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';

        -- Espera tempo suficiente para o circuito multiplicar (y ciclos)
        wait for CLK_PERIOD * 5; 

        -- Teste 2: Se quiser testar outro valor, ex: 2^4 = 16
        tb_x <= "00000010"; -- x = 3
        tb_y <= "0100"; -- y = 3 
        
        tb_start <= '1';
        wait for CLK_PERIOD;
        tb_start <= '0';
        
        wait for CLK_PERIOD * 6;

        -- Pausa a simulação
        wait;
	end process;

end architecture;

