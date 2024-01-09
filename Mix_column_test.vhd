
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Mix_column_test IS
END Mix_column_test;
 
ARCHITECTURE behavior OF Mix_column_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mix_column
     Port(input_byte: in STD_LOGIC_Vector(31 downto 0);
        output_byte : out STD_LOGIC_Vector(31 downto 0);
		clk : in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input_byte : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs

   signal output_byte : std_logic_vector(31 downto 0) := (others => '0');



BEGIN

  clk <= not clk after 1 ns;

	-- Instantiate the Unit Under Test (UUT)
   uut: Mix_column PORT MAP (
	clk => clk,
	input_byte => input_byte,
	output_byte => output_byte
        );





-- Stimulus process
stim_proc: process
begin
input_byte(7 downto 0) <= "00000001"; -- with no overflow
input_byte(15 downto 8) <= "00000010";
input_byte(23 downto 16) <= "00000100";
input_byte(31 downto 24) <= "00001000";

wait for 4 ns;
input_byte(7 downto 0) <= "11000001"; -- with overflow
input_byte(15 downto 8) <= "11000010";
input_byte(23 downto 16) <= "11000100";
input_byte(31 downto 24) <= "11001000";



   wait;
end process;



END;

