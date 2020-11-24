entity multiplicador_tb is 
end entity;

architecture arch of multiplicador_tb is

    component multiplicador is
        generic(
            word_size: positive
        );
        port (
            clock, reset, vai: in bit;
            pronto: out bit;
            A, B: in bit_vector(word_size-1 downto 0);
            resultado: out bit_vector(2*word_size-1 downto 0)
        );
    end component;

    signal simula: bit := '0';
    signal clk, rst, vai, fim: bit;
    signal A, B: bit_vector(3 downto 0);
    signal res: bit_vector(7 downto 0);

begin

    dut: multiplicador
        generic map(4)
        port map(clk, rst, vai, fim, A, B, res);

    clk <= (simula and not clk) after 1 ns;

    tb: process
    begin
        simula <= '1';
        report "BOT";

        A <= "0010";
        B <= "1000";

        rst <= '1'; wait for 1 ns; rst <= '0';
        vai <= '1';
        wait for 2 ns;
        vai <= '0';
        wait for 100 ns;

        report "EOT";
        simula <= '0';
        wait;
    end process;

end architecture arch;