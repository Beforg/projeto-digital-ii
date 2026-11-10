library ieee;
use ieee.std_logic_1164.ALL;

entity circuito1 is
    generic(
        datawidth: natural := 4;
    );
    port(
        in1: in std_logic_vector(datawidth -1 downto 0);
        in2: in std_logic_vector(datawidth -1 downto 0);
        in3: in std_logic_vector(datawidth -1 downto 0);
        saida: in std_logic_vector(datawidth -1 downto 0)
    );
end circuito1;

architecture behavioral of circuito1 is
signal inReg1, inReg2, inReg3, inReg4, inReg5, inReg6: std_logic_vector (datawidth -1 downto 0);
signal outReg1, outReg2,outReg3, outReg4, outReg5, outReg6: std_logic_vector (datawidth -1 downto 0);
begin


end behavioral