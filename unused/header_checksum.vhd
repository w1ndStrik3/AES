--Aleksander Wind 2023
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity header_checksum is
	port
	(
		--inputs
		clk : in std_logic; -- clock signal
		reset : in std_logic; -- reset
		start_of_data : in std_logic; -- start of ip packet on data_in, i.e. first byte of header
		data_in : in std_logic_vector(7 downto 0); -- actual IP	packet data
		
		--outputs
		cksum_calc : out std_logic; -- raised 1. Cycle when checksum calculation result is available on cksum_ok
		cksum_ok : out std_logic; -- Shows if checksum is valid. Only used when cksum_calc = '1'
		cksum_ok_cnt : out std_logic_vector(15 downto 0); -- count number of passed checksums
		cksum_ko_cnt : out std_logic_vector(15 downto 0) -- count number of failed checksums
	);
end entity header_checksum;

architecture header_checksum_arch of header_checksum is

	signal sig_vd_clk : std_logic := '0';
	signal sig_vd_start : std_logic := '0';
	signal sig_vd_data_in : std_logic_vector(7 downto 0) := "00000000";

	signal sig_vd_check_done : std_logic;
	signal sig_vd_result : std_logic;

	signal sig_ok_cnt : std_logic_vector(15 downto 0) := "0000000000000000";
	signal sig_ko_cnt : std_logic_vector(15 downto 0) := "0000000000000000";

	component validator is
		port
		(
			clk : in std_logic;
			vd_start : in std_logic;
			vd_data_in : in std_logic_vector(7 downto 0);
		
			vd_check_done : out std_logic;
			vd_result : out std_logic
		);
	end component;

	begin

		validator_instance : validator port map
		(
			clk => sig_vd_clk,
			vd_start => sig_vd_start,
			vd_data_in => sig_vd_data_in,
		
			vd_check_done => sig_vd_check_done,
			vd_result => sig_vd_result
		);

	process(clk)
	begin

		if rising_edge(clk) then
	
			if reset = '1' then
		
				sig_vd_clk <= '0';
				sig_vd_start <= '0';
				sig_vd_data_in <= "00000000";
			
				sig_vd_check_done <= 'L';
				sig_vd_result <= 'L';
			
				sig_ok_cnt <= "0000000000000000";
				sig_ko_cnt <= "0000000000000000";
		
			else
				sig_vd_clk <= clk;
				sig_vd_start <= start_of_data;
				sig_vd_data_in <= data_in;
			
				if sig_vd_check_done = '1' then
			
					if sig_vd_result = '1' then
				
						sig_ok_cnt <= std_logic_vector(unsigned(sig_ok_cnt) + 1);
				
					else
						sig_ko_cnt <= std_logic_vector(unsigned(sig_ko_cnt) + 1);
				
					end if;
				end if;
			end if;
		end if;
		
		if falling_edge(clk) then
		
			sig_vd_clk <= clk;
			sig_vd_start <= '0';
			
		end if;

	end process;

	cksum_ok_cnt <= sig_ok_cnt;
	cksum_ko_cnt <= sig_ko_cnt;
	cksum_calc <= sig_vd_check_done;
	cksum_ok <= sig_vd_result;

end header_checksum_arch;

