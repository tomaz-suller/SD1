entity alarme is
    port(
        j0, j1, j2, j3, en0, p: in bit;
        s0: out bit
    );
end entity;

architecture portas of alarme is
    signal j2n, j3n: bit;
begin        
    j2n <= not j2;
    j3n <= not j3;
    s0 <= p or ((j0 or j1 or j2n or j3n) and en0);
end architecture;
