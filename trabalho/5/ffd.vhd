entity ffd is
    port (
        clock, clear, set: in bit;
        d: in bit;
        q, q_n: out bit
    );
end entity;
    
architecture arch of ffd is
    
begin
    meuffd: process(clock, clear, set)
        variable tmp: bit;
    begin
        if clear='1'then tmp:='0';
        elsif set='1'then tmp:='1';
        elsif clock'event and clock='1' then tmp := d;
        end if;
        q<=tmp; q_n<=not(tmp);
    end process;
end architecture;