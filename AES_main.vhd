--Aleksander Wind 2023
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity AES is
	port
	(
		--inputs
		clk 			: in std_logic; -- clock signal
		reset 			: in std_logic; -- reset
		read_msg 		: in std_logic; -- start of message text on msg_in, i.e. the whole message
		read_key		: in std_logic; -- start of key on key_in, i.e. the whole key
		msg_in 			: in std_logic_vector(127 downto 0); -- Message to be en-/decrypted
		key_length 		: in integer;
		--enc_or_dec 		: in std_logic;
		key_in 			: in std_logic_vector(127 downto 0); -- (255 downto 0);
		--round_key_m		:
		
		--outputs
		text_out 		: out std_logic_vector(127 downto 0) -- TODO: Define max size of output message
	);
end entity AES;

architecture AES_arch of AES is
--	Signals
--		Global
--			Write
				signal round_idx_s	: integer := 0;
				signal rounds_s		: integer := 0;
--			Read
				--signal clk_s		: std_logic := 'Z';

--		Internal
--			Read/Write
				--signal kg_in_prgs	: std_logic = '0';
				signal enc_or_dec_s	: std_logic := '0';

--		Key generation
--			Write
				signal rst_ks_s 	: std_logic := '0';
				signal key_in_s		: std_logic_vector(127 downto 0) := (others => '0');
--			Read
				signal done_ks_s 	: std_logic := 'Z';
				signal rkey_s		: round_key_t;

--		Cryptography
--			Write
				signal message_s	: std_logic_vector(127 downto 0) := (others => '0');
				signal msg_rcvd_s 	: std_logic := '0';
--			Read
				signal state_s		: std_logic_vector(127 downto 0) := (others => 'Z');
	
	component encryption_round is
		port
		(
			clk : in std_logic;
		);
	end component;
	
	component decryption_round is
		port
		(
			clk : in std_logic;
		);
	end component;
	
	component key_schedule is
		port
		(
			clk : in std_logic;
			rst_ks : in std_logic; -- Start key schedule
			rounds : in integer; -- Max. rounds. Specify 10, 12 or 14 in testbench
			round_idx : in integer;			
			key : in std_logic_vector(127 downto 0); -- Cipher key. Adjust size if 192/256
			rkey : out round_key_t;
			done_ks : out std_logic -- Finish key schedule
		);
	end component;

	begin

		encryption_round_instance : cryptography_round port map
		(
			clk => clk
		);
		
		decryption_round_instance : cryptography_round port map
		(
			clk => clk
		);
		
		key_schedule_instance : key_schedule port map
		(
			clk => clk,
			rst_ks => rst_ks_s,
			rounds => rounds_s,
			key => key_in_s,
			round_key => round_key_s,
			done_ks => done_ks_s
		);

	process(clk)
	begin

		if rising_edge(clk) then
		
			if read_key = '1' then
			
				rst_ks_s <= '1';
				key_in_s <= key_in;

				if 		(key_length = 128) 	then 	(rounds_s) <= 10;
				elsif 	(key_length = 192) 	then 	(rounds_s) <= 12;
				elsif 	(key_length = 256) 	then 	(rounds_s) <= 14;
				end if;
				
			end if;
			
			if rst_ks_s = '1' then
			
				rst_ks_s <= '0';
				
			end if;
			
			if read_msg = '1' then
				
				message_s <= msg_in;
				msg_rcvd <= '1';
				
			end if;
			
			if done_ks_s = '1' then
				--if 
			end if;
			
			
		end if;

	end process;

end AES_arch;