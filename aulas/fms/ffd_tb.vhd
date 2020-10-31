entity ffd_tb is
end entity;

architecture arch of ffd_tb is
    component ffd is
        port(
            clock, clear, set: in bit;
            d: in bit;
            q, q_n: out bit
        );
    end component;

    signal c, cl, st, d, q, q_n: bit;

begin

    dut: ffd port map(c, cl, st, d, q, q_n);

    stim: process
    begin

        report "BOT";

        c <= '0'; cl <= '0'; st <= '0'; d<= '0';
        wait for 1 ns;

        c <= '0'; cl <= '0'; st <= '1'; d<= '0';
        wait for 1 ns;
        assert q = '1' and q_n = '0'
        report "Set falhou!" severity warning;

        c <= '0'; cl <= '1'; st <= '1'; d<= '0';
        wait for 1 ns;
        assert q = '0' and q_n = '1'
        report "Clear falhou!" severity warning;

        -- Testando comandos síncronos

        c <= '0'; cl <= '0'; st <= '0'; d<= '1';
        wait for 1 ns; c <= '1'; wait for 1 ns;
        assert q = '1' and q_n = '0'
        report "D = 1 falhou!" severity warning;

        c <= '0'; cl <= '0'; st <= '0'; d<= '0';
        wait for 1 ns; c <= '1'; wait for 1 ns;
        assert q = '0' and q_n = '1'
        report "D = 1 falhou!" severity warning;

        report "EOT";
        wait;

end arch ;  