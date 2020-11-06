entity toplevel is
    port(
        clock, reset, vai: in bit;
        cargaA, cargaB: in bit_vector(3 downto 0); 
        pronto: out bit
    );
end entity;

architecture arch of toplevel is

    component fd is
        port (
          clock, reset: in bit;
          loadA, loadB, selEntrada: in bit;
          A, B: in bit_vector(3 downto 0)
        );
    end component;

    component control is
        port(
            clock, reset, vai: in bit;
            loadA, loadB, selEntrada, pronto: out bit
        );
    end component;

    signal lA, lB, sE: bit;

begin

    fluxo: fd port map(clock, reset, lA, lB, sE, cargaA, cargaB);
    controle: control port map(clock, reset, vai, lA, lB, sE, pronto);

end arch; 