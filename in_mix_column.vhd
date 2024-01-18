--this module recives 4 bytes (a column), and sends it to in_mult one byte at a time, where the byte gets multiplied with 9, 11, 13 and 14. afterwards 
-- the output bytes is found by using XOR gates with the multiplied bytes
 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity in_Mix_column is
     Port(input_byte: in STD_LOGIC_Vector(31 downto 0);
        output_byte : out STD_LOGIC_Vector(31 downto 0);
		clk : in std_logic);
		
end entity in_Mix_column;

architecture Behavioral of in_Mix_column is


component inverse_mult is -- Declare the componet that is used by this module
	Port(
	     clk : in std_logic;
	     input: in STD_LOGIC_Vector(7 downto 0);
	     output_9 : out STD_LOGIC_Vector(7 downto 0);
	     output_11 : out STD_LOGIC_Vector(7 downto 0);
	     output_13 : out STD_LOGIC_Vector(7 downto 0);
	     output_14 : out STD_LOGIC_Vector(7 downto 0)
          );
		
end component;

signal byte0x9 : STD_LOGIC_Vector(7 downto 0); -- input(7 downto 0) multiplied with 9
signal byte0x11 : STD_LOGIC_Vector(7 downto 0);
signal byte0x13 : STD_LOGIC_Vector(7 downto 0);
signal byte0x14 : STD_LOGIC_Vector(7 downto 0);

signal byte1x9 : STD_LOGIC_Vector(7 downto 0);
signal byte1x11 : STD_LOGIC_Vector(7 downto 0);
signal byte1x13 : STD_LOGIC_Vector(7 downto 0);
signal byte1x14 : STD_LOGIC_Vector(7 downto 0);

signal byte2x9 : STD_LOGIC_Vector(7 downto 0);
signal byte2x11 : STD_LOGIC_Vector(7 downto 0);
signal byte2x13 : STD_LOGIC_Vector(7 downto 0);
signal byte2x14 : STD_LOGIC_Vector(7 downto 0);

signal byte3x9 : STD_LOGIC_Vector(7 downto 0);
signal byte3x11 : STD_LOGIC_Vector(7 downto 0);
signal byte3x13 : STD_LOGIC_Vector(7 downto 0);
signal byte3x14 : STD_LOGIC_Vector(7 downto 0);



begin

byte0_mult : inverse_mult --first byte gets multiplied
		port map(
			 input => input_byte(31 downto 24),
			 output_9 => byte0x9(7 downto 0),
                         output_11 => byte0x11(7 downto 0),
                         output_13 => byte0x13(7 downto 0),
                         output_14 => byte0x14(7 downto 0),
			 clk => clk);	

byte1_mult : inverse_mult --second byte gets multiplied
		port map(
			 input => input_byte(23 downto 16),
			 output_9 => byte1x9(7 downto 0),
                         output_11 => byte1x11(7 downto 0),
                         output_13 => byte1x13(7 downto 0),
                         output_14 => byte1x14(7 downto 0),
			 clk => clk);

byte2_mult : inverse_mult --third byte gets multiplied
		port map(
			 input => input_byte(15 downto 8),
			 output_9 => byte2x9(7 downto 0),
                         output_11 => byte2x11(7 downto 0),
                         output_13 => byte2x13(7 downto 0),
                         output_14 => byte2x14(7 downto 0),
			 clk => clk);

byte3_mult : inverse_mult --fourth byte gets multiplied
		port map(
			 input => input_byte(7 downto 0),
			 output_9 => byte3x9(7 downto 0),
                         output_11 => byte3x11(7 downto 0),
                         output_13 => byte3x13(7 downto 0),
                         output_14 => byte3x14(7 downto 0),
			 clk => clk);

output_byte(31 downto 24) <= byte0X14 XOR byte1x11 xor byte2x13 xor byte3x9; -- first output byte is found using XOR gates
output_byte(23 downto 16) <= byte0X9 XOR byte1x14 xor byte2x11 xor byte3x13;
output_byte(15 downto 8) <= byte0X13 XOR byte1x9 xor byte2x14 xor byte3x11;
output_byte(7 downto 0) <= byte0X11 XOR byte1x13 xor byte2x9 xor byte3x14;



end Behavioral;
