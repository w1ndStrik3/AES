--Aleksander Wind 2023
--DEBUG means used only for debugging. Not used to validate checksum
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity validator is
	port
	(
		clk : in std_logic;
		--inputs
		vd_start : in std_logic;
		vd_data_in : in std_logic_vector(7 downto 0);
		--sum : in std_logic_vector(15 downto 0);
		--byte_index : in std_logic_vector(4 downto 0);
		--count_done : in std_logic;
		
		--outputs
		vd_check_done : out std_logic;
		vd_result : out std_logic
	);
end entity validator;

architecture validator_arch of validator is

	signal int_index : integer := 0;
	signal sum : std_logic_vector(19 downto 0) := "00000000000000000000";
	signal res : std_logic := '0';
	signal done : std_logic := '0';
	signal sum16 : std_logic_vector(15 downto 0) := "0000000000000000";
	--DEBUG signal int_sum : integer := 0;
	--DEBUG signal res_tot : integer := 0;

	begin
	process(clk)
	begin
		if rising_edge(clk) then
	
			if vd_start = '1' then
		
				sum <= "0000" & vd_data_in & "00000000";
				done <= '0';
				int_index <= 0;
				sum16 <= "0000000000000000";
				res <= '0';
				
			elsif int_index = 19 then
		
				sum16 <= std_logic_vector(unsigned(sum(15 downto 0)) + resize(unsigned(sum(19 downto 16)), 16));
				int_index <= int_index + 1;
				
			elsif int_index = 20 then
			
				done <= '1';
		
				if unsigned(sum16) = 65535 then
					res <= '1';
					--DEBUG res_tot <= res_tot + 1;
				else
					res <= '0';
				end if;
		
			elsif int_index mod 2 = 1 then
		
				sum <= std_logic_vector(unsigned(sum) + unsigned(vd_data_in & "00000000"));
				int_index <= int_index + 1;
				
			else
			
				sum <= std_logic_vector(unsigned(sum) + unsigned("00000000" & vd_data_in));
				int_index <= int_index + 1;
				
			end if;
			
		--DEBUG int_sum <= to_integer(unsigned(sum));
		vd_result <= res;
		vd_check_done <= done;
		
		end if;

	end process;
end validator_arch;