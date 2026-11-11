library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuito is  
    port(
        a, b                     : in  std_logic_vector(7 downto 0);
        clk                      : in  std_logic;
        sel_mux, sel_mux_out     : in  std_logic;
        enable, enable_out       : in  std_logic;
        result                   : out std_logic_vector(7 downto 0)
    );
end circuito;

architecture behavioral of circuito is
    signal out_m1, out_m2, out_m3             : std_logic_vector(7 downto 0);
    signal reg1, reg2, reg_out              : std_logic_vector(7 downto 0);
    signal out_sub, out_sum                 : std_logic_vector(7 downto 0);
begin
    -- MUX 1: Escolhe entre a realimentação de reg_out (via 0) ou a entrada 'a' (via 1)
    out_m1 <= reg_out when sel_mux = '0' else a;
    
    -- MUX 2: Conforme o esquema, a realimentação da via 0 vem do reg1, e a via 1 é a entrada 'b'
    out_m2 <= reg1 when sel_mux = '0' else b;
    
    -- Bloco Operacional (ULA): Soma e Subtração em paralelo usando reg1 e reg2
    out_sum <= std_logic_vector(unsigned(reg2) + unsigned(reg1));
    out_sub <= std_logic_vector(unsigned(reg2) - unsigned(reg1));
    
    -- MUX de Saída da ULA: Escolhe entre Soma (0) ou Subtração (1)
    out_m3 <= out_sum when sel_mux_out = '0' else out_sub;
    
    -- Processo Sequencial controlando os Registradores com os Enablers corretos
    process(clk)
    begin
        if rising_edge(clk) then
            -- Registradores de entrada controlados pelo enable principal
            if enable = '1' then
                reg1 <= out_m1;
                reg2 <= out_m2;
            end if;
            
            -- Registrador de saída controlado separadamente por enable_out (como na imagem)
            if enable_out = '1' then
                reg_out <= out_m3;
            end if;
        end if;
    end process;

    -- Conexão final da saída do datapath
    result <= reg_out;

end behavioral;