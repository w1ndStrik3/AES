-- Shifts bytes in each row of state to the left. 
-- Row 0 unchanged, row 1 shifts one, row 2 shifts two, row 3 shifts three.

--completion time: 1 cycle

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_rows is
    port (
        input_byte : in std_logic_vector(127 downto 0);
        output_byte : out std_logic_vector(127 downto 0);
        clk : in std_logic
    );
end shift_rows;

architecture behavioral of shift_rows is
begin
process(clk)
begin
	if rising_edge(clk) then
		for i from 0 to 15 loop
			output_byte(i*8+7 downto i*8) <= input_byte(i*8+7 downto i*8);
		end loop;
		
		-- Add code for inverse process / decryption

	end if;
end process;

end behavioral;
