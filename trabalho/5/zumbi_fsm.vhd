library ieee;
use ieee.numeric_bit.rising_edge;

entity zumbi is
    port(
        clock, reset: in bit;
        x: in bit_vector(1 downto 0);
        z: out bit
    );
end entity;

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
        end if;
    end process;

    z <= '1' when curr_st = S2 or curr_st = AVi else '0';

end fsm;

