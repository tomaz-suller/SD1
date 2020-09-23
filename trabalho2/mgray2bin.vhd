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

architecture iterative of gray2bin is

    component g is
        port(
            gin: in bit;
            binp: in bit;
            bout: out bit
        );
    end component;

    signal outp: bit;
    signal temp: bit_vector(size-1 downto 0);

begin
    grays: for i in size-1 downto 0 generate
    
        g0: if i=(size-1) generate
            gi: g port map(gray(i), '0', temp(i));
        end generate;

        general: if i<(size-1) generate
            gi: g port map(gray(i), temp(i+1), temp(i));
        end generate;

    end generate grays;

    bin <= temp;

end architecture iterative;