
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Subbyte_test IS
END Subbyte_test;
 
ARCHITECTURE behavior OF Subbyte_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sub_bytes
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

 --input_byte(127 downto 0) <= (others => '0');
	-- Instantiate the Unit Under Test (UUT)
   uut: Sub_bytes PORT MAP (
	clk => clk,
	input_byte => input_byte,
	output_byte => output_byte
        );





-- Stimulus process
stim_proc: process
begin
input_byte(15 downto 8) <=  "00010000";
input_byte(23 downto 16) <= "00100000";
input_byte(31 downto 24) <= "00110000";
input_byte(39 downto 32) <= "01000000";

input_byte(47 downto 40) <= "01010000";
input_byte(55 downto 48) <= "01100000";
input_byte(63 downto 56) <= "01110000";
input_byte(71 downto 64) <= "10000000";

input_byte(79 downto 72) <= "10010000";
input_byte(87 downto 80) <= "10100000";
input_byte(95 downto 88) <= "10110000";
input_byte(103 downto 96) <= "11000000";

input_byte(111 downto 104) <= "11010000";
input_byte(119 downto 112) <= "11100000";
input_byte(127 downto 120) <= "11110000";

wait for 2 ns;

 --Alle 16 bytes får tildelt en starts værdi. Byte 0 = 0, Byte 1 = 16 osv.
   for i in 0 to 14 loop -- loopet kører 15 gange. På 16 clocks vil samtlige 256 byte kombinationer blive gennemgået fordelt på de 16 bytes.
      	input_byte(7 downto 0) <= input_byte(7 downto 0) + 1;
      	input_byte(15 downto 8) <=  input_byte(15 downto 8) + 1;
	input_byte(23 downto 16) <= input_byte(23 downto 16) + 1;
	input_byte(31 downto 24) <= input_byte(31 downto 24) + 1;
	input_byte(39 downto 32) <= input_byte(39 downto 32) + 1;

	input_byte(47 downto 40) <= input_byte(47 downto 40) + 1;
	input_byte(55 downto 48) <= input_byte(55 downto 48) + 1;
	input_byte(63 downto 56) <= input_byte(63 downto 56) + 1;
	input_byte(71 downto 64) <= input_byte(71 downto 64) + 1;

	input_byte(79 downto 72) <= input_byte(79 downto 72) + 1;
	input_byte(87 downto 80) <= input_byte(87 downto 80) + 1;
	input_byte(95 downto 88) <= input_byte(95 downto 88) + 1;
	input_byte(103 downto 96) <= input_byte(103 downto 96) + 1;

	input_byte(111 downto 104) <= input_byte(111 downto 104) + 1;
	input_byte(119 downto 112) <=input_byte(119 downto 112) + 1 ;
	input_byte(127 downto 120) <=input_byte(127 downto 120) + 1 ;	
	wait for 2 ns;
   end loop;
   wait;
end process;



END;

