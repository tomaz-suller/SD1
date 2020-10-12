entity gray2bin is
    port(
        gray2, gray1, gray0: in bit;
        bin2, bin1, bin0: out bit
    );
end entity;

architecture simplified of gray2bin is
    signal bout2: bit;
    signal bout1: bit;
begin
    bout2 <= gray2;
    bout1 <= gray1 xor bout2;
    
    bin0 <= gray0 xor bout1;
    bin1 <= bout1;
    bin2 <= bout2;
end architecture;