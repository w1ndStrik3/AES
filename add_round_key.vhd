-- This program adds each byte of state is with a byte of round key.
-- Completion time: 1 cycle

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_round_key is
    port (
        data_in : in std_logic_vector(127 downto 0); -- State/mixColumns result

		round_key : in std_logic_vector(127 downto 0); -- Previous round key
		data_out : out std_logic_vector(127_downto 0);
        --new_key : out std_logic_vector(127 downto 0); -- New round key
		clk : in std_logic
    );
end add_round_key;

architecture behavioral of add_round_key is
begin
	-- XOR state bytes with round key bytes
	process(clk)
	begin
		if rising_edge(clk) then
		
			
			--for i in 0 to 15 loop
			--	new_key(i*8+7 downto i*8) <= prev_key(i*8+7 downto i*8) xor data_in(i*8+7 downto i*8);
			--end loop;
			--new_key <= prev_key(0*8+7 downto 0*8)   xor input_byte(0*8+7 downto 0*8);
			--new_key <= prev_key(1*8+7 downto 1*8)   xor input_byte(1*8+7 downto 1*8);
			--new_key <= prev_key(2*8+7 downto 2*8)   xor input_byte(2*8+7 downto 2*8); 
			--new_key <= prev_key(3*8+7 downto 3*8)   xor input_byte(3*8+7 downto 3*8);
			--new_key <= prev_key(4*8+7 downto 4*8)   xor input_byte(4*8+7 downto 4*8);
			--new_key <= prev_key(5*8+7 downto 5*8)   xor input_byte(5*8+7 downto 5*8);
			--new_key <= prev_key(6*8+7 downto 6*8)   xor input_byte(6*8+7 downto 6*8);
			--new_key <= prev_key(7*8+7 downto 7*8)   xor input_byte(7*8+7 downto 7*8);
			--new_key <= prev_key(8*8+7 downto 8*8)   xor input_byte(8*8+7 downto 8*8);
			--new_key <= prev_key(9*8+7 downto 9*8)   xor input_byte(9*8+7 downto 9*8);
			--new_key <= prev_key(10*8+7 downto 10*8) xor input_byte(10*8+7 downto 10*8);
			--new_key <= prev_key(11*8+7 downto 11*8) xor input_byte(11*8+7 downto 11*8);
			--new_key <= prev_key(12*8+7 downto 12*8) xor input_byte(12*8+7 downto 12*8);
			--new_key <= prev_key(13*8+7 downto 13*8) xor input_byte(13*8+7 downto 13*8);
			--new_key <= prev_key(14*8+7 downto 14*8) xor input_byte(14*8+7 downto 14*8);
			--new_key <= prev_key(15*8+7 downto 15*8) xor input_byte(15*8+7 downto 15*8);
		end if;
	end process;

end behavioral;