--Aleksander Wind 2023
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity AES is
	port
	(
		--inputs
		clk 			: in std_logic; -- clock signal
		reset 			: in std_logic; -- reset
		start_of_data 	: in std_logic; -- start of message text on data_in, i.e. first byte of the message
		start_of_key	: in std_logic; -- start of message text on data_in, i.e. first byte of the message
		data_in 		: in std_logic_vector(1024 downto 0); -- Message to be en-/decrypted
		key_length 		: in integer;
		enc_or_dec 		: in std_logic;
		key_in 			: in std_logic_vector(127 downto 0);	-- (255 downto 0);
		
		--outputs
		text_out 		: out std_logic_vector(1 downto 0); -- TODO: Define max size of output message
	);
end entity AES;

architecture AES_arch of AES is
--	Signals
--		Global
--			Write
				signal round_index	: integer = 0;
				signal clk_s		: std_logic = 'Z';
--			Read
				
--		Key generation
--			Write
				signal start_ks 	: std_logic = '0';
				signal key_in_s		: std_logic_vector(127 downto 0) = (others => '0');
--			Read
				signal done_ks 		: std_logic = 'Z';
				-- signal round_key_s ???
	
	
	component cryptography_round is
		port
		(
			clk : in std_logic;
		);
	end component;
	
	component key_schedule is
		port
		(
			start_ks : in std_logic; -- Start key schedule
			clk : in std_logic;
			key : in std_logic_vector(127 downto 0); -- Initial key
			
			--round_key : out std_logic_vector(127 downto 0); -- 10 round keys 
			done_ks : out std_logic; -- Finish key schedule
		);
	end component;

	begin

		cryptography_round_instance : cryptography_round port map
		(
			clk => clk,
		);
		
		key_schedule_instance : key_schedule port map
		(			
			start_ks => start_ks,
			clk => clk_s_glob,
			key => key_in_s,
			round_key => round_key,
			-- round_key
			done_ks => done_ks
		);

	process(clk)
	begin

		if rising_edge(clk) then
			if start_
		end if;

	end process;

end AES_arch;

