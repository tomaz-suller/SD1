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
    
    signal g, b: bit_vector(2 downto 0);

begin

    dut: gray2bin
        -- generic map(size => 3)
        port map(gray=>g, bin=>b);
    
    tb_process: process
    begin

        report "BOT";

        g <= "001";
        wait for 1 ns;
        assert b = "001" report "Teste 1 falhou!" severity warning;
        
        g <= "010";
        wait for 1 ns;
        assert b = "011" report "Teste 3 falhou!" severity warning;

        g <= "110";
        wait for 1 ns;
        assert b = "100" report "Teste 4 falhou!" severity warning;

        g <= "100";
        wait for 1 ns;
        assert b = "111" report "Teste 8 falhou!" severity warning;

        report "EOT";
        wait;
    end process;

end testbench;

