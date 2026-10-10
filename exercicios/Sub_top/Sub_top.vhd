library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Sub_top is

	generic (
		datawidth_top: natural:= 8
	);
  
    port(
        X_e : in std_logic_vector((datawidth_top-1) downto 0);
        Y_e : in std_logic_vector((datawidth_top-1) downto 0);
        Sel: in std_logic;
        Z_e : out std_logic_vector((datawidth_top-1) downto 0)
    );

end Sub_top;

architecture rtl of Sub_top is

component registrador is 
    generic (
        datawidth: natural:= 8
    );
    
    port (
        entrada: in std_logic_vector((datawidth - 1) downto 0);
        clk, en: in std_logic;
        saida: out std_logic_vector((datawidth - 1) downto 0)
    );
end registrador;

component somador is

	generic (
		datawidth: natural:= 8
	);

    port (
        a    : in  std_logic_vector((datawidth-1) downto 0);
        b    : in  std_logic_vector((datawidth-1) downto 0);
        soma : out std_logic_vector((datawidth-1) downto 0)
    );
end component;

component mux is 
  generic (
	   datawidth: natural:= 8
  );
  port (
	Crtl_mux1: in std_logic;
	x: in std_logic_vector ((datawidth-1) downto 0);
	outMux: out std_logic_vector ((datawidth-1) downto 0)
  );
end component;

component muxB is 
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



signal outMux1, outMux2: std_logic_vector ((datawidth_top-1) downto 0);
signal outRegA, outRegB, outRegC: std_logic_vector ((datawidth_top-1) downto 0);
signal clk, en: std_logic;

begin
	clk <= '1';
	en <= '1';

	RegistradorA : registrador
	generic map (datawidth => datawidth_top)
	port map(entrada => X_e,  saida => outRegA, clk => clk, en => en);
	MuxA: mux
	generic map (datawidth => datawidth_top)
	port map (Crtl_mux1 => Sel, x => outRegA, outmux => outMux1);

	RegistradorB : registrador
	generic map (datawidth => datawidth_top)
	port map(entrada => Y_e,  saida => outRegB, clk => clk, en => en);

	RegistradorC: registrador
	generic map (datawidth => datawidth_top)
	port map(entrada => Z_e,  saida => outRegC, clk => clk, en => en);

	MuxB1: muxB
	generic map (datawidth => datawidth_top)
	port map (Crtl_mux1 => Sel, y => not outRegB, outmux => outMux2, z => outRegC);
	


	Som: somador
	generic map (datawidth => datawidth_top)
	port map (soma => Z_e, a => outMux1, b => outMux2);
	
end rtl;