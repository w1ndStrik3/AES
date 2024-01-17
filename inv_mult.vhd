-- This program handles the multiplication for inverse mix columns.

-- Completion time: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity inv_mult is
    port (
	  	clk : in std_logic;
	  	input_im: in std_logic_vector(7 downto 0);
		output_9 : out std_logic_vector(7 downto 0);
		output_11 : out std_logic_vector(7 downto 0);
		output_13 : out std_logic_vector(7 downto 0);
		output_14 : out std_logic_vector(7 downto 0)
    );
		
end entity inv_mult;

architecture behavioral of inv_mult is

	signal shift_3 : std_logic_vector(7 downto 0);
	signal shift_2 : std_logic_vector(7 downto 0);
	signal shift_1 : std_logic_vector(7 downto 0);

	signal ir_poly9 : std_logic_vector(7 downto 0);
	signal ir_poly11 : std_logic_vector(7 downto 0);
	signal ir_poly13 : std_logic_vector(7 downto 0);
	signal Ir_poly14 : std_logic_vector(7 downto 0);

begin

	ir_poly9 <= ("0" & input(7) & input(7) & '0' & input(7) & input(7) & "00") 
			XOR ("00" & input(6) & input(6) & '0' & input(6) & input(6) & "0")
			XOR ("000" & input(5) & input(5) & '0' & input(5) & input(5) );

	ir_poly11 <= ir_poly9 XOR ("000" & input(7) & input(7) & '0' & input(7) & input(7));

	ir_poly13 <= ir_poly9 XOR ("00" & input(7) & input(7) & '0' & input(7) & input(7) & "0")
				XOR ("000" & input(6) & input(6) & '0' & input(6) & input(6));
					
	Ir_poly14 <= ir_poly13 XOR ("000" & input(7) & input(7) & '0' & input(7) & input(7));


	shift_3 <= input(4 downto 0) & "000";
	shift_2 <= input(5 downto 0) & "00";
	shift_1 <= input(6 downto 0) & "0";

process(clk)
	begin
	if rising_edge(clk) then



output_9 <= shift_3 XOR input XOR ir_poly9;

output_11 <= shift_3 XOR shift_1 XOR input XOR ir_poly11;

output_13 <= shift_3 XOR shift_2 XOR input XOR ir_poly13; 

output_14 <= shift_3 XOR shift_2 XOR shift_1 XOR Ir_poly14;

	end if;
end process;
end behavioral;