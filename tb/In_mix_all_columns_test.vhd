
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY In_mix_all_columns_test IS
END In_mix_all_columns_test;
 
ARCHITECTURE behavior OF In_mix_all_columns_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT In_mix_all_columns
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
   uut: in_mix_all_columns PORT MAP (
	clk => clk,
	input_byte => input_byte,
	output_byte => output_byte
        );





-- Stimulus process
stim_proc: process
begin
input_byte(7 downto 0) <= "00000001"; -- with no overflow
input_byte(15 downto 8) <= "00000011";
input_byte(23 downto 16) <= "00000111";
input_byte(31 downto 24) <= "00001111";

input_byte(39 downto 32) <= "00000001"; -- with no overflow
input_byte(47 downto 40) <= "00000011";
input_byte(55 downto 48) <= "00000111";
input_byte(63 downto 56) <= "00001111";

input_byte(71 downto 64) <= "00000001"; -- with no overflow
input_byte(79 downto 72) <= "00000011";
input_byte(87 downto 80) <= "00000111";
input_byte(95 downto 88) <= "00001111";

input_byte(103 downto 96) <= "00000001"; -- with no overflow
input_byte(111 downto 104) <= "00000011";
input_byte(119 downto 112) <= "00000111";
input_byte(127 downto 120) <= "00001111";




   wait;
end process;



END;

