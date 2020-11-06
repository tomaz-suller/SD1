entity fd is
  port (
    clock, reset: in bit;
    loadA, loadB, selEntrada: in bit;
    A, B: in bit_vector(3 downto 0)
  );
end entity;

architecture arch of fd is
  component reg is
    port (
      clock, reset, load: in bit;
      carga: in bit_vector(3 downto 0);
      saida: out bit_vector(3 downto 0)
    );
  end component;
  signal entradaA, entradaB, saidaA, saidaB, tmpXor: bit_vector(3 downto 0);
begin
  regA: reg port map(clock, reset, loadA, entradaA, saidaA);
  regB: reg port map(clock, reset, loadB, entradaB, saidaB);

  entradaA <= A when selEntrada = '0' else tmpXor;
  entradaB <= B when selEntrada = '0' else tmpXor;

  genXors: for i in 3 downto 0 generate
    tmpXor(i) <= saidaA(i) xor saidaB(i);
  end generate;

end architecture;
