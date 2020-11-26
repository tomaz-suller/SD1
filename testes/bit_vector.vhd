library ieee;
use ieee.numeric_bit.all;

entity bv is
    port(
        A, B: in bit_vector(3 downto 0);
        C: out bit_vector(3 downto 0)
    );
end entity;

architecture arch of bv is
begin
    C <= A and B;
end arch;