-- This program shifts bytes in each row of state to the right. 
-- Row 0 unchanged, row 1 shifts one, row 2 shifts two, row 3 shifts three.

-- Completion time: 1 cycle.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inv_shift_rows is
    port (
        input_isr : in std_logic_vector(127 downto 0);
        output_isr : out std_logic_vector(127 downto 0);
        clk : in std_logic
    );
end inv_shift_rows;

architecture behavioral of inv_shift_rows is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            output_isr(0*8+7 downto 0*8) <= input_isr(0*8+7 downto 0*8);
            output_isr(1*8+7 downto 1*8) <= input_isr(13*8+7 downto 13*8);
            output_isr(2*8+7 downto 2*8) <= input_isr(10*8+7 downto 10*8);
            output_isr(3*8+7 downto 3*8) <= input_isr(7*8+7 downto 7*8);
            output_isr(4*8+7 downto 4*8) <= input_isr(4*8+7 downto 4*8);
            output_isr(5*8+7 downto 5*8) <= input_isr(1*8+7 downto 1*8);
            output_isr(6*8+7 downto 6*8) <= input_isr(14*8+7 downto 14*8);
            output_isr(7*8+7 downto 7*8) <= input_isr(11*8+7 downto 11*8);
            output_isr(8*8+7 downto 8*8) <= input_isr(8*8+7 downto 8*8);
            output_isr(9*8+7 downto 9*8) <= input_isr(5*8+7 downto 5*8);
            output_isr(10*8+7 downto 10*8) <= input_isr(2*8+7 downto 2*8);
            output_isr(11*8+7 downto 11*8) <= input_isr(15*8+7 downto 15*8);
            output_isr(12*8+7 downto 12*8) <= input_isr(12*8+7 downto 12*8);
            output_isr(13*8+7 downto 13*8) <= input_isr(9*8+7 downto 9*8);
            output_isr(14*8+7 downto 14*8) <= input_isr(6*8+7 downto 6*8);
            output_isr(15*8+7 downto 15*8) <= input_isr(3*8+7 downto 3*8);  
	end if;
end process;

end architecture;
