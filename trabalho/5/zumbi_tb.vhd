library ieee;
use ieee.numeric_bit.rising_edge;

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
        constant clkPeriod := 1 ns;

begin

    clk <= (simulate and not clk) after clkPeriod/2;

    dut: work.zumbi(structural) port map();

    tb: process
        -- Teste do laranja
        constant vX1 := B"0000_1_0_1111"; 
        constant vX0 := B"0000_0_0_0111";
        constant vZ :=  B"0000_1_0_1111";
    begin
        simulate <= '1';
        report "BOT";

        x <= "00"; rst <= '1';
        assert z = 0 report "Reset falhou" severity warning;


        cases: for i in vX1'length-1 downto 0 loop
            x <= vX1(i) & vX0(i);
            wait for rising_edge(clk);

        
            assert z = vZ(i);
            report "Falhou " & integer'image(i) 
            & " z(esp): " & bit'image(vZ(i)) & " z(rec): "  & bit'image(z)
            severity warning;

        end loop;

        report "EOT";
        simulate <= '0';
        wait;
    end process;

end architecture arch;