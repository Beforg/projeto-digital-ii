library ieee;
use ieee.std_logic_1164.all;

entity arch_reg_pipe is
    generic(
        datawidth: natural := 8 
    );
    port(
        input_data1: in std_logic_vector(datawidth-1 downto 0);
        input_data2: in std_logic_vector(datawidth-1 downto 0);
        input_data3: in std_logic_vector(datawidth-1 downto 0);
        output_data: out std_logic_vector(datawidth-1 downto 0)
    );
end arch_reg_pipe;

architecture behavioral of arch_reg_pipe is 
signal inputReg_sig, outputReg_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 1
signal inputReg2_sig,outputReg2_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 2
signal inputReg3_sig,outputReg3_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 3
signal inputReg4_sig,outputReg4_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 4
signal inputReg5_sig,outputReg5_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 5
signal outputReg6_sig: std_logic_vector(datawidth-1 downto 0); -- Reg 6
signal adder_out_sig: std_logic_vector(datawidth-1 downto 0);
signal sub_src1, sub_src2, sub_out_sig: std_logic_vector(datawidth-1 downto 0);
signal clk_sig : std_logic;
component Reg is 
    generic (
        DATA_WIDTH: natural:= 8
    );
    
    port (
        input: in std_logic_vector((DATA_WIDTH - 1) downto 0);
        clk: in std_logic;
        output: out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
end Reg;
component adder is
    generic(
        datawidth: natural := 8 
    );
    port(
        src1: in std_logic_vector(datawidth-1 downto 0);
        src2: in std_logic_vector(datawidth-1 downto 0);
        output: out std_logic_vector(datawidth-1 downto 0)
    ); 
end adder;
component sub is
    generic(
        datawidth: natural := 8 
    );
    port(
        src1: in std_logic_vector(datawidth-1 downto 0);
        src2: in std_logic_vector(datawidth-1 downto 0);
        output: out std_logic_vector(datawidth-1 downto 0)
    ); 
end sub;
begin
    Reg1: Reg generic map (DATA_WIDTH => datawidth) port map (input_data1, clk_sig, outputReg_sig);
    Reg2: Reg generic map (DATA_WIDTH => datawidth) port map (input_data2, clk_sig, outputReg2_sig);
    Reg3: Reg generic map (DATA_WIDTH => datawidth) port map (input_data3, clk_sig, outputReg3_sig);
    Reg4: Reg generic map (DATA_WIDTH => datawidth) port map (inputReg4_sig, clk_sig, outputReg4_sig);
    Reg5: Reg generic map (DATA_WIDTH => datawidth) port map (inputReg5_sig, clk_sig, outputReg5_sig);   
    Reg6: Reg generic map (DATA_WIDTH => datawidth) port map (sub_out_sig, clk_sig, outputReg6_sig);
    Adder1: adder generic map (datawidth => datawidth) port map (outputReg_sig, outputReg2_sig, adder_out_sig);
    Sub1: sub generic map (datawidth => datawidth) port map (outputReg4_sig, outputReg5_sig, sub_out_sig);
    output_data <= sub_out_sig;
end behavioral;