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

entity mult_uc is
    port(
        clock, reset, vai, zero: in bit;
        pronto: out bit;
        loadA, loadB, clearR, loadR, enableB: out bit
    );
end entity;

architecture arch of mult_uc is
    type estado is (s0, s1, s2, s3, s4);
    signal atual, proximo: estado;
begin

    process(clock, reset, vai, zero)
    begin
        if reset = '1' then
            atual <= s0;
        elsif clock'event and clock = '1' then
            atual <= proximo;
        end if;
    end process;

    proximo <=
        s1 when atual = s0 and vai = '1'    else
        s2 when atual = s1                  else 
        s2 when atual = s3                  else
        s3 when atual = s2 and zero = '0'   else
        s4 when atual = s2 and zero = '1'   else
        s0;

    loadA <= '1' when atual = s1 
    else '0';
    loadB <= '1' when atual = s1
    else '0';
    clearR <= '1' when atual = s1
    else '0';
    loadR <= '1' when atual = s3
    else '0';
    enableB <= '1' when atual = s3 
    else '0';
    pronto <= '1' when atual = s4
    else '0';

end arch;

------------------------------

library ieee;
use ieee.numeric_bit.all;

entity mult_fd is
    generic(
        word_size: positive
    );
    port(
        clock: in bit;
        loadA, loadB, clearR, loadR, enableB: in bit;
        A, B: in bit_vector(word_size-1 downto 0);
        zero: out bit;
        resultado: out bit_vector(2*word_size-1 downto 0)
    );
end entity;

architecture arch of mult_fd is

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
    
    signal ctrlA, ctrlB, ctrlR: bit_vector(1 downto 0);
    signal outA, inB, outB, zero_p: bit_vector(word_size-1 downto 0);
    signal soma, res: bit_vector(2*word_size-1 downto 0);
    
begin

    ctrlA <= loadA & loadA;
    ctrlB <= (loadB or enableB) & (loadB or enableB);
    ctrlR <= loadR & loadR;

    regA: registrador_universal
        generic map(word_size)
        port map(clock, '0', '0', '1', ctrlA, '0', A, outA);
    regR: registrador_universal
        generic map(2*word_size)
        port map(clock, clearR, '0', '1', ctrlR, '0', soma, res);
    contB: registrador_universal
        generic map(word_size)
        port map(clock, '0', '0', '1', ctrlB, '0', inB, outB);

    soma <= bit_vector( unsigned(outA) + unsigned(res) );
    inB <= B when loadB = '1' else bit_vector( unsigned(outB) - 1 );

    process(outB)
    begin
        zero <= '0';
        if unsigned(outB) = 0 then
            zero <= '1';
        end if;
    end process;
    resultado <= res;

end arch;

------------------------------

entity multiplicador is -- toplevel
    generic(
        word_size: positive
    );
    port (
        clock, reset, vai: in bit;
        pronto: out bit;
        A, B: in bit_vector(word_size-1 downto 0);
        resultado: out bit_vector(2*word_size-1 downto 0)
    );
end entity;

architecture toplevel of multiplicador is
    
    component mult_uc is
        port(
            clock, reset, vai, zero: in bit;
            pronto: out bit;
            loadA, loadB, clearR, loadR, enableB: out bit
        );
    end component;

    component mult_fd is
        generic(
            word_size: positive
        );
        port(
            clock: in bit;
            loadA, loadB, clearR, loadR, enableB: in bit;
            A, B: in bit_vector(word_size-1 downto 0);
            zero: out bit;
            resultado: out bit_vector(2*word_size-1 downto 0)
        );
    end component;
    
    signal zero: bit;
    signal loadA, loadB, clearR, loadR, enableB: bit;

begin

    controle: mult_uc
        port map(clock, reset, vai, zero, pronto, loadA, loadB, clearR, loadR, enableB);
    dados: mult_fd
        generic map(word_size)
        port map(clock, loadA, loadB, clearR, loadR, enableB, A, B, zero, resultado);

end toplevel;