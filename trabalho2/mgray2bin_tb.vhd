entity mgray2bin_tb is
end entity;

architecture testbench of mgray2bin_tb is
    
    component gray2bin is
        generic (
            size: natural := 3
        );
        port (
            gray: in bit_vector(size-1 downto 0);
            bin: out bit_vector(size-1 downto 0)
        );
    end component;
    
    signal g, b: bit_vector(3 downto 0);

begin

    dut: gray2bin
        generic map(size => 4)
        port map(gray=>g, bin=>b);
    
    tb_process: process
    begin

        report "BOT";

        g <= "0011";
        wait for 1 ns;
        assert b = "0010" report "Teste 2 falhou!" severity warning;
        
        g <= "0101";
        wait for 1 ns;
        assert b = "0110" report "Teste 6 falhou!" severity warning;

        g <= "1111";
        wait for 1 ns;
        assert b = "1010" report "Teste 10 falhou!" severity warning;

        report "EOT";
        wait;
    end process;

end testbench;

