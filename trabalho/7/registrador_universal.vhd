library ieee;
use ieee.numeric_bit.rising_edge;

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
            if rising_edge(clock) then

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