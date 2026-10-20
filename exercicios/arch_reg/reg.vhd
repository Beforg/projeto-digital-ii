library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg is 
    generic (
        DATA_WIDTH: natural:= 8
    );
    
    port (
        input: in std_logic_vector((DATA_WIDTH - 1) downto 0);
        clk: in std_logic;
        output: out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
end Reg;

architecture behavior_reg of Reg is 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            output <= input;
        end if;
    end process;
end architecture;