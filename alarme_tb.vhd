entity alarme_tb is
end alarme_tb;

architecture teste of alarme_tb is
    
    component alarme is -- Importa alarm da sua work
        port(
        j0, j1, j2, j3, en0, p: in bit;
        s0: out bit
        );
    end component;

    signal j0i, j1i, j2i, j3i, en0i, pi, s0i: bit;

begin
    dut: alarme port map(j0i, j1i, j2i, j3i, en0i, pi, s0i); -- Mapeamento das entradas de verdade as entradas

    teste1 : process -- Definicao de process : pro
    begin
        report "BOT"; -- Beginning Of test
        
        j0i <= '0'; j1i <= '0'; j2i <= '0'; j3i <= '0'; 
        en0i <= '0'; pi <= '0';
        wait for 1 ns; -- Tempo de simulacao pode ser qualquer
        assert s0i = '1' report "Caso 1 falhou!" severity warning; -- Verifica expressao senao manda warning
    

        report "EOT"; -- End Of Test
        wait; -- Indica para simulador que acabou
    end process;

end teste ; -- teste