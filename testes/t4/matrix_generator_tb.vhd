entity matrix_generator_tb is
end entity;

use work.computation.secded_message_size;

architecture arch of matrix_generator_tb is

    component matrix_generator is
        generic(
            data_size: positive := 4
        );
    
        port(
            H: out bit_vector( (secded_message_size(data_size)-1)*(secded_message_size(data_size)-1-data_size) - 1 downto 0) 
            -- mem_data-1 * (mem_data-u_data-1)
        );
    end component;

    signal d_s: integer;
    signal parities: bit_vector(20 downto 0);

begin

    dut: matrix_generator
        --generic map(d_s) 
        port map(parities);

    tb: process
    begin

        report "BOT";

        d_s <= 4;
        wait for 1 ns;
        assert parities = "111100011001101010101" report "Falhou!" severity warning;
        
        report "EOT";
        wait;
    end process;

end arch;