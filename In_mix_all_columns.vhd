--receives 127 bits and sends 4 bytes at a time to in_mix_column where the four bits gets transformed, and sends it to the 128 bit output
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity in_Mix_All_columns is
     Port(
	  clk : in std_logic;
	  input_byte: in STD_LOGIC_Vector(127 downto 0);
			 output_byte : out STD_LOGIC_Vector(127 downto 0)
          );
		
end entity in_Mix_All_columns;

architecture Behavioral of in_Mix_All_columns is


component in_mix_column is -- Declare the componet that is used by this module
     Port(input_byte: in STD_LOGIC_Vector(31 downto 0);
        output_byte : out STD_LOGIC_Vector(31 downto 0);
		clk : in std_logic);
end component;

begin

First_column_in_mix : in_mix_column -- 4 bytes are send to in_mix_column gets transformed and send it to output
		port map(
					input_byte => input_byte(127 downto 96),
					output_byte => output_byte(127 downto 96),
				        clk => clk);

Second_column_in_mix : in_mix_column-- 4 bytes are send to in_mix_column gets transformed and send it to output
		port map(
					input_byte => input_byte(95 downto 64),
					output_byte => output_byte(95 downto 64),
					clk => clk);
	
Third_column_in_mix : in_mix_column-- 4 bytes are send to in_mix_column gets transformed and send it to output
		port map(
					input_byte => input_byte(63 downto 32),
					output_byte => output_byte(63 downto 32),
					clk => clk);	
	
Last_column_in_mix : in_mix_column-- 4 bytes are send to in_mix_column gets transformed and send it to output
		port map(
					input_byte => input_byte(31 downto 0),
					output_byte => output_byte(31 downto 0),
					clk => clk);	

end Behavioral;