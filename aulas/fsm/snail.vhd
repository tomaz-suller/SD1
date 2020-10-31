library ieee;
use ieee.numeric_bit.rising_edge;

entity snail is
    port(
        clock, reset, x: in bit;
        z: out bit
    );
end snail;

architecture structural of snail is

    component ffd is
        port(
            clock, clear, set: in bit;
            d: in bit;
            q, q_n: out bit
        );
    end component;

    signal d0, q0, q0_n: bit;
    signal d1, q1, q1_n: bit;

begin

    ffd0: fdd port map(clock, '0', 'reset', d0, q0, q0_n);
    ffd1: fdd port map(clock, '0', 'reset', d1, q1, q1_n);

    d0 <= (x and q0) or (not x and q1) or (q1_n and q0_n);
    d1 <= not x;
    z <= q1_n and q0_n;

end architecture structural;

architecture fsm of snail is

    type states is (ini, E1, E10, P);
    signal curr_st, next_st: states;
    
begin
    sync: process(clock, reset)
    begin
        if reset = '1' then
            next_st <= ini;
        elsif rising_edge(clock) then
            curr_st <= next_st;
        end if;
    end process;

    next_st <=
        ini when curr_st = ini and x = '0' else
        E1  when curr_st = ini and x = '1' else
        E1  when curr_st = E10 and x = '0' else
        E1  when curr_st = E1  and x = '1' else
        ini;

    z <= '1' when curr_st = P else '0';
    
end architecture fsm;