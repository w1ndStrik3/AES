-- This program mixes the columns in a round.

-- Completion time: 2 cycles.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mix_all_columns is
    Port
	(
		clk : in std_logic;
		input_mac: in std_logic_vector(127 downto 0);
		output_mac : out std_logic_vector(127 downto 0)
    );
		
end entity mix_all_columns;

architecture behavioral of mix_all_columns is


	component mix_column is
	    port (
			input_mac : in std_logic_vector(31 downto 0);
	        output_mac : out std_logic_vector(31 downto 0);
			clk : in std_logic
			);
	end component;

	begin

		first_column_mix : mix_column
				port map (
							input_mac => input_mac(31 downto 0),
							output_mac => output_mac(31 downto 0),
							clk => clk
						 );	
		
		second_column_mix : mix_column
				port map (
							input_mac => input_mac(63 downto 32),
							output_mac => output_mac(63 downto 32),
							clk => clk
						 );	

		third_column_mix : mix_column
				port map(
							input_mac => input_mac(95 downto 64),
							output_mac => output_mac(95 downto 64),
							clk => clk);	
		last_column_mix : mix_column
				port map(
							input_mac => input_mac(127 downto 96),
							output_mac => output_mac(127 downto 96),
						        clk => clk);

end behavioral;