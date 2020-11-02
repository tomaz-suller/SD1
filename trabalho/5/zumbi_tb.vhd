library ieee;
use ieee.numeric_bit.rising_edge;
use ieee.numeric_bit.falling_edge;

entity zumbi_tb is 
end entity;

architecture arch of zumbi_tb is

    component zumbi is
        port(
            clock, reset: in bit;
            x: in bit_vector(1 downto 0);
            z: out bit
        );
    end component;

        signal simulate: bit := '0';
        signal clk, rst, z: bit;
        signal x: bit_vector(1 downto 0);
        constant clkPeriod: time := 1 ns;

begin

    clk <= (simulate and not clk) after clkPeriod/2;

    dut: zumbi port map(clk, rst, x, z);

    tb: process
        -- Teste do laranja
        --constant vX1: bit_vector := B"0000_1_0_1111"; 
        --constant vX0: bit_vector := B"0000_0_0_0111";
        --constant vZ: bit_vector :=  B"0000_1_0_1111";

        -- Teste do verde
        --constant vX1: bit_vector := B"0000_111111";
        --constant vX0: bit_vector := B"0000_111111";
        --constant vZ: bit_vector :=  B"0000_000000";

        -- Teste do azul
        constant vX1: bit_vector := B"0000_01_011_000_0111";
        constant vX0: bit_vector := B"0000_11_111_000_1111";
        constant vZ: bit_vector :=  B"0000_01_010_000_0101";
        -- ERRORS                             |       |

    begin
        simulate <= '1';
        report "BOT";

        x <= "00"; rst <= '1'; wait for 1 ns; rst <= '0';
        assert z = '0' report "Reset falhou" severity warning;

        cases: for i in 0 to vX1'length-1 loop
            x <= vX1(i) & vX0(i);
            wait until rising_edge(clk);
            wait for 1 ns;

            assert z = vZ(i) 
            report "Falhou " & integer'image(i) 
            & " z(esp): " & bit'image(vZ(i)) & " z(rec): "  & bit'image(z)
            severity warning;
        end loop;

        report "EOT";
        simulate <= '0';
        wait;
    end process;

end architecture arch;