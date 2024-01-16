-- This program adds each byte of state is with a byte of round key.

-- Completion time: 2 cycles.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mix_column is
    port (
		input_mc: in std_logic_vector(31 downto 0);
        output_mc : out std_logic_vector(31 downto 0);
		clk : in std_logic
		);
		
end entity mix_column;

architecture behavioral of mix_column is

	signal C11 : std_logic_vector(7 downto 0);
	signal C12 : std_logic_vector(7 downto 0);
	signal C13 : std_logic_vector(7 downto 0);
	signal C14 : std_logic_vector(7 downto 0);

	signal C21 : std_logic_vector(7 downto 0);
	signal C22 : std_logic_vector(7 downto 0);
	signal C23 : std_logic_vector(7 downto 0);
	signal C24 : std_logic_vector(7 downto 0);

	signal C31 : std_logic_vector(7 downto 0);
	signal C32 : std_logic_vector(7 downto 0);
	signal C33 : std_logic_vector(7 downto 0);
	signal C34 : std_logic_vector(7 downto 0);

	signal C41 : std_logic_vector(7 downto 0);
	signal C42 : std_logic_vector(7 downto 0);
	signal C43 : std_logic_vector(7 downto 0);
	signal C44 : std_logic_vector(7 downto 0);

	signal ir_poly : std_logic_vector(7 downto 0) := "00011011";

begin

	process(clk)
		begin
			if rising_edge(clk) then
		---------------------- We first find the first byte in the column-----------------------------------	
				if input_mc(7) = '1' then
				C11 <= (input_mc(6 downto 0) & '0') XOR ir_poly; -- if  poly overflow
				else C11 <= input_mc(6 downto 0) & '0'; -- if not overflow when *2
				end if; -- the first byte of the of the first XOR is found 
				
				if input_mc(15) = '1' then
				C12 <= (input_mc(14 downto 8) & '0') XOR (input_mc(15 downto 8)) XOR ir_poly; -- if poly overflow when *3 
				else C12 <= (input_mc(14 downto 8) & '0') XOR (input_mc(15 downto 8)); -- if not overflow when *3
				end if; -- the second byte of the second first XOR is found

				C13 <= input_mc(23 downto 16);
				C14 <= input_mc(31 downto 24);	
		---------------------- the first output byte is ready -------------------------------------------		
				
		---------------------- Time for the second byte in the column ----------------------------------

				if input_mc(15) = '1' then
				C22 <= (input_mc(14 downto 8) & '0') XOR ir_poly; -- if overflow when *2
				else C22 <= input_mc(14 downto 8) & '0'; -- if not overflow when *2
				end if; 
				
				if input_mc(23) = '1' then
				C23 <= (input_mc(22 downto 16) & '0') XOR (input_mc(23 downto 16)) XOR ir_poly; -- if overflow when *3
				else C23 <= (input_mc(22 downto 16) & '0') XOR (input_mc(23 downto 16)); -- if not overflow when *3
				end if; 

				C21 <= input_mc(7 downto 0);
				C24 <= input_mc(31 downto 24);	

		---------------------- Time for the third byte in the column ----------------------------------

				if input_mc(23) = '1' then
				C33 <= (input_mc(22 downto 16) & '0') XOR ir_poly; -- if overflow when *2
				else C33 <= input_mc(22 downto 16) & '0'; -- if not overflow when *2
				end if; 
				
				if input_mc(31) = '1' then
				C34 <= (input_mc(30 downto 24) & '0') XOR (input_mc(31 downto 24)) XOR ir_poly; -- if overflow when *3 
				else C34 <= (input_mc(30 downto 24) & '0') XOR (input_mc(31 downto 24)); -- if not overflow when *3
				end if; 

				C31 <= input_mc(7 downto 0);
				C32 <= input_mc(15 downto 8);	

		---------------------- Time for the last byte in the column ----------------------------------

				if input_mc(31) = '1' then
				C44 <= (input_mc(30 downto 24) & '0') XOR ir_poly; -- if overflow when *2
				else C44 <= input_mc(30 downto 24) & '0'; -- if not overflow when *2
				end if; 
				
				if input_mc(7) = '1' then
				C41 <= (input_mc(6 downto 0) & '0') XOR (input_mc(7 downto 0)) XOR ir_poly; -- if overflow when *3 
				else C41 <= (input_mc(6 downto 0) & '0') XOR (input_mc(7 downto 0)); -- if not overflow when *3
				end if; 

				C43 <= input_mc(23 downto 16);
				C42 <= input_mc(15 downto 8);	

		---------------------- Now all the different signals can be XOR and put in output signal ----------------------------------

				output_mc(7 downto 0) <= C11 XOR C12 XOR C13 XOR C14;
				output_mc(15 downto 8) <= C21 XOR C22 XOR C23 XOR C24;
				output_mc(23 downto 16) <= C31 XOR C32 XOR C33 XOR C34;
				output_mc(31 downto 24) <= C41 XOR C42 XOR C43 XOR C44;
			
		end if;
	end process;
end architecture;	