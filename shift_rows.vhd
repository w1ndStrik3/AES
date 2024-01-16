-- This program shifts bytes in each row of state to the left. 
-- Row 0 unchanged, row 1 shifts one, row 2 shifts two, row 3 shifts three.

-- Completion time: 1 cycle.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_rows is
    port 
	(
        input_sr : in std_logic_vector(127 downto 0);
        output_sr : out std_logic_vector(127 downto 0);
        clk : in std_logic
    );
end shift_rows;

architecture behavioral of shift_rows is

begin
	process(clk)
	begin
		if rising_edge(clk) then
			output_byte(0*8+7 downto 0*8) <= input_byte(0*8+7 downto 0*8);
			output_byte(1*8+7 downto 1*8) <= input_byte(5*8+7 downto 5*8);
			output_byte(2*8+7 downto 2*8) <= input_byte(10*8+7 downto 10*8);
			output_byte(3*8+7 downto 3*8) <= input_byte(15*8+7 downto 15*8);
			output_byte(4*8+7 downto 4*8) <= input_byte(4*8+7 downto 4*8);
			output_byte(5*8+7 downto 5*8) <= input_byte(9*8+7 downto 9*8);
			output_byte(6*8+7 downto 6*8) <= input_byte(14*8+7 downto 14*8);
			output_byte(7*8+7 downto 7*8) <= input_byte(3*8+7 downto 3*8);
			output_byte(8*8+7 downto 8*8) <= input_byte(8*8+7 downto 8*8);
			output_byte(9*8+7 downto 9*8) <= input_byte(13*8+7 downto 13*8);
			output_byte(10*8+7 downto 10*8) <= input_byte(2*8+7 downto 2*8);
			output_byte(11*8+7 downto 11*8) <= input_byte(7*8+7 downto 7*8);
			output_byte(12*8+7 downto 12*8) <= input_byte(12*8+7 downto 12*8);
			output_byte(13*8+7 downto 13*8) <= input_byte(1*8+7 downto 1*8);
			output_byte(14*8+7 downto 14*8) <= input_byte(6*8+7 downto 6*8);
			output_byte(15*8+7 downto 15*8) <= input_byte(11*8+7 downto 11*8);  
	end if;
end process;

end architecture;