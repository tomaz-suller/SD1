library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

package computation is
    function secded_message_size(data_size: positive) return integer;
end computation;

package body computation is
    function secded_message_size(data_size: positive) return integer is
    begin
        return data_size + 2 + integer( floor(log2(real(data_size)+0.1)) );
    end function;
end computation;

--------------------------------------------

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;
use work.computation.all;

entity matrix_generator is
    generic(
        data_size: positive := 4
    );

    port(
        H: out bit_vector( (secded_message_size(data_size)-1)*(secded_message_size(data_size)-data_size-1) - 1 downto 0) 
    );
end entity;

architecture arch of matrix_generator is

begin
    l: for i in (secded_message_size(data_size) - data_size - 2) downto 0 generate 
        c: for j in (secded_message_size(data_size)-1) downto 1 generate 
            H( (secded_message_size(data_size)-1)*i+j-1 ) <= '1' when to_integer(unsigned( ( bit_vector(to_unsigned(integer(2**real(i)), 64)) and bit_vector(to_unsigned(j, 64)) ) )) /= 0 else '0';
        end generate;
    end generate;

end arch;

--------------------------------------------

entity matmul is
    generic(
        rows: in integer := 5;
        cols: in integer := 21
    );
    port(
        H: in bit_vector( (rows*cols)-1 downto 0);
        v: in bit_vector(cols-1 downto 0);
        Hv: out bit_vector(rows-1 downto 0) 
    );
end entity;

architecture arch of matmul is 
    
    signal pp: bit_vector( (rows*cols)-1 downto 0);

begin
    r: for i in rows-1 downto 0 generate
        c: for j in cols-1 downto 0 generate
            first: if j = 0 generate
                pp(i*cols) <= H(i*cols) and v(cols-1);
            end generate;

            general: if j > 0 generate
                pp(i*cols + j) <= ( H(i*cols + j) and v( cols-1 - j) ) xor pp(i*cols + j - 1);
            end generate;
            
        end generate;
        Hv(i) <= pp(i*cols + cols-1);
    end generate;

end arch;

--------------------------------------------

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;
use work.computation.all;

entity selector is
    generic(
        data_size: positive := 16
    );
    port(
        mem_data: in bit_vector(secded_message_size(data_size)-1 downto 0);
        u_data: out bit_vector(data_size-1 downto 0)
    );
end entity;

architecture arch of selector is

    signal partial: bit_vector(data_size-1 downto 0);

begin
    s: for i in secded_message_size(data_size)-1 downto 3 generate
        p: if to_integer( to_unsigned(i, 64) and to_unsigned(i-1, 64) ) /= 0  generate
            partial( i-2 - integer( floor(log2(real(i))) ) ) <= mem_data(i-1);
        end generate;
    end generate;
    u_data <= partial;

end architecture arch;

--------------------------------------------

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

use work.computation.all;

entity secded_dec is
    generic(
        data_size: positive := 16
    );
    port (
        mem_data: in bit_vector(secded_message_size(data_size)-1 downto 0);
        u_data: out bit_vector(data_size-1 downto 0);
        uncorrectable_error: out bit
    );
end entity;

architecture arch of secded_dec is


    component matrix_generator is
        generic(
            data_size: positive := 4
        );
    
        port(
            H: out bit_vector( (secded_message_size(data_size)-1)*(secded_message_size(data_size)-1-data_size) - 1 downto 0) 
        );
    end component;


    component matmul is
        generic(
            rows: in integer := 5;
            cols: in integer := 21
        );
        port(
            H: in bit_vector( (rows*cols)-1 downto 0);
            v: in bit_vector(cols-1 downto 0);
            Hv: out bit_vector(rows-1 downto 0) 
        );
    end component;


    component selector is
        generic(
            data_size: positive := 16
        );
        port(
            mem_data: in bit_vector(secded_message_size(data_size)-1 downto 0);
            u_data: out bit_vector(data_size-1 downto 0)
        );
    end component;

    
    signal syn: integer;
    signal syn_bv: bit_vector(secded_message_size(data_size)-data_size -2 downto 0);
    -- r-1
    signal parity_matrix: bit_vector( (secded_message_size(data_size)-1)*(secded_message_size(data_size)-data_size-1) - 1 downto 0);
    -- r*c -1 
    signal partial_xors, correct_mem_data: bit_vector(secded_message_size(data_size)-1 downto 0);
    -- c-1
    signal capped_mem: bit_vector(secded_message_size(data_size)-2 downto 0);
    signal overall_parity: bit;
    signal u_d: bit_vector(data_size-1 downto 0);

begin

    overall_parity <= mem_data( secded_message_size(data_size)-1 );

    matgen: matrix_generator
        generic map(data_size)
        port map(parity_matrix);
    
    capped_mem <= mem_data( secded_message_size(data_size)-2 downto 0 );
    
    syndrome: matmul
        generic map(secded_message_size(data_size)-data_size-1, secded_message_size(data_size)-1)
        port map(parity_matrix, capped_mem, syn_bv);
        
    syn <= to_integer(unsigned(syn_bv));

    with syn select uncorrectable_error <=
        '0' when 0,
        not overall_parity when others;

    correction: for i in secded_message_size(data_size)-1 downto 0 generate
        correct_mem_data(i) <= (not mem_data(i)) when i + syn + 1 = secded_message_size(data_size) else mem_data(i);
    end generate;

    selection: selector
        generic map(data_size)
        port map(correct_mem_data, u_d);
    
    u_data <= u_d;

end arch;