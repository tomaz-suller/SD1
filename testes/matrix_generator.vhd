library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;
library work;
use work.computation.all;

package computation is
    function secded_message_size(data_size: positive) return integer;
end computation;

package body computation is
    function secded_message_size(data_size: positive) return integer is
    begin
        return data_size + 2 + integer( floor(log2(real(data_size))) );
    end function;
end computation;

--------------------------------------------

entity matrix_generator is
    generic(
        data_size: positive := 4
    );

    port(
        H: out bit_vector(104 downto 0)
        -- H: out bit_vector( (secded_message_size(data_size)-1)*(secded_message_size(data_size)-1-data_size) - 1 downto 0) 
        -- mem_data-1 * (mem_data-u_data-1)
    );
end entity;

architecture arch of matrix_generator is

begin
    -- data_size = 16 -> mem_data'length = 22 & u_data'length = 16
    l: for i in 4 downto 0 generate -- (mem_data-u_data-2) downto 0
        c: for j in 21 downto 1 generate -- mem_data-1 downto 1
            H( 22*i+j ) <= '1' when to_integer(unsigned( ( bit_vector(to_unsigned(integer(2**real(i)), 5)) and bit_vector(to_unsigned(j, 5)) ) )) /= 0 else '0';
            -- H( mem_data*i+j ) <= '1' when to_integer(unsigned( ( bit_vector(to_unsigned(integer(2**real(i)), integer(ceil(log2(real(mem_data))))) 
        end generate;
    end generate;

end arch;