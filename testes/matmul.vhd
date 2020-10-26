
entity matmul is
    generic(
        rows: in integer := 5;
        cols: in integer := 21
    );
    port(
        H: in bit_vector( (rows*cols)-1 downto 0);
        v: in bit_vector(cols-1 downto 0);
        Hv: out bit_vector(rows-1 downto 0) 
    );
end entity;


architecture arch of matmul is 
    
    signal pp: bit_vector( (rows*cols)-1 downto 0);

begin
    r: for i in rows-1 downto 0 generate
        c: for j in cols-1 downto 0 generate
            first: if j = 0 generate
                pp(i*cols) <= H(i*cols) and v(0);
            end generate;

            general: if j > 0 generate
                pp(i*cols + j) <= ( H(i*cols + j) and v(j) ) xor pp(i*cols + j - 1);
            end generate;
            
        end generate;
        Hv(i) <= pp(i*cols + cols-1);
    end generate;

end arch;