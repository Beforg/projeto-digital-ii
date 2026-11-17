library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tests is
    port (
        osc_clk : in std_logic;
        button  : in std_logic_vector(3 downto 0);
        led     : out unsigned(3 downto 0)
    );
end entity;

architecture rtl of tests is
    signal ok_to_inc: std_logic := '0';
    signal ac, ac_1: unsigned(3 downto 0);
begin

    process (osc_clk, button(3))
    begin
        if (button(3) = '0') then
            ok_to_inc <= '0';
            ac_1 <= (others => '0');
            ac <= "0001";
        else
            if (rising_edge(osc_clk)) then
                if (button(2) = '0') then
                    if (ok_to_inc = '0') then
                        ac <= ac_1 + ac;
                        ac_1 <= ac;
                        ok_to_inc <= '1';
                    end if;
                else
                    ok_to_inc <= '0';
                end if;
            end if;
        end if;
    end process;

    led <= not(ac_1);

end rtl;