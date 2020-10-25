library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;

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

library ieee;
use ieee.numeric_bit.all;
use ieee.math_real.all;
use work.computation.all;

entity matmul is
    generic(
        rows: in integer := 3;
        cols: in integer := 7
    )
    port(
        rows, cols: in integer;
        H: in bit_vector( (rows*cols) - 1 downto 0);
        v: in bit_vector(cols-1 downto 0);
        Hv: out bit_vector(rows-1 downto 0) 
        -- mem_data-1 * (mem_data-u_data-1)
    );
end entity;

architecture arch of matmul is 

begin
    for i in rows-1 downto 0 generate
        for j in cols-1 downto 0 generate
        
        end generate;
    end generate;

end arch;
