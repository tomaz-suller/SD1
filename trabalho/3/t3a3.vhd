entity incinerador is
    port (
        led: out bit;
        S: in bit_vector(2 downto 0);
        P: out bit
    );
end entity;

architecture arch of incinerador is
    signal ASN: bit;
    signal AS: bit;
begin
    ASN <= (not S(0)) or (not S(1)) or (not S(2));
    AS <= S(0) or S(1) or S(2);
    P <= ( S(1) and (S(0) or S(2)) ) or ( S(0) and S(2) );
    led <= ASN and AS;
end architecture arch;
