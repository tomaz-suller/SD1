use work.utils.all;

entity matmul_tb is
end entity;

architecture arch of matmul_tb is

    component matmul is
        generic(
            rows: in integer := 5;
            cols: in integer := 21
        );
        port(
            H: in bit_vector( (rows*cols) - 1 downto 0);
            v: in bit_vector(cols-1 downto 0);
            Hv: out bit_vector(rows-1 downto 0) 
            -- mem_data-1 * (mem_data-u_data-1)
        );
    end component;

    signal in_matrix: bit_vector(20 downto 0);
    signal in_vector: bit_vector(6 downto 0);
    signal out_vector: bit_vector(2 downto 0);

begin

    dut: matmul
        generic map(rows=>3, cols=>7) 
        port map(in_matrix, in_vector, out_vector);

    tb: process
    begin

        report "BOT";

        in_matrix <= "111100011001101010101";
        in_vector <= "0010001";
        wait for 4 ns;

        assert in_matrix(19) = '1' report "Nao e!" severity warning;
        report "Output:" & to_bstring(out_vector);

        report "EOT";
        wait;

    end process;

end arch; 