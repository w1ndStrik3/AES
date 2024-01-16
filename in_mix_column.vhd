-- This program adds each byte of state is with a byte of round key.

-- Completion time: 1 cycle.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity inv_mix_column is
    port ( 
		input_imc : in std_logic_vector(31 downto 0);
        output_imc : out std_logic_vector(31 downto 0);
		clk : in std_logic
	);
		
end entity inv_mix_column;

architecture behavioral of inv_mix_column is

	component inverse_mult is
		port (
			clk : in std_logic;
			input : in std_logic_vector(7 downto 0);
			output_9 : out std_logic_vector(7 downto 0);
			output_11 : out std_logic_vector(7 downto 0);
			output_13 : out std_logic_vector(7 downto 0);
			output_14 : out std_logic_vector(7 downto 0)
			);
			
	end component;

	signal byte0x9 : std_logic_vector(7 downto 0);
	signal byte0x11 : std_logic_vector(7 downto 0);
	signal byte0x13 : std_logic_vector(7 downto 0);
	signal byte0x14 : std_logic_vector(7 downto 0);

	signal byte1x9 : std_logic_vector(7 downto 0);
	signal byte1x11 : std_logic_vector(7 downto 0);
	signal byte1x13 : std_logic_vector(7 downto 0);
	signal byte1x14 : std_logic_vector(7 downto 0);

	signal byte2x9 : std_logic_vector(7 downto 0);
	signal byte2x11 : std_logic_vector(7 downto 0);
	signal byte2x13 : std_logic_vector(7 downto 0);
	signal byte2x14 : std_logic_vector(7 downto 0);

	signal byte3x9 : std_logic_vector(7 downto 0);
	signal byte3x11 : std_logic_vector(7 downto 0);
	signal byte3x13 : std_logic_vector(7 downto 0);
	signal byte3x14 : std_logic_vector(7 downto 0);

begin

byte0_mult : inverse_mult
		port map(
			 input => input_imc(7 downto 0),
			 output_9 => byte0x9(7 downto 0),
                         output_11 => byte0x11(7 downto 0),
                         output_13 => byte0x13(7 downto 0),
                         output_14 => byte0x14(7 downto 0),
			 clk => clk);	

byte1_mult : inverse_mult
		port map(
			 input => input_imc(15 downto 8),
			 output_9 => byte1x9(7 downto 0),
                         output_11 => byte1x11(7 downto 0),
                         output_13 => byte1x13(7 downto 0),
                         output_14 => byte1x14(7 downto 0),
			 clk => clk);

byte2_mult : inverse_mult
		port map(
			 input => input_imc(23 downto 16),
			 output_9 => byte2x9(7 downto 0),
                         output_11 => byte2x11(7 downto 0),
                         output_13 => byte2x13(7 downto 0),
                         output_14 => byte2x14(7 downto 0),
			 clk => clk);

byte3_mult : inverse_mult
		port map(
			 input => input_imc(31 downto 24),
			 output_9 => byte3x9(7 downto 0),
                         output_11 => byte3x11(7 downto 0),
                         output_13 => byte3x13(7 downto 0),
                         output_14 => byte3x14(7 downto 0),
			 clk => clk);

output_imc(7 downto 0) <= byte0X14 XOR byte1x11 xor byte2x13 xor byte3x9;
output_imc(15 downto 8) <= byte0X9 XOR byte1x14 xor byte2x11 xor byte3x13;
output_imc(23 downto 16) <= byte0X13 XOR byte1x9 xor byte2x14 xor byte3x11;
output_imc(31 downto 24) <= byte0X11 XOR byte1x13 xor byte2x9 xor byte3x14;

end architecture;
