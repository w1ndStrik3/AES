library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inverse_mult is
     Port(
	  clk : in std_logic;
	  input: in STD_LOGIC_Vector(7 downto 0);
			 output_9 : out STD_LOGIC_Vector(7 downto 0);
			 output_11 : out STD_LOGIC_Vector(7 downto 0);
			 output_13 : out STD_LOGIC_Vector(7 downto 0);
			 output_14 : out STD_LOGIC_Vector(7 downto 0)
          );
		
end entity inverse_mult;

architecture Behavioral of inverse_mult is

signal shift_3 : STD_LOGIC_Vector(7 downto 0);
signal shift_2 : STD_LOGIC_Vector(7 downto 0);
signal shift_1 : STD_LOGIC_Vector(7 downto 0);


signal Ir_poly9 :STD_LOGIC_Vector(7 downto 0);
signal Ir_poly11 :STD_LOGIC_Vector(7 downto 0);
signal Ir_poly13 :STD_LOGIC_Vector(7 downto 0);
signal Ir_poly14 :STD_LOGIC_Vector(7 downto 0);



begin

Ir_poly9 <= ("0" & input(7) & input(7) & '0' & input(7) & input(7) & "00") 
	    XOR ("00" & input(6) & input(6) & '0' & input(6) & input(6) & "0")
	    XOR ("000" & input(5) & input(5) & '0' & input(5) & input(5) );

Ir_poly11 <= Ir_poly9 XOR ("000" & input(7) & input(7) & '0' & input(7) & input(7));

Ir_poly13 <= Ir_poly9 XOR ("00" & input(7) & input(7) & '0' & input(7) & input(7) & "0")
		      XOR ("000" & input(6) & input(6) & '0' & input(6) & input(6));
				 
Ir_poly14 <= Ir_poly13 XOR ("000" & input(7) & input(7) & '0' & input(7) & input(7));


shift_3 <= input(4 downto 0) & "000";
shift_2 <= input(5 downto 0) & "00";
shift_1 <= input(6 downto 0) & "0";

process(clk)
	begin
	if rising_edge(clk) then



output_9 <= shift_3 XOR input XOR Ir_poly9;

output_11 <= shift_3 XOR shift_1 XOR input XOR Ir_poly11;

output_13 <= shift_3 XOR shift_2 XOR input XOR Ir_poly13; 

output_14 <= shift_3 XOR shift_2 XOR shift_1 XOR Ir_poly14;

	end if;
end process;
end Behavioral;