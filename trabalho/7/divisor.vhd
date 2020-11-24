entity registrador_universal is
    generic (
        word_size: positive := 4
    );
    port (
        clock, clear, set, enable: in bit;
        control: in bit_vector(1 downto 0);
        serial_input: in bit;
        parallel_input: in bit_vector(word_size-1 downto 0);
        parallel_output: out bit_vector(word_size-1 downto 0)
    );
end entity;

architecture arch of registrador_universal is 
    signal regis: bit_vector(word_size-1 downto 0);
begin

    reg: process(clock)
    begin

        if clear = '1' then
            regis <= (others => '0');
        elsif set = '1' then
            regis <= (others => '1');
        elsif enable = '1' then
            if clock'event and clock = '1' then

                if control = "00" then
                    regis <= regis;

                elsif control = "01" then
                    rshift: for i in word_size-2 downto 0 loop
                        regis(i) <= regis(i+1);
                    end loop;
                    regis(word_size-1) <= serial_input;

                elsif control = "10" then
                    lshift: for i in word_size-1 downto 1 loop
                        regis(i) <= regis(i-1);
                    end loop;
                    regis(0) <= serial_input; 

                elsif control = "11" then
                    regis <= parallel_input;
                end if;

            end if;
        end if;   
            
    end process;

    parallel_output <= regis;

end arch;

------------------------------

entity div_uc is
    port(
        clock, reset, vai, comp: in bit;
        loadA, loadB, clearQ, calcula, pronto: out bit
    );
end entity;

architecture arch of div_uc is
    type estado is (init, carrega, inter, subtrai, fim);
    signal atual, proximo: estado; 
begin

    process(clock, reset)
    begin
        if reset = '1' then
            atual <= init;
        elsif clock'event and clock = '1' then
            atual <= proximo;
        end if;
    end process;

    proximo <= 
        carrega when atual = init   and vai = '1'   else
        inter   when atual = carrega                else
        inter   when atual = subtrai                else
        subtrai when atual = inter  and comp = '1'  else
        fim     when atual = inter  and comp = '0'  else
        init;

    loadA <= '1' when atual = carrega or atual = subtrai
    else '0';
    loadB <= '1' when atual = carrega
    else '0';
    clearQ <= '1' when atual = carrega
    else '0';
    calcula <= '1' when atual = subtrai
    else '0';
    pronto <= '1' when atual = fim
    else '0';

end arch;

------------------------------

library ieee;
use ieee.numeric_bit.all;

entity div_fd is
    generic(
        word_size: positive
    );
    port(
        clock: in bit;
        loadA, loadB, clearQ, calcula: in bit;
        A, B: in bit_vector(word_size-1 downto 0);
        comp: out bit;
        resto, quociente: out bit_vector(word_size-1 downto 0)
    );
end entity;

architecture arch of div_fd is
    
    component registrador_universal is
        generic (
            word_size: positive := 4
        );
        port (
            clock, clear, set, enable: in bit;
            control: in bit_vector(1 downto 0);
            serial_input: in bit;
            parallel_input: in bit_vector(word_size-1 downto 0);
            parallel_output: out bit_vector(word_size-1 downto 0)
        );
    end component;
    
    signal ctrlA, ctrlB: bit_vector(1 downto 0);
    signal inA, outA, outB, inQ, outQ: bit_vector(word_size-1 downto 0);

begin

    regA: registrador_universal
        generic map(word_size)
        port map(clock, '0', '0', '1', ctrlA, inA, outA);
    regB: registrador_universal
        generic map(word_size)
        port map(clock, '0', '0', '1', ctrlB, B, outB);
    contQ: registrador_universal
        generic map(word_size)
        port map(clock, clearQ, '0', calcula, "11", inQ, outQ);

    ctrlA <= loadA & loadA;
    ctrlB <= loadB & loadB;

    inA <= A when calcula = '0' else bit_vector( unsigned(A) - unsigned(B) )
    resto <= outA;
    comp <= ( unsigned(A) >= unsigned(B) );
    inQ <= bit_vector( unsigned(outQ) + 1 );


end arch;

------------------------------

entity divisor is -- toplevel
    generic(
        word_size: positive
    );
    port (
        clock, reset, vai: in bit;
        pronto: out bit;
        A, B: in bit_vector(word_size-1 downto 0);
        resultado, resto: out bit_vector(word_size-1 downto 0)
    );
end entity;

architecture toplevel of divisor is

    component div_uc is
        port(
            clock, reset, vai, comp: in bit;
            loadA, loadB, clearQ, calcula, pronto: out bit
        );
    end component;

    component div_fd is
        generic(
            word_size: positive
        );
        port(
            clock: in bit;
            loadA, loadB, clearQ, calcula: in bit;
            A, B: in bit_vector(word_size-1 downto 0);
            comp: out bit;
            resto, quociente: out bit_vector(word_size-1 downto 0)
        );
    end component;

    signal comp, loadA, loadB, clearQ, calcula, pronto: bit;

begin

    controle: div_uc
        port map(clock, reset, vai, comp, loadA, loadB, clearQ, calcula, pronto);
    dados: div_fd
        generic map(word_size)
        port map(clock, loadA, loadB, clearQ, calcula, A, B, comp, resto, resultado);

end toplevel;