entity incinerador is
    port (
        -- led: out bit;
        S: in bit_vector(2 downto 0);
        P: out bit
    );
end entity;

architecture arch of incinerador is
begin
    P <= ( S(1) and (S(0) or S(2)) ) or ( S(0) and S(2) );
end architecture arch;