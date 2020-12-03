library ieee;
use std.textio.all;
use ieee.numeric_bit.all;

entity bv is
    port(
        A, B: in bit_vector(3 downto 0);
        C: out bit_vector(3 downto 0);
        D: out bit_vector(31 downto 0);
        E: out bit_vector(15 downto 0)
    );
end entity;

architecture arch of bv is

    function extend(bit_v:bit_vector; bi: bit) return bit_vector is
        variable tmp: bit_vector(31 downto 0) := (others => bi);
    begin
        for i in bit_v'range loop
            tmp(i) := bit_v(i);
        end loop;
        return tmp;
    end function;

    constant hex: string := ;

begin
    hex <= "e48c";
    C <= A and B;
    D <= extend(A, '1');
    E(15 downto 0) <= to_bitvector(hex);
end arch;