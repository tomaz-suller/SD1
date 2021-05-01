entity registrador_universal_tb is 
end entity;

architecture arch of registrador_universal_tb is

    component registrador_universal is
        generic (
            word_size: positive := 4
        );
        port (
            clock, clear, set, enable: in bit;
            control: in bit_vector(1 downto 0);
            serial_input: in bit;
            parallel_input: in bit_vector(word_size-1 downto 0);
            parallel_output: out bit_vector(word_size-1 downto 0)
        );
    end component;

    signal clk, clr, set, en, s_i: bit;
    signal ctrl: bit_vector(1 downto 0);
    signal p_i, p_o: bit_vector(3 downto 0);
    signal simulate: bit := '0';

begin

    clk <= (simulate and not clk) after 1 ns;

    dut: registrador_universal port map(clk, clr, set, en, ctrl, s_i, p_i, p_o);

    tb: process
    begin
        simulate <= '1';
        report "BOT";

        set <= '1'; wait for 5 ns; set <= '0';
        wait for 1 ns;
        clr <= '1'; wait for 5 ns; clr <= '0';

        en <= '1';
        p_i <= "1011";
        ctrl <= "11";

        wait for 5 ns;

        s_i <= '1';
        wait for 1 ns;
        ctrl <= "10";

        wait for 3 ns;

        ctrl <= "00";

        wait for 5 ns;
        
        report "EOT";
        simulate <= '0';
        wait;
    end process;

end architecture arch;