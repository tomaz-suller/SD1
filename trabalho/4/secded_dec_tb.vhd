
library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;
use work.computation.all;
use work.utils.all;

entity secded_dec_tb is
end entity;

architecture arch of secded_dec_tb is

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

    signal m_d: bit_vector(7 downto 0);
    signal u_d: bit_vector(3 downto 0);
    signal u_e: bit;

begin

    dut: secded_dec
        generic map(data_size => 4)
        port map(m_d, u_d, u_e);

    tb: process
    begin

        report "BOT";

        assert secded_message_size(4) = 8 report "Tamanho falhou!" severity error;

        m_d <= "00101001";
        wait for 4 ns;
        report "OUTPUT: " & to_bstring(u_d); 

        report "EOT";
        wait;
    end process;

end arch;