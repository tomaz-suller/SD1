entity divisor_tb is 
end entity;

architecture arch of divisor_tb is

    component divisor is
        generic(
            word_size: positive
        );
        port (
            clock, reset, vai: in bit;
            pronto: out bit;
            A, B: in bit_vector(word_size-1 downto 0);
            resultado, resto: out bit_vector(word_size-1 downto 0)
        );
    end component;

    signal simula: bit := '0';
    signal clk, rst, vai, fim: bit;
    signal A, B: bit_vector(3 downto 0);
    signal resultado, resto: bit_vector(3 downto 0);

begin

    dut: divisor
        generic map(4)
        port map(clk, rst, vai, fim, A, B, resultado, resto);

    clk <= (simula and not clk) after 1 ns;

    tb: process
    begin
        simula <= '1';
        report "BOT";

        A <= "1000";
        B <= "0010";

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