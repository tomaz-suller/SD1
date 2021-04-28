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
        tmp(bit_v'length-1 downto 0) := bit_v;
        return tmp;
    end function;

begin
    C <= A and B;
    D <= extend("0001"&"00", '0');
end arch;