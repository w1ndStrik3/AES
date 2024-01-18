library IEEE;
-- This module recieves a byte and the using a finite field to make polynominel multiplikation with 2 and 3, and sends 2 bytes as the output.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Mult is
     Port(
	  clk : in std_logic;
	  input: in STD_LOGIC_Vector(7 downto 0);
			 output_2 : out STD_LOGIC_Vector(7 downto 0);
			 output_3 : out STD_LOGIC_Vector(7 downto 0);
                         output_1 : out STD_LOGIC_Vector(7 downto 0)
          );
		
end entity Mult;

architecture Behavioral of Mult is


begin
process(clk)
	begin
	if rising_edge(clk) then



output_2 <= (input(6 downto 0) & '0') XOR ("000" & input(7) & input(7) &  '0' & input(7) & input(7)); 

output_3 <= (input(6 downto 0) & '0') XOR input(7 downto 0) XOR ("000" & input(7) & input(7) &  '0' & input(7) & input(7));

output_1 <= input;

	end if;
end process;
end Behavioral;