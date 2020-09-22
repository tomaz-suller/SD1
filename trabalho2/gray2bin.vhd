entity gray2bin is
    port(
        gray2, gray1, gray0: in bit;
        bin2, bin1, bin0: out bit
    );
end entity;

architecture simplified of gray2bin is
begin
    bin0 <= gray0 xor (gray1 xor gray2);
    bin1 <= gray1 xor gray2;
    bin2 <= gray2;
end architecture;