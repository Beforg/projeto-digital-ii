library ieee;
use ieee.std_logic_1164.all;

entity arch_reg_pipe is
    generic(
        datawidth: natural := 8 
    );
    port(
        clk        : in std_logic;
        input_data1: in std_logic_vector(datawidth-1 downto 0);
        input_data2: in std_logic_vector(datawidth-1 downto 0);
        input_data3: in std_logic_vector(datawidth-1 downto 0);
        output_data: out std_logic_vector(datawidth-1 downto 0)
    );
end arch_reg_pipe;

architecture behavioral of arch_reg_pipe is 
signal outputReg_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 1
signal outputReg2_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 2
signal outputReg3_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 3
signal outputReg4_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 4
signal outputReg5_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 5
signal outputReg6_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 6
signal adder_out_sig: std_logic_vector(datawidth-1 downto 0);
signal sub_out_sig: std_logic_vector(datawidth-1 downto 0);
component Reg is 
    generic (
        DATA_WIDTH: natural:= 8
    );
    
    port (
        input: in std_logic_vector((DATA_WIDTH - 1) downto 0);
        clk: in std_logic;
        output: out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
end component;
component adder is
    generic(
        datawidth: natural := 8 
    );
    port(
        src1: in std_logic_vector(datawidth-1 downto 0);
        src2: in std_logic_vector(datawidth-1 downto 0);
        output: out std_logic_vector(datawidth-1 downto 0)
    ); 
end component;
component sub is
    generic(
        datawidth: natural := 8 
    );
    port(
        src1: in std_logic_vector(datawidth-1 downto 0);
        src2: in std_logic_vector(datawidth-1 downto 0);
        output: out std_logic_vector(datawidth-1 downto 0)
    ); 
end component;
begin
    Reg1: Reg
        generic map (DATA_WIDTH => datawidth)
        port map (
            input  => input_data1,
            clk    => clk,
            output => outputReg_sig
        );

    Reg2: Reg
        generic map (DATA_WIDTH => datawidth)
        port map (
            input  => input_data2,
            clk    => clk,
            output => outputReg2_sig
        );

    Reg3: Reg
        generic map (DATA_WIDTH => datawidth)
        port map (
            input  => input_data3,
            clk    => clk,
            output => outputReg3_sig
        );

    Reg4: Reg
        generic map (DATA_WIDTH => datawidth)
        port map (
            input  => adder_out_sig,
            clk    => clk,
            output => outputReg4_sig
        );

    Reg5: Reg
        generic map (DATA_WIDTH => datawidth)
        port map (
            input  => outputReg3_sig,
            clk    => clk,
            output => outputReg5_sig
        );

    Reg6: Reg
        generic map (DATA_WIDTH => datawidth)
        port map (
            input  => sub_out_sig,
            clk    => clk,
            output => outputReg6_sig
        );

    Adder1: adder
        generic map (datawidth => datawidth)
        port map (
            src1   => outputReg_sig,
            src2   => outputReg2_sig,
            output => adder_out_sig
        );

    Sub1: sub
        generic map (datawidth => datawidth)
        port map (
            src1   => outputReg4_sig,
            src2   => outputReg5_sig,
            output => sub_out_sig
        );

    output_data <= outputReg6_sig;
end behavioral;