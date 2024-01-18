-- Shifts bytes in each row of state to the left. 
-- Row 0 unchanged, row 1 shifts one, row 2 shifts two, row 3 shifts three.

-- Completion time: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inv_shift_rows is
    port (
        input_inv_sr : in std_logic_vector(127 downto 0);
        output_inv_sr : out std_logic_vector(127 downto 0);
        clk : in std_logic
    );
end inv_shift_rows;

architecture behavioral of inv_shift_rows is



begin
process(clk)
begin
	if rising_edge(clk) then
			output_inv_sr(15*8+7 downto 15*8) <= input_inv_sr(15*8+7 downto 15*8);
			output_inv_sr(14*8+7 downto 14*8) <= input_inv_sr(2*8+7 downto 2*8);
			output_inv_sr(13*8+7 downto 13*8) <= input_inv_sr(5*8+7 downto 5*8);
			output_inv_sr(12*8+7 downto 12*8) <= input_inv_sr(8*8+7 downto 8*8);
			output_inv_sr(11*8+7 downto 11*8) <= input_inv_sr(11*8+7 downto 11*8);
			output_inv_sr(10*8+7 downto 10*8) <= input_inv_sr(14*8+7 downto 14*8);
			output_inv_sr(9*8+7 downto 9*8) <= input_inv_sr(1*8+7 downto 1*8);
			output_inv_sr(8*8+7 downto 8*8) <= input_inv_sr(4*8+7 downto 4*8);
                        output_inv_sr(7*8+7 downto 7*8) <= input_inv_sr(7*8+7 downto 7*8);
                        output_inv_sr(6*8+7 downto 6*8) <= input_inv_sr(10*8+7 downto 10*8);
                        output_inv_sr(5*8+7 downto 5*8) <= input_inv_sr(13*8+7 downto 13*8);
                        output_inv_sr(4*8+7 downto 4*8) <= input_inv_sr(0*8+7 downto 0*8);
                        output_inv_sr(3*8+7 downto 3*8) <= input_inv_sr(3*8+7 downto 3*8);
                        output_inv_sr(2*8+7 downto 2*8) <= input_inv_sr(6*8+7 downto 6*8);
                        output_inv_sr(1*8+7 downto 1*8) <= input_inv_sr(9*8+7 downto 9*8);
                        output_inv_sr(0*8+7 downto 0*8) <= input_inv_sr(12*8+7 downto 12*8);  
		
		

	end if;
end process;

end behavioral;
