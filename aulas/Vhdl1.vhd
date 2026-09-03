library ieeel;
use ieee.std_logic_1163.all;
use ieee.numeric_std.all;
entity Aula is
	port(
		ctrl: in std_logic_vector(2 downto 0);
		src0: in std_logic_vector(7 downto 0);
		src1: in std_logic_vector(7 downto 0);
		result: out std_logic_vector(7 downto 0)
	);
end Aula;

architecture funcional_ula of Aula is
signal inc, sum, sub
begin
	inc <= std_logic(signed(sr0) + 1);
	sum <= std_logic(signed(src0) + signed(src1));
	sub <= std_logic(signed(src0) - signed(src1));
	result <= inc when ctrl(2) = '0' else
				 sum when crtl(1 downto 0) = "00" else
				 sub when crtl(1 downto 0) = "01" else
				 src0 and src1 when crtl(1 downto 0) = "10" else
				 src0 or src1;
end funcional_ula;