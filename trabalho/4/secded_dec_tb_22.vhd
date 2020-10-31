
library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;
use work.computation.all;
use work.utils.all;

entity secded_dec_tb_22 is
end entity;

architecture arch of secded_dec_tb_22 is

    component secded_dec is
        generic(
            data_size: positive := 16
        );
        port (
            mem_data: in bit_vector(secded_message_size(data_size)-1 downto 0);
            u_data: out bit_vector(data_size-1 downto 0);
            uncorrectable_error: out bit
        );
    end component;

    signal m_d: bit_vector(21 downto 0);
    signal u_d: bit_vector(15 downto 0);
    signal u_e: bit;

begin

    dut: secded_dec port map(m_d, u_d, u_e);

    tb: process
    begin

        report "BOT";

        assert secded_message_size(16) = 22 report "Tamanho falhou!" severity error;
        
        m_d <= "";
        wait for 4 ns;
        report "OUTPUT 1: " & to_bstring(u_d); 

        m_d <= "";
        wait for 4 ns;
        report "OUTPUT 2: " & to_bstring(u_d); 

        report "EOT";
        wait;
    end process;

end arch;