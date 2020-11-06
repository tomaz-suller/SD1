library ieee;
use ieee.numeric_bit.rising_edge;

entity reg is
    port(
        clock, reset, load: in bit;
        carga: in bit_vector(3 downto 0);
        saida: out bit_vector(3 downto 0)
    );
end entity;

architecture arch of reg is
begin
process(clock, reset, load)
begin
    if reset = '1' then
        saida <= (others => '0');
    elsif rising_edge(clock) then -- marca flip flop
        if load = '1' then
            saida <= carga;
        end if;
    end if;
end process;
end arch;