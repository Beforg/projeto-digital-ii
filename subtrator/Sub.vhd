
-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;

entity Sub is

	generic
	(
		DATA_WIDTH_TOP : natural := 16
	);

	port 
	(
	-- Portas principais 
		clk_top	  : in std_logic;
		reset_top  : in std_logic;
		a_top	     : in std_logic_vector  ((DATA_WIDTH_TOP-1) downto 0);
		b_top	     : in std_logic_vector  ((DATA_WIDTH_TOP-1) downto 0);
		c_top 	  : out std_logic_vector ((DATA_WIDTH_TOP-1) downto 0)
		
	);

end entity;

architecture rtlBSN of Sub is

signal ctrl_mux1_conect, ctrl_mux2_conect, en_inputs_conect, en_regAdder_conect: std_logic;
		

COMPONENT PC_Sub IS
    PORT (
			 -- Portas principais
			 reset : IN STD_LOGIC := '0';
          clock : IN STD_LOGIC;
          en_inputs : OUT STD_LOGIC;
          cTRL_mux1 : OUT STD_LOGIC;
          cTRL_mux2 : OUT STD_LOGIC;
          en_regAdder : OUT STD_LOGIC
    );
END COMPONENT;

component PO_Sub is

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
		ctrl_mux1  : in std_logic;
		ctrl_mux2  : in std_logic;
		en_inputs  : in std_logic;
		en_regAdder: in std_logic;
		c_PO	 	  : out std_logic_vector ((DATA_WIDTH_PO-1) downto 0)
	);

end component;

begin
			 
PO: 	PC_Sub
			 port map (
						  reset => reset_top,
						  clock => clk_top,
						  en_inputs => en_inputs_conect,
						  cTRL_mux1 => ctrl_mux1_conect,
						  cTRL_mux2 => ctrl_mux2_conect,
						  en_regAdder => en_regAdder_conect,
						  state_view => state_view
						);			 

PC: 	PO_Sub
			 generic map (DATA_WIDTH_PO => DATA_WIDTH_TOP)
			 port map (
						-- Portas de depuração
							clk => clk_top,
							a_PO => a_top,
							b_PO => b_top,
							Ctrl_mux1 => ctrl_mux1_conect,
							Ctrl_mux2 => Ctrl_mux2_conect,
							en_inputs => en_inputs_conect,
							en_regAdder => en_regAdder_conect,
							c_PO => c_top,
						);	

end rtlBSN;
