entity hamming is
    port(
        message: in bit_vector(3 downto 0);
        codeword: out bit_vector(7 downto 0)
    );
end entity hamming;

architecture matrix of hamming is

end architecture matrix;