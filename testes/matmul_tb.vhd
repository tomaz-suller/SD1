entity matmul_tb is
end entity;

architecture arch of matmul_tb is

    component matmul is
        generic(
            rows: in integer := 3;
            cols: in integer := 7
        );
        port(
            H: in bit_vector( (rows*cols) - 1 downto 0);
            v: in bit_vector(cols-1 downto 0);
            Hv: out bit_vector(rows-1 downto 0) 
            -- mem_data-1 * (mem_data-u_data-1)
        );
    end component;

    signal in_matrix: bit_vector(3 downto 0);
    signal in_vector: bit_vector(1 downto 0);
    signal out_vector: bit_vector(1 downto 0);

begin

    dut: matmul
        generic map(rows=>2, cols=>2) 
        port map(in_matrix, in_vector, out_vector);

    tb: process
    begin

        report "BOT";

        report "EOT";
        wait;

    end process;

end arch; 