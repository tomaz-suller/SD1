entity incinerador_tb is
end entity;

architecture tb of incinerador_tb is

    component incinerador is
        port (
            S: in bit_vector(2 downto 0);
            P: out bit
        );
    end component;

    signal sensores: bit_vector(2 downto 0);
    signal porta: bit;

begin

    dut: incinerador
        port map(sensores, porta);

    tb_process: process
    begin

        report "BOT";

        sensores <= "000";
        wait for 1 ns;
        assert porta = '0' report "Teste 0 falhou!" severity warning;
        
        
        sensores <= "001";
        wait for 1 ns;
        assert porta = '0' report "Teste 1 falhou!" severity warning;
        
        
        sensores <= "010";
        wait for 1 ns;
        assert porta = '0' report "Teste 2 falhou!" severity warning;
        
        
        sensores <= "011";
        wait for 1 ns;
        assert porta = '1' report "Teste 3 falhou!" severity warning;
        
        
        sensores <= "100";
        wait for 1 ns;
        assert porta = '0' report "Teste 4 falhou!" severity warning;
        
        
        sensores <= "101";
        wait for 1 ns;
        assert porta = '1' report "Teste 5 falhou!" severity warning;
        
        
        sensores <= "110";
        wait for 1 ns;
        assert porta = '1' report "Teste 6 falhou!" severity warning;
        
        
        sensores <= "111";
        wait for 1 ns;
        assert porta = '1' report "Teste 7 falhou!" severity warning;

        report "EOT";
        wait;
    
    end process;

end architecture tb;