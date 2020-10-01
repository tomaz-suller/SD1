entity gray2bin_tb is
end entity;

architecture test of gray2bin_tb is
    component gray2bin is
        port(
            gray2, gray1, gray0: in bit;
            bin2, bin1, bin0: out bit
        );
    end component;

        signal g2, g1, g0, b2, b1, b0: bit;

begin

    dut: gray2bin port map(g2, g1, g0, b2, b1, b0);

    process_test: process
    begin

        report "BOT";

        g0 <= '0'; g1 <= '0'; g2 <= '0';
        wait for 1 ns;
        assert b0='0' and b1='0' and b2='0' report "Primeiro teste falhou" severity warning;
        
        g0 <= '1'; g1 <= '0'; g2 <= '0';
        wait for 1 ns;
        assert b0='1' and b1='0' and b2='0' report "Segundo teste falhou" severity warning;
        
        report "EOT";

        wait;
    end process;

end test; -- test