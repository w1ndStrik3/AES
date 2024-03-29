
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Mix_All_columns_test IS
END Mix_All_columns_test;
 
ARCHITECTURE behavior OF Mix_All_columns_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mix_All_columns
     Port(input_byte: in STD_LOGIC_Vector(127 downto 0);
        output_byte : out STD_LOGIC_Vector(127 downto 0);
		clk : in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input_byte : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs

   signal output_byte : std_logic_vector(127 downto 0) := (others => '0');



BEGIN

  clk <= not clk after 1 ns;

	-- Instantiate the Unit Under Test (UUT)
   uut: Mix_All_columns PORT MAP (
	clk => clk,
	input_byte => input_byte,
	output_byte => output_byte
        );





-- Stimulus process
stim_proc: process
begin
input_byte(7 downto 0) <= x"e5"; 
input_byte(15 downto 8) <= x"98";
input_byte(23 downto 16) <= x"27";
input_byte(31 downto 24) <= x"1e";

input_byte(39 downto 32) <= x"f1"; 
input_byte(47 downto 40) <= x"11";
input_byte(55 downto 48) <= x"41";
input_byte(63 downto 56) <= x"b8";

input_byte(71 downto 64) <= x"ae"; 
input_byte(79 downto 72) <= x"52";
input_byte(87 downto 80) <= x"b4";
input_byte(95 downto 88) <= x"e0";

input_byte(103 downto 96) <= x"30"; 
input_byte(111 downto 104) <= x"5d";
input_byte(119 downto 112) <= x"bf";
input_byte(127 downto 120) <= x"d4";





   wait;
end process;

--  00010101000100110000000100001000000101010001001100000001000010000001010100010011000000010000100000010101000100110000000100001000
--  11010101110100111100000111001000110101011101001111000001110010001101010111010011110000011100100011010101110100111100000111001000

END;

