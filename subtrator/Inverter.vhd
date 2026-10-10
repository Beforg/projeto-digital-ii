
-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;

entity Inverter is

	generic
	(
		DATA_WIDTH : natural := 8
	);

	port 
	(
		input	 : in std_logic_vector  ((DATA_WIDTH-1) downto 0);
		output : out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end entity;

architecture rtlBSN of Inverter is
begin

	output <= not input;

end rtlBSN;
