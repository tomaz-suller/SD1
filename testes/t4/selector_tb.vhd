
entity selector_tb is
end entity;

architecture arch of selector_tb is
    
    component selector is
        port(
            u_data: in bit_vector(7 downto 0);
            mem_data: out bit_vector(3 downto 0)
        );
    end component;
    
    signal bit_in: bit_vector(7 downto 0);
    signal bit_out: bit_vector(3 downto 0);

begin

    dut: selector port map(bit_in, bit_out);
    
    tb: process
    begin
        report "BOT";

        bit_in <= "10010110";
        wait for 1 ns;
        assert bit_out = "0011" report "Falhou 1!" severity warning;

        bit_in <= "00011010";
        wait for 1 ns;
        assert bit_out = "0010" report "Falhou 2!" severity warning;

        bit_in <= "00010110";
        wait for 1 ns;
        assert bit_out = "0011" report "Falhou 3!" severity warning;

        bit_in <= "00010100";
        wait for 1 ns;
        assert bit_out = "0011" report "Falhou 4!" severity warning;

        bit_in <= "11101000";
        wait for 1 ns;
        assert bit_out = "1100" report "Falhou 5!" severity warning;


        report "EOT";
        wait;
    end process;


end architecture;
