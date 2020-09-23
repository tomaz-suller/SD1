entity g is
    port(
        gin: in bit;
        binp: in bit;
        bout: out bit
    );
end entity;

architecture gray of g is
begin
    bout <= binp xor gin;
end architecture gray;

entity gray2bin is
    generic (
        size: natural := 3
    );
    port (
        gray: in bit_vector(size-1 downto 0);
        bin: out bit_vector(size-1 downto 0)
    );
end entity;