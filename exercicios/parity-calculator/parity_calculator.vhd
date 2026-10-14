library IEEE;
  use IEEE.STD_LOGIC_1164.all;

entity parity_calculator is
  port (clk        : in  STD_LOGIC;
        data_in    : in  STD_LOGIC_VECTOR(3 downto 0);
        parity_out : out STD_LOGIC);
end entity;

architecture Behavioral of parity_calculator is
  signal parity_temp : STD_LOGIC;
begin
--   process (clk)
--   begin
--     if rising_edge(clk) then
--       parity_out <= parity_temp;
--       parity_temp <= data_in(0);
--       parity_temp <= data_in(1) xor parity_temp;
--       parity_temp <= data_in(2) xor parity_temp;
--       parity_temp <= data_in(3) xor parity_temp;
--     end if;
--   end process;
-- Solução sequencial:
    process(clk)
    begin
        if rising_edge(clk) then
            parity_out <= ((data_in(0) xor data_in(1)) xor data_in(2)) xor data_in(3);
        end if;
    end process;
-- Solução combinacional:
    -- parity_out <= ((data_in(0) xor data_in(1)) xor data_in(2)) xor data_in(3);
end architecture;
