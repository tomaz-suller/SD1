entity gcd_uc is
    port (
        clock, reset: in bit;
        vai, AigualB, AmaiorB: in bit;
        carregaA, carregaB, BmA, sub, fim: out bit
    );
end entity;

architecture arch of gcd_uc is

    type states is (ini, carr, acabou, calc);
    signal pe, ea: states;
begin

    transicao: process(clock, reset)
    begin
        if reset = '1' then
            ea <= ini;
        elsif clock'event and clock = '1' then
            ea <= pe;
        end if;
    end process;

    asm: process(ea, vai, AigualB, AmaiorB)
    begin

        carregaA <= '0';
        carregaB <= '0';
        BmA <= '0';
        sub <= '0';
        fim <= '0';
        
        case(ea) is
            when ini =>
                if vai = '1' then
                    pe <= carr;
                    carregaA <= '1';
                    carregaB <= '1';
                end if;

            when carr =>
                if AigualB = '1' then pe <= acabou;
                else pe <= calc;
                end if;

            when acabou =>
                fim <= '1';
                pe <= ini;

            when calc =>
                sub <= '1';
                pe <= carr;
                if AmaiorB = '1' then
                    carregaA <= '1';
                else
                    BmA <= '1';
                    carregaB <= '1';
                end if;

            when others =>
                pe <= ini;
        end case ;
    end process;

end arch;