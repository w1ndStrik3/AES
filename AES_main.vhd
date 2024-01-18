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
		msg_rd	 		: in std_logic; -- Message ready
		read_key		: in std_logic; -- start of key on key_in, i.e. the whole key
		msg_in 			: in std_logic_vector(127 downto 0); -- Message to be en-/decrypted
		-- key_length 		: in integer;
		--enc_or_dec 		: in std_logic;
		key_in 			: in std_logic_vector(127 downto 0); -- (255 downto 0);
		--round_key_m		:
		
		--outputs
		text_out 		: out std_logic_vector(127 downto 0) -- TODO: Define max size of output message
	) := 
end entity AES;

architecture AES_arch of AES is
--	Signals
--		Global
--			Write
				--signal round_idx_s	: integer := 0;
				signal rounds_s			: integer := 0;
--			Read	
				signal ciphertext 		: std_logic_vector(127 downto 0) := (others => 'Z');
				--signal clk_s			: std_logic := 'Z';

--		Internal
--			Read/Write
				--signal kg_in_prgs		: std_logic = '0';
				signal enc_or_dec_s		: std_logic := '0';

--		Key generation
--			Write
				signal rst_ks_s 		: std_logic := '0';
				signal key_in_s			: std_logic_vector(127 downto 0) := (others => '0');
--			Read	
				signal done_ks_s 		: std_logic := 'Z';
				signal rkey_s			: round_key_t;
				signal round_idx_ks_s	: integer := 99;

--		Cryptography
--			Write
				signal message_s		: std_logic_vector(127 downto 0) := (others => '0');
				signal msg_rc_s 		: std_logic := '0';
				signal start_enc_s		: std_logic := '0';
--			Read
				signal ciph_txt_s			: std_logic_vector(127 downto 0) := (others => 'Z');
				signal round_idx_enc_s	: integer := 0;
				signal fin_enc_s		: std_logic := 'Z';
	
	component encryption_round is
		port
		(
			clk 		: in std_logic;
			start_enc 	: in std_logic; -- Start encryption round
			rounds 		: in integer; -- Max. rounds. Specify 10, 12 or 14 in testbench
        	rkey_enc 	: in round_key_t;
			input_enc 	: in std_logic_vector(127 downto 0); -- state
			--rnd_cmpl_enc : out std_logic; -- Encryption round completed
			output_enc 	: out std_logic_vector(127 downto 0);
			round_idx 	: out integer;
			fin_enc 	: out std_logic -- Entire encryption completed, i.e. the ciphertext is ready
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
			key : in std_logic_vector(127 downto 0); -- Cipher key
			round_idx : out integer;
			rkey : out round_key_t;
			done_ks : out std_logic -- Finish key schedule
			
		);
	end component;

	begin

		encryption_round_instance : cryptography_round port map
		(
			-- Inputs
			clk			=> clk,
			start_enc	=> start_enc_s,
			rounds		=> rounds_s,
			rkey_enc	=> rkey_s,
			input_enc	=> message_s,
			
			-- Outputs
			output_enc	=>	ciph_txt_s,
			round_idx	=>	round_idx_enc_s,
			fin_enc	    =>  fin_enc_s
		);
		
		decryption_round_instance : cryptography_round port map
		(
			clk => clk
		);
		
		key_schedule_instance : key_schedule port map
		(
			clk => clk,
			rst_ks => rst_ks_s,
			key => key_in_s,
			round_idx => round_idx_ks_s,
			rkey => rkey_s,
			done_ks => done_ks_s
		);

	process(clk)
	begin

		if rising_edge(clk) then
		
			if read_key = '1' then
			
				rst_ks_s <= '1';
				key_in_s <= key_in;

			end if;
			
			if rst_ks_s = '1' then
			
				rst_ks_s <= '0';
				
			end if;
			
			if round_idx_ks_s = 0 then
			
				start_enc_s <= '1';
				
			end if;
			--if read_msg = '1' then
			--	
			--	message_s <= msg_in;
			--	msg_rcvd <= '1';
			--	
			--end if;
			
			if fin_enc_s = '1';
			
				text_out <= ciph_txt_s;
				
			end if;

			if done_ks_s = '1' then
				--if 
			end if;
			
			
		end if;

	end process;

end AES_arch;