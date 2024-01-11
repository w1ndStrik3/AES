library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mix_column is
     Port(input_byte: in STD_LOGIC_Vector(31 downto 0);
        output_byte : out STD_LOGIC_Vector(31 downto 0);
		clk : in std_logic);
		
end entity Mix_column;

architecture Behavioral of Mix_column is
signal C11 : std_logic_vector (7 downto 0);
signal C12 : std_logic_vector (7 downto 0);
signal C13 : std_logic_vector (7 downto 0);
signal C14 : std_logic_vector (7 downto 0);

signal C21 : std_logic_vector (7 downto 0);
signal C22 : std_logic_vector (7 downto 0);
signal C23 : std_logic_vector (7 downto 0);
signal C24 : std_logic_vector (7 downto 0);

signal C31 : std_logic_vector (7 downto 0);
signal C32 : std_logic_vector (7 downto 0);
signal C33 : std_logic_vector (7 downto 0);
signal C34 : std_logic_vector (7 downto 0);


signal C41 : std_logic_vector (7 downto 0);
signal C42 : std_logic_vector (7 downto 0);
signal C43 : std_logic_vector (7 downto 0);
signal C44 : std_logic_vector (7 downto 0);


Signal Ir_poly : std_logic_vector (7 downto 0); 
begin


Ir_poly <= "00011011";


process(clk)
	begin
	if rising_edge(clk) then
---------------------- We first find the first byte in the column-----------------------------------	
		if input_byte(7) = '1' then
		C11 <= (input_byte(6 downto 0) & '0') XOR Ir_poly; -- if  poly overflow
		else C11 <= input_byte(6 downto 0) & '0'; -- if not overflow when *2
		end if; -- the first byte of the of the first XOR is found 
		
		if input_byte(15) = '1' then
		C12 <= (input_byte(14 downto 8) & '0') XOR (input_byte(15 downto 8)) XOR Ir_poly; -- if poly overflow when *3 
		else C12 <= (input_byte(14 downto 8) & '0') XOR (input_byte(15 downto 8)); -- if not overflow when *3
		end if; -- the second byte of the second first XOR is found

		C13 <= input_byte(23 downto 16);
		C14 <= input_byte(31 downto 24);	
---------------------- the first output byte is ready -------------------------------------------		
		
---------------------- Time for the second byte in the column ----------------------------------

		if input_byte(15) = '1' then
		C22 <= (input_byte(14 downto 8) & '0') XOR Ir_poly; -- if overflow when *2
		else C22 <= input_byte(14 downto 8) & '0'; -- if not overflow when *2
		end if; 
		
		if input_byte(23) = '1' then
		C23 <= (input_byte(22 downto 16) & '0') XOR (input_byte(23 downto 16)) XOR Ir_poly; -- if overflow when *3
		else C23 <= (input_byte(22 downto 16) & '0') XOR (input_byte(23 downto 16)); -- if not overflow when *3
		end if; 

		C21 <= input_byte(7 downto 0);
		C24 <= input_byte(31 downto 24);	

---------------------- Time for the third byte in the column ----------------------------------

		if input_byte(23) = '1' then
		C33 <= (input_byte(22 downto 16) & '0') XOR Ir_poly; -- if overflow when *2
		else C33 <= input_byte(22 downto 16) & '0'; -- if not overflow when *2
		end if; 
		
		if input_byte(31) = '1' then
		C34 <= (input_byte(30 downto 24) & '0') XOR (input_byte(31 downto 24)) XOR Ir_poly; -- if overflow when *3 
		else C34 <= (input_byte(30 downto 24) & '0') XOR (input_byte(31 downto 24)); -- if not overflow when *3
		end if; 

		C31 <= input_byte(7 downto 0);
		C32 <= input_byte(15 downto 8);	

---------------------- Time for the last byte in the column ----------------------------------

		if input_byte(31) = '1' then
		C44 <= (input_byte(30 downto 24) & '0') XOR Ir_poly; -- if overflow when *2
		else C44 <= input_byte(30 downto 24) & '0'; -- if not overflow when *2
		end if; 
		
		if input_byte(7) = '1' then
		C41 <= (input_byte(6 downto 0) & '0') XOR (input_byte(7 downto 0)) XOR Ir_poly; -- if overflow when *3 
		else C41 <= (input_byte(6 downto 0) & '0') XOR (input_byte(7 downto 0)); -- if not overflow when *3
		end if; 

		C43 <= input_byte(23 downto 16);
		C42 <= input_byte(15 downto 8);	

---------------------- Now all the different signals can be XOR and put in output signal ----------------------------------

output_byte(7 downto 0) <= C11 XOR C12 XOR C13 XOR C14;
output_byte(15 downto 8) <= C21 XOR C22 XOR C23 XOR C24;
output_byte(23 downto 16) <= C31 XOR C32 XOR C33 XOR C34;
output_byte(31 downto 24) <= C41 XOR C42 XOR C43 XOR C44;
 	
		
	
	end if;
end process;
end Behavioral;	
	