entity secded_enc16 is
    port(
        u_data: in bit_vector(15 downto 0);
        mem_data: out bit_vector(21 downto 0)
    );
end entity;

architecture naive of secded_enc16 is
    signal p0, p1, p2, p3, p4, p5: bit;
begin
    -- Posicao 1
    p0 <= u_data(0) xor u_data(1) xor u_data(3) xor u_data(4) xor u_data(6) xor u_data(8) xor u_data(10) xor u_data(11) xor u_data(13) xor u_data(15) ;
    -- Posicao 2
    p1 <= u_data(0) xor u_data(2) xor u_data(3) xor u_data(5) xor u_data(6) xor u_data(9) xor u_data(10) xor u_data(12) xor u_data(13) ;
    -- Posicao 4
    p2 <= u_data(1) xor u_data(2) xor u_data(3) xor u_data(7) xor u_data(8) xor u_data(9) xor u_data(10) xor u_data(14) xor u_data(15) ;
    -- Posicao 8
    p3 <= u_data(4) xor u_data(5) xor u_data(6) xor u_data(7) xor u_data(8) xor u_data(9) xor u_data(10) ;
    -- Posicao 16
    p4 <= u_data(11) xor u_data(12) xor u_data(13) xor u_data(14) xor u_data(15) ;
    -- Paridade geral
    p5 <= u_data(0) xor u_data(1) xor u_data(2) xor u_data(3) xor u_data(4) xor u_data(5) xor u_data(6) xor u_data(7) xor u_data(8) xor u_data(9) xor u_data(10) xor u_data(11) xor u_data(12) xor u_data(13) xor u_data(14) xor u_data(15) xor p0 xor p1 xor p2 xor p3 xor p4;
    
    mem_data <= p0 & p1 & u_data(0) & p2 & u_data(3 downto 1) & p3 & u_data(10 downto 4) & p4 & u_data(15 downto 11) & p5; 

end architecture naive;