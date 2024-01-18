-- This program enables defining ports as the specified type.

-- Completion time: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package round_key_arr_pkg is
	-- Array holds all round keys
	type round_key_t is array(0 to 10) of std_logic_vector(127 downto 0);
end package; 