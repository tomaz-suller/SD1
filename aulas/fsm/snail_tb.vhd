library ieee;
use ieee.numeric_bit.rising_edge;

entity snail_tb is
end entity;

architecture arch of snail_tb is

    component snail is
        port(
            clock, reset, x: in bit;
            z: out bit
        );
    end component;

    constant clockPeriod: time := 1 ns;
    signal simulate: bit := '0'; -- So that clk ends
    -- Default value only valid in simulation
    signal clk, rst, x, z: bit;

begin

    clk <= (simulate and not clk) after clockPeriod/2;

    dut: entity work.snail(structural) port map(clk, rst, x, z);

    stim: process
        constant vectorx: bit_vector := B"00_101_101_01100_101_1001_101";
        constant vectorz: bit_vector := B"00_001_001_00000_001_0000_001";
    begin
        simulate <= '1';
        report "BOT";

        x <= '0'; rst <= '1'; wait for 1 ns; rst <= '0';
        assert z = '0' report "Reset falhou" severity warning;

        testes: for i in 0 to vectorx'length-1 loop
            x <= vectorx(i);
            -- wait until clk'event and clk = '1';
            wait until rising_edge(clk); -- wait for state change
            wait for 1 ns;
            -- wait until falling_edge(clk);
            assert z = vectorz(i);

            report "Tetse "& integer'image(i) & " falhou"
            & "z(esp): "& bit'image(vectorz(i)) & "z(obt): " & bit'image(z);
        end loop;

        report "EOT";
        simulate <= '0';
        wait;

end arch;