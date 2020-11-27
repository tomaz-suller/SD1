use work.utils.all;

entity bv_tb is 
end entity;

architecture arch of bv_tb is

    component bv is
        port(
            A, B: in bit_vector(3 downto 0);
            C: out bit_vector(3 downto 0);
            D: out bit_vector(31 downto 0)
        );
    end component;

    signal A, B, C: bit_vector(3 downto 0);
    signal D: bit_vector(31 downto 0);

begin

    dut: bv port map(A, B, C, D);

    tb: process
    begin
        report "BOT";

        A <= "1001";
        B <= "1010";
        wait for 5 ns;

        report "extend: " & to_bstring(D) severity warning; 

        report "EOT";
        wait;
    end process;

end architecture arch;