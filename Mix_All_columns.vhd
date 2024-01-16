library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mix_All_columns is
    Port
	(
		clk : in std_logic;
		input_byte: in STD_LOGIC_Vector(127 downto 0);
		output_byte : out STD_LOGIC_Vector(127 downto 0)
    );
		
end entity Mix_All_columns;

architecture Behavioral of Mix_All_columns is


	component Mix_column is
	     Port(input_byte: in STD_LOGIC_Vector(31 downto 0);
	        output_byte : out STD_LOGIC_Vector(31 downto 0);
			clk : in std_logic);
	end component;

	begin

		First_column_mix : Mix_column
				port map(
							input_byte => input_byte(31 downto 0),
							output_byte => output_byte(31 downto 0),
							clk => clk);	
		
		Second_column_mix : Mix_column
				port map(
							input_byte => input_byte(63 downto 32),
							output_byte => output_byte(63 downto 32),
							clk => clk);	

		Third_column_mix : Mix_column
				port map(
							input_byte => input_byte(95 downto 64),
							output_byte => output_byte(95 downto 64),
							clk => clk);	
		Last_column_mix : Mix_column
				port map(
							input_byte => input_byte(127 downto 96),
							output_byte => output_byte(127 downto 96),
						        clk => clk);

end Behavioral;