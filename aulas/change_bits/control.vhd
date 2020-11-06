entity control is
    port(
        clock, reset, vai: in bit;
        loadA, loadB, selEntrada, pronto: out bit
    );
end entity;

architecture arch of control is
    type estados is (s0, s1, s2, s3, s4, s5);
    signal atual, prox: estados;
begin
    process(clock, reset)
    begin
        if reset = '1' then
            atual <= s0;
        elsif clock = '1' and clock'event then
            atual <= prox;
        end if;
    end process;

    prox <=
        s0 when atual = s0 and vai = '0' else
        s1 when atual = s0 and vai = '1' else
        s2 when atual = s1 else
        s3 when atual = s2 else
        s4 when atual = s3 else
        s5 when atual = s4 else
        s0;

    loadA <= '1' when atual = s1 or atual = s2 or atual = s4
    else '0';
    loadB <= '1' when atual = s1 or atual = s3
    else '0';
    selEntrada <= '1' when atual = s2 or atual = s3 or atual = s4
    else '0';

    pronto <= '1' when atual = s5 else '0';

end arch;