library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

entity selector is
    port(
        u_data: in bit_vector(7 downto 0);
        mem_data: out bit_vector(3 downto 0)
    );
end entity;

architecture arch of selector is

    signal partial: bit_vector(3 downto 0);

begin
    s: for i in 7 downto 3 generate
        p: if log2(real(i)) /= floor(log2(real(i))) generate
            partial( i-2 - integer( floor(log2(real(i))) ) ) <= u_data(i-1);
        end generate;
    end generate;
    mem_data <= partial;

end architecture arch;