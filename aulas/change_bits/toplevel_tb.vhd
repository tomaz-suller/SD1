entity toplevel_tb is 
end entity;

architecture arch of toplevel_tb is

    component toplevel is
        port(
            clock, reset, vai: in bit;
            cargaA, cargaB: in bit_vector(3 downto 0); 
            pronto: out bit
        );
    end component;

    signal clk, rst, vai, pronto, simula: bit;
    signal A, B: bit_vector(3 downto 0);

begin

    dut: toplevel port map(clk, rst, vai, A, B, pronto);

    clk <= (simula and not clk) after 1 ns;

    tb: process
    begin
        simula <= '1';
        report "BOT";

        A <= "0111";
        B <= "0101";

        rst <= '1'; wait for 5 ns; rst <= '0';
        vai <= '1';
        wait for 2 ns;
        vai <= '0';
        wait for 20 ns;

        report "EOT";
        simula <= '0';
        wait;
    end process;

end architecture arch;