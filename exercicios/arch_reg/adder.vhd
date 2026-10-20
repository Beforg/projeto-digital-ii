library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic(
        datawidth: natural := 8 
    );
    port(
        src1: in std_logic_vector(datawidth-1 downto 0);
        src2: in std_logic_vector(datawidth-1 downto 0);
        output: out std_logic_vector(datawidth-1 downto 0)
    ); 
end adder;

architecture behavioral of adder is
begin
    output <= std_logic_vector(unsigned(src1) + unsigned(src2));
end behavioral;