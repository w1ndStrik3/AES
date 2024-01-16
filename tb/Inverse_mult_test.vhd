
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY inverse_mult_test IS
END inverse_mult_test;
 
ARCHITECTURE behavior OF inverse_mult_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT inverse_mult	
     Port(	 
	  clk : in std_logic;
	  input: in STD_LOGIC_Vector(7 downto 0);
	  output_9 : out STD_LOGIC_Vector(7 downto 0);
	  output_11 : out STD_LOGIC_Vector(7 downto 0);
	  output_13 : out STD_LOGIC_Vector(7 downto 0);
	  output_14 : out STD_LOGIC_Vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs

   signal output_9 : std_logic_vector(7 downto 0) := (others => '0');
   signal output_11 : std_logic_vector(7 downto 0) := (others => '0');
   signal output_13 : std_logic_vector(7 downto 0) := (others => '0');
   signal output_14 : std_logic_vector(7 downto 0) := (others => '0');



BEGIN

  clk <= not clk after 1 ns;

	-- Instantiate the Unit Under Test (UUT)
   uut: inverse_mult PORT MAP (
	clk => clk,
	input => input,
	output_9 => output_9,
	output_11 => output_11,
	output_13 => output_13,
	output_14 => output_14
        );





-- Stimulus process
stim_proc: process
begin
input(7 downto 0) <= "00000001"; -- with no overflow
wait for 4 ns;
input(7 downto 0) <= "00000011";
wait for 4 ns;
input(7 downto 0) <= "00000111";
wait for 4 ns;
input(7 downto 0) <= "00001111";

wait for 4 ns;
input(7 downto 0) <= "11100001"; -- with overflow
wait for 4 ns;
input(7 downto 0) <= "11100011";
wait for 4 ns;
input(7 downto 0) <= "11100111";
wait for 4 ns;
input(7 downto 0) <= "11101111";




   wait;
end process;



END;

