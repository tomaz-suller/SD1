library ieee;
use ieee.numeric_bit.rising_edge;

entity zumbi is
    port(
        clock, reset: in bit;
        x: in bit_vector(1 downto 0);
        z: out bit
    );
end entity;

architecture estrutural of zumbi is
    component ffd is
        port (
            clock, clear, set: in bit;
            d: in bit;
            q, q_n: out bit
        );
    end component;

    signal d0, d1, q0, q1, q0_n, q1_n: bit;

begin
    ffd1: ffd port map(clock, reset, '0', d1, q1, q1_n);
    ffd0: ffd port map(clock, reset, '0', d0, q0, q0_n);

    d1 <= x(0) and (q1 or not x(1));
    d0 <= x(1) and ( (q1 xor q0) or not x(0) );

    z <= q0;
end architecture;