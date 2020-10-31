library ieee;
use ieee.numeric_bit.all;

entity secded_dec16 is
    port (
        mem_data: in bit_vector(21 downto 0);
        u_data: out bit_vector(15 downto 0);
        syndrome: out natural;
        two_errors: out bit;
        one_error: out bit
    );
end entity;

architecture arch of secded_dec16 is

    signal e0, e1, e2, e3, e4, e5: bit;
    signal err: bit;
    signal err_bv: bit_vector(4 downto 0);
    signal syn: integer;
    signal correct_mem_data: bit_vector(21 downto 0); 

begin

    e0 <= mem_data(0) xor mem_data(2) xor mem_data(4) xor mem_data(6) xor mem_data(8) xor mem_data(10) xor mem_data(12) xor mem_data(14) xor mem_data(16) xor mem_data(18) xor mem_data(20);
    e1 <= mem_data(1) xor mem_data(2) xor mem_data(5) xor mem_data(6) xor mem_data(9) xor mem_data(10) xor mem_data(13) xor mem_data(14) xor mem_data(17) xor mem_data(18);
    e2 <= mem_data(3) xor mem_data(4) xor mem_data(5) xor mem_data(6) xor mem_data(11) xor mem_data(12) xor mem_data(13) xor mem_data(14) xor mem_data(19) xor mem_data(20);
    e3 <= mem_data(7) xor mem_data(8) xor mem_data(9) xor mem_data(10) xor mem_data(11) xor mem_data(12) xor mem_data(13) xor mem_data(14);
    e4 <= mem_data(15) xor mem_data(16) xor mem_data(17) xor mem_data(18) xor mem_data(19) xor mem_data(20);
    e5 <= mem_data(0) xor mem_data(1) xor mem_data(2) xor mem_data(3) xor mem_data(4) xor mem_data(5) xor mem_data(6) xor mem_data(7) xor mem_data(8) xor mem_data(9) xor mem_data(10) xor mem_data(11) xor mem_data(12) xor mem_data(13) xor mem_data(14) xor mem_data(15) xor mem_data(16) xor mem_data(17) xor mem_data(18) xor mem_data(19) xor mem_data(20) xor mem_data(21);

    err <= e0 or e1 or e2 or e3 or e4;
    err_bv <= e4 & e3 & e2 & e1 & e0;
    
    syn <= to_integer(unsigned(err_bv)) - 1;
    syndrome <= 0;
    
    c: for i in 21 downto 0 generate
        correct_mem_data(i) <= not mem_data(i) when i = syn else mem_data(i);
    end generate;

    u_data(0) <= correct_mem_data(2);
    u_data(1) <= correct_mem_data(4);
    u_data(2) <= correct_mem_data(5);
    u_data(3) <= correct_mem_data(6);
    u_data(4) <= correct_mem_data(8);
    u_data(5) <= correct_mem_data(9);
    u_data(6) <= correct_mem_data(10);
    u_data(7) <= correct_mem_data(11);
    u_data(8) <= correct_mem_data(12);
    u_data(9) <= correct_mem_data(13);
    u_data(10) <= correct_mem_data(14);
    u_data(11) <= correct_mem_data(16);
    u_data(12) <= correct_mem_data(17);
    u_data(13) <= correct_mem_data(18);
    u_data(14) <= correct_mem_data(19);
    u_data(15) <= correct_mem_data(20);

    one_error <= e5;
    two_errors <= err and not e5;

end architecture;