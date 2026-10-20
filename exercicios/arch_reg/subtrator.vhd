library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity sub is
    generic(
        datawidth: natural := 8 
    );
    port(
        src1: in std_logic_vector(datawidth-1 downto 0);
        src2: in std_logic_vector(datawidth-1 downto 0);
        output: out std_logic_vector(datawidth-1 downto 0)
    ); 
end sub;

architecture behavioral of sub is
begin
    output <= std_logic_vector(signed(src1) - signed(src2));
end behavioral;