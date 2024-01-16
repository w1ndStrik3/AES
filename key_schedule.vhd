-- This program assigns round keys to all rounds. Keys are handed over in main.
-- Completion time:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity key_schedule is
    port (
		clk : in std_logic;
		rst_ks : in std_logic; -- Start key schedule
		rounds : in integer; -- Max. rounds. Specify 10, 12 or 14 in testbench
		round_idx : in integer;
		key : in std_logic_vector(127 downto 0); -- Cipher key. Adjust size if 192/256
		rkey : out round_key_t;
		done_ks : out std_logic -- Finish key schedule
    );
end key_schedule;

architecture behavioral of key_schedule is

	signal clk_s : std_logic := '0';
	signal step_count_s : integer := 0;
	signal output_sb_s : std_logic_vector(31 downto 0); -- S-box output
	signal rst_rkg_s : std_logic := '0'; -- Reset round key generation
	signal input_rkg_s : std_logic_vector(127 downto 0);
	signal output_rkg_s : std_logic_vector(127 downto 0); -- Round key generated
	signal done_rkg_s : std_logic := 'Z'; -- Finish round key generation
	signal current_word_s : integer := 0; -- Current word being generated
	--signal round_index_s : integer := 0; -- Current round being handled
	
	-- One word
	type word_t is array(0 to 3) of std_logic_vector(31 downto 0);
	signal w_s : word_t;
	
	-- All words generated
	-- type words_all_t is array(0 to (4*rounds+3)) of std_logic_vector(31 downto 0); 
	-- signal words_s : words_all_t; -- := (others => (others => '0')); -- Initialize all 0
	
	-- All round keys generated
	signal rkey_s : round_key_t;
	
	-- Round key generation
	component rkey_gen is
		port ( 
			clk : in std_logic;
			rst_rkg : in std_logic; -- Start round key generation
			round_index : in integer;
			rounds : in integer; -- Specify 10, 12 or 14 in testbench
	    		input_rkg : in std_logic_vector(127 downto 0);
			output_rkg : out std_logic_vector(127 downto 0);
			done_rkg : out std_logic -- Finish round key generation
			);
	end component;

begin

	--k <= ( key(127 downto 96), key(95 downto 64), key(63 downto 32), key(31 downto 0) );
	
	rkey_gen_instance : rkey_gen port map
	(
		clk => clk,
		rst_rkg => rst_rkg_s,
		round_index => round_idx,
		rounds => rounds,
		input_rkg => input_rkg_s,
		output_rkg => output_rkg_s,
		done_rkg => done_rkg_s
	);

	-- Key generation
	generate_keys : process(clk) 
	begin
		if rising_edge(clk) then
			-- Reset and generate first words directly from cipher key
			if rst_ks = '1' then 
				w_s(0) <= key(127 downto 96); -- Column 1 of initial key
				w_s(1) <= key(95 downto 64); -- Column 2 
				w_s(2) <= key(63 downto 32); -- Column 3 
				w_s(3) <= key(31 downto 0); -- Column 4 
				
				-- First round key
				rkey_s(0) 	<= 	key(127 downto 96) 	& 
								key(95 downto 64)	&
								key(63 downto 32)	&
								key(31 downto 0);
				
				--round_index_s <= 1;
				step_count_s <= 1;
				rst_rkg_s <= '1';
				current_word_s <= 3;
				
			elsif done_rkg_s = '1' then
			-- Generate subsequent keys, eg. [w(4), w(5), w(6), w(7)]

				rkey_s(round_idx) <= output_rkg_s; 
				
				rst_rkg_s <= '1';
				step_count_s <= step_count_s + 1;
				--round_index_s <= round_index_s + 1;
				current_word_s <= current_word_s + 4;
			
			else
			
				rst_rkg_s <= '0';
				
			end if;
			
			-- Finish key generation
			if current_word_s = (4*rounds-1) then
				done_ks <= '1';				
			end if;
		end if;
	end process generate_keys;
	
end architecture;