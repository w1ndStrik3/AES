--this module recives 4 bytes (a column), and sends it to mult one byte at a time, where the byte gets multiplied with 2 and 3. afterwards 
-- the output bytes is found by using XOR gates with the multiplied bytes
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mix_column is
     Port(input_mc: in STD_LOGIC_Vector(31 downto 0);
        output_mc : out STD_LOGIC_Vector(31 downto 0);
		clk : in std_logic);
		
end entity mix_column;

architecture Behavioral of mix_column is

component mult is -- Declare the componet that is used by this module
	Port(
	     clk : in std_logic;
	     input_m : in STD_LOGIC_Vector(7 downto 0);
	     output_2 : out STD_LOGIC_Vector(7 downto 0);
             output_3 : out STD_LOGIC_Vector(7 downto 0);
	     output_1 : out STD_LOGIC_Vector(7 downto 0)
          );
		
end component;


signal byte0x2 : STD_LOGIC_Vector(7 downto 0); -- input(7 downto 0) multiplied with 2
signal byte0x3 : STD_LOGIC_Vector(7 downto 0);
signal byte0x1 : STD_LOGIC_Vector(7 downto 0);


signal byte1x2 : STD_LOGIC_Vector(7 downto 0);
signal byte1x3 : STD_LOGIC_Vector(7 downto 0);
signal byte1x1 : STD_LOGIC_Vector(7 downto 0);

signal byte2x2 : STD_LOGIC_Vector(7 downto 0);
signal byte2x3 : STD_LOGIC_Vector(7 downto 0);
signal byte2x1 : STD_LOGIC_Vector(7 downto 0);

signal byte3x2 : STD_LOGIC_Vector(7 downto 0);
signal byte3x3 : STD_LOGIC_Vector(7 downto 0);
signal byte3x1 : STD_LOGIC_Vector(7 downto 0);


begin

byte0_mult : mult --first byte gets multiplied
		port map(
			 input_m => input_mc(31 downto 24),
			 output_2 => byte0x2(7 downto 0),
                         output_3 => byte0x3(7 downto 0),
                         output_1 => byte0x1(7 downto 0), 
			 clk => clk);	

byte1_mult : mult --second byte gets multiplied
		port map(
			 input_m => input_mc(23 downto 16),
			 output_2 => byte1x2(7 downto 0),
                         output_3 => byte1x3(7 downto 0),
                         output_1 => byte1x1(7 downto 0),
			 clk => clk);

byte2_mult : mult --third byte gets multiplied
		port map(
			 input_m => input_mc(15 downto 8),
			 output_2 => byte2x2(7 downto 0),
                         output_3 => byte2x3(7 downto 0),
                         output_1 => byte2x1(7 downto 0),
			 clk => clk);

byte3_mult : mult --fourth byte gets multiplied
		port map(
			 input_m => input_mc(7 downto 0),
			 output_2 => byte3x2(7 downto 0),
                         output_3 => byte3x3(7 downto 0),
                         output_1 => byte3x1(7 downto 0),
			 clk => clk);


output_mc(31 downto 24) <= byte0X2 XOR byte1x3 xor byte2x1 xor byte3x1; -- first output byte is found using XOR gates
output_mc(23 downto 16) <= byte0x1 XOR byte1x2 xor byte2x3 xor byte3x1;
output_mc(15 downto 8) <= byte0x1 XOR byte1x1 xor byte2x2 xor byte3x3;
output_mc(7 downto 0) <= byte0X3 XOR byte1x1 xor byte2x1 xor byte3x2;


end Behavioral;
