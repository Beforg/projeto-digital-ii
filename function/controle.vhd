library ieee;
use ieee.std_logic_1164.all;

entity controle is
    port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        start     : in  std_logic;
        count_fim : in  std_logic; -- Flag que avisa que a contagem acabou
        sel_init  : out std_logic;
        enable    : out std_logic
    );
end entity;

architecture fsm of controle is
    -- Definição dos estados conforme o seu diagrama
    type state_type is (INIT, CALC, END_CALC);
    signal state, next_state : state_type;
begin

    -- 1. Memória de Estado (Síncrono)
    process(clk, rst)
    begin
        if rst = '1' then
            state <= INIT;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- 2. Lógica de Próximo Estado (Transições das setas do diagrama)
    process(state, start, count_fim)
    begin
        case state is
            when INIT =>
                if start = '1' then
                    next_state <= CALC;
                else
                    next_state <= INIT;
                end if;

            when CALC =>
                -- O diagrama indica transição quando "count_fim=0".
                -- Assumindo que count_fim vai para '1' quando o contador atingir o fim:
                if count_fim = '1' then 
                    next_state <= END_CALC;
                else
                    next_state <= CALC;
                end if;

            when END_CALC =>
                -- O diagrama indica que se 'start' for pressionado, volta para INIT
                if start = '1' then
                    next_state <= INIT;
                else
                    next_state <= END_CALC;
                end if;

            when others =>
                next_state <= INIT;
        end case;
    end process;

    -- 3. Lógica de Saídas (Valores dentro dos balões do diagrama)
    process(state)
    begin
        -- Valores padrão (evita inferência de latches)
        sel_init <= '0';
        enable   <= '0';

        case state is
            when INIT =>
                sel_init <= '1';
                enable   <= '1';
                
            when CALC =>
                sel_init <= '0';
                enable   <= '1';
                
            when END_CALC =>
                sel_init <= '0'; -- Representando o 'X' (Don't care) de forma segura
                enable   <= '0';
        end case;
    end process;

end architecture;