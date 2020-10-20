entity secded_enc16 is
    port(
        u_data: in bit_vector(15 downto 0);
        mem_data: out bit_vector(21 downto 0)
    );
end entity;

architecture naive of secded_end16 is
    signal p0, p1, p2, p4, p8, p16: bit;
begin
    p0 <= u_data(0) xor u_data(1) xor u_data(2) xor u_data(3) xor u_data(4) xor u_data(5) xor u_data(6) xor u_data(7) xor u_data(8) xor u_data(9) xor u_data(10) xor u_data(11) xor u_data(12) xor u_data(13) xor u_data(14) xor u_data(15) xor u_data(16) xor u_data(17) xor u_data(18) xor u_data(19) xor u_data(20) xor u_data(21) xor p1 xor p2 xor p4 xor p8 xor p16;

    p1 <= u_data(3) xor u_data(5) xor u_data(7) xor u_data(9) xor u_data(11) xor u_data(13) xor u_data(15) xor u_data(17) xor u_data(19) xor u_data(21) ;

    p2 <= u_data(3) xor u_data(6) xor u_data(7) xor u_data(10) xor u_data(11) xor u_data(14) xor u_data(15) xor u_data(18) xor u_data(19) ;

    p4 <= u_data(5) xor u_data(6) xor u_data(7) xor u_data(12) xor u_data(13) xor u_data(14) xor u_data(15) xor u_data(20) xor u_data(21) ;

    p8 <= u_data(9) xor u_data(10) xor u_data(11) xor u_data(12) xor u_data(13) xor u_data(14) xor u_data(15) ;

    p16 <= u_data(17) xor u_data(18) xor u_data(19) xor u_data(20) xor u_data(21) ;

end architecture;

