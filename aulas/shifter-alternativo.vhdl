library ieee;
use ieee.std_logic_1164.all;

entity Shifter4Bits is 
	port(
		i: in std_logic_vector(3 downto 0);
		s: out  std_logic_vector(3 downto 0);
		seletor: in std_logic_vector(1 downto 0);
		clock: in std_logic
	);
end Shifter4Bits;

architecture RTL of Shifter4Bits is 
	signal outMux1, outMux2, outMux3, outMux4: std_logic;
	signal outReg1, outReg2, outReg3, outReg4: std_logic;
begin
	process(clock);
	begin
		if rising_edge(clock) then
			if seletor = "00" then
				outMux1 <= i(3);
				outMux2 <= i(2);
				outMux3 <= i(1);
				outMux3 <= i(0);
			elsif seletor = "01" then
				outMux1 <= outReg4;
				outMux2 <= outReg1;
				outMux3 <= outReg2;
				outMux4 <= outReg3;
			elsif seletor = "10" then
				outMux1 <= outReg3;
				outMux2 <= outReg4;
				outMux3 <= outReg1;
				outMux4 <= outReg2;			
			else 
				outMux1 <= outReg2;
				outMux2 <= outReg3;
				outMux3 <= outReg4;
				outMux4 <= outReg1;	
			end if
			outReg1 <= outMux1;
			outReg2 <= outMux2;
			outReg3 <= outMux3;
			outReg4 <= outMux4;
		end if
	end process

	s <= outReg1 & outReg2 & outReg3 & outReg4;
end RTL;