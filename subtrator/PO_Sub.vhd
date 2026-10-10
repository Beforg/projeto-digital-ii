
-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;

entity PO_Sub is

	generic
	(
		DATA_WIDTH_PO : natural := 16
	);

	port 
	(
	-- Portas principais 
		clk		  : in std_logic;
		a_PO	     : in std_logic_vector  ((DATA_WIDTH_PO-1) downto 0);
		b_PO	     : in std_logic_vector  ((DATA_WIDTH_PO-1) downto 0);
		Ctrl_mux1  : in std_logic;
		Ctrl_mux2  : in std_logic;
		En_inputs  : in std_logic;
		En_regAdder: in std_logic;
		c_PO 	  : out std_logic_vector ((DATA_WIDTH_PO-1) downto 0)
	);

end entity;

architecture rtlBSN of PO_Sub is

signal outMux1, outMux2, outAdder, outRegAdder, outRegA, outRegB, outInv : std_logic_vector  ((DATA_WIDTH_PO-1) downto 0);
signal one : std_logic_vector  ((DATA_WIDTH_PO-1) downto 0):= (0=>'1', others=>'0');


component Reg is

	generic
	(
		DATA_WIDTH : natural := 8
	);

	port 
	(
		clk		: in std_logic;
		enable	: in std_logic;
		input	   : in std_logic_vector((DATA_WIDTH-1) downto 0);
		output   : out std_logic_vector((DATA_WIDTH-1) downto 0)
	);

end component;



component adder is

	generic
	(
		DATA_WIDTH : natural := 8
	);

	port 
	(
		a	   : in std_logic_vector((DATA_WIDTH-1) downto 0);
		b	   : in std_logic_vector  ((DATA_WIDTH-1) downto 0);
		result : out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end component;


component mux2p1 is

	generic
	(
		DATA_WIDTH : natural := 8
	);

	port 
	(
		a	   : in std_logic_vector  ((DATA_WIDTH-1) downto 0);
		b	   : in std_logic_vector  ((DATA_WIDTH-1) downto 0);
		sel   : in std_logic;
		result : out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end component;



begin

Mux1: 	Mux2p1
			 generic map (DATA_WIDTH => DATA_WIDTH_PO)
			 port map (a => outRegA, b => one, sel => Ctrl_mux1, result => outMux1);
			 
Mux2: 	Mux2p1
			 generic map (DATA_WIDTH => DATA_WIDTH_PO)
			 port map (a => outInv, b => outRegAdder, sel => Ctrl_mux2, result => outMux2);			 

Add: 		Adder
			 generic map (DATA_WIDTH => DATA_WIDTH_PO)
			 port map (a => outMux1, b => outMux2, result => outAdder);
			 
RegA: 	Reg
			 generic map (DATA_WIDTH => DATA_WIDTH_PO)
			 port map (clk => clk, enable => En_inputs, input => a_PO, output => outRegA);
			 
RegB: 	Reg
			 generic map (DATA_WIDTH => DATA_WIDTH_PO)
			 port map (clk => clk, enable => En_inputs, input => b_PO, output => outRegB);			 

RegC: 	Reg
			 generic map (DATA_WIDTH => DATA_WIDTH_PO)
			 port map (clk => clk, enable => En_regAdder, input => outAdder, output => outRegAdder);	

outInv <= not outRegB;
c_PO <= outRegAdder;

end rtlBSN;
