--Aleksander Wind 2023
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity AES is
	port
	(
		--inputs
		clk : in std_logic; -- clock signal
		reset : in std_logic; -- reset
		start_of_data : in std_logic; -- start of ip packet on data_in, i.e. first byte of header
		data_in : in std_logic_vector(7 downto 0); -- actual IP	packet data
		key_length : in integer;
		key_in : in std_logic_vector	-- (255 downto 0);
		
		--outputs
		text_out : out std_logic_vector(1 downto 0); -- TODO: Define max size of output message
	);
end entity AES;

architecture AES_arch of AES is

	component cryptography_round is
		port
		(
			clk : in std_logic;
		);
	end component;
	
	component key_schedule is
		port
		(
			clk : in std_logic;
		);
	end component;

	begin

		cryptography_round_instance : cryptography_round port map
		(
			clk => sig_vd_clk,
		);
		
		key_schedule_instance : key_schedule port map
		(
			clk => sig_vd_clk,
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

