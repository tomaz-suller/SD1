entity gray2bin_tb is
end entity;

architecture testbench of gray2bin_tb is
    
    component gray2bin is
        generic (
            size: natural := 3
        );
        port (
            gray: in bit_vector(size-1 downto 0);
            bin: out bit_vector(size-1 downto 0)
        );
    end component;
    
    signal g, b: bit_vector(2 downto 0);

begin
