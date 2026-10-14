library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity logical_unit is
    Port ( 
        a : in STD_LOGIC_VECTOR(3 downto 0);
        b : in STD_LOGIC_VECTOR(3 downto 0);
        op : in STD_LOGIC;
        enable : in STD_LOGIC;
        result : out STD_LOGIC_VECTOR(3 downto 0));
end logical_unit;

architecture Behavioral of logical_unit is
    begin
        process(a, b, op, enable)
        begin
            if enable = '1' then
                if op = '0' then
                    result <= a and b;
                else
                    result <= a or b;
                end if;
            else 
                result <= (others => '0');
            end if;
    end process;
end Behavioral;