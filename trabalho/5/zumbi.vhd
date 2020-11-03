library ieee;
use ieee.numeric_bit.rising_edge;

entity zumbi is
    port(
        clock, reset: in bit;
        x: in bit_vector(1 downto 0);
        z: out bit
    );
end entity;

architecture estrutural of zumbi is
    component ffd is
        port (
            clock, clear, set: in bit;
            d: in bit;
            q, q_n: out bit
        );
    end component;

    signal d0, d1, q0, q1, q0_n, q1_n: bit;

begin
    ffd1: ffd port map(clock, reset, '0', d1, q1, q1_n);
    ffd0: ffd port map(clock, reset, '0', d0, q0, q0_n);

    d1 <= x(0) and (q1 or not x(1));
    d0 <= x(1) and ( (q1 xor q0) or not x(0) );

    z <= q0;
end architecture;

architecture fsm of zumbi is
    
    type states is (S, S2, AVp, AVi);
    signal curr_st, next_st: states;
    
    function debug(cs: states) return string is
    begin
        if cs = S then
            return "S";
        elsif cs = S2 then
            return "S2";
        elsif cs = AVp then
            return "AVp";
        elsif cs = AVi then
            return "AVi";
        else
            return "UNK";
        end if;
    end;

begin

    next_st <= 
        S when x = "00"                     else
        S when curr_st = S and x = "11"     else
        S2 when x = "10"                    else
        S2 when curr_st = S2 and x = "11"   else
        AVp when x = "01"                   else
        AVp when curr_st = AVi and x = "11" else
        AVi when curr_st = AVp and x = "11" else
        S;

    action: process(clock, reset)
    begin
        if reset = '1' then
            curr_st <= S;
        elsif rising_edge(clock) then
            curr_st <= next_st;
            
            report "Current state: " & debug(curr_st);
            report "X: " & bit'image(x(1)) & bit'image(x(0));
            report "Next state: " & debug(next_st);
            report "";

        end if;
    end process;

    z <= '1' when curr_st = S2 or curr_st = AVi else '0';

end fsm;

