library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is 
	port(
	in1: in std_logic;
	in2: in std_logic;
	in3: in std_logic;
	in4: in std_logic;
	s2: in std_logic;
	s1: in std_logic;
	out1: out std_logic;
	out2: out std_logic;
	out3: out std_logic;
	out4: out std_logic
	);
end shifter;

architecture behavior of shifter is 
	begin
		out1 <= in4 when (s1='0' and s2='0') else
					in3 when (s1='0' and s2='1')else
					in2 when (s1='1' and s2='0') else
					in1; 
		out2 <= in3 when (s1='0' and s2='0') else
			in2 when (s1='0' and s2='1')else
			in1 when (s1='1' and s2='0') else
			'0';
			
 		out3 <= in2 when (s1='0' and s2='0') else
			in1 when (s1='0' and s2='1')else
			'0' when (s1='1' and s2='0') else
			'0'; 
		out4 <= in1 when (s1='0' and s2='0') else
			'0' when (s1='0' and s2='1')else
			'0' when (s1='1' and s2='0') else
			'0';		
end behavior;
