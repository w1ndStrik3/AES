-- This program schedules round keys for all rounds. Keys are handed over in main.

-- Completion time: 5 cycles.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity key_schedule is
    port (
		clk : in std_logic;
		rst_ks : in std_logic; -- Start key schedule
		key : in std_logic_vector(127 downto 0); -- Cipher key
		round_idx : out integer;
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
	signal output_rkg_s : std_logic_vector(127 downto 0):= (others => 'Z'); -- Round key generated
	signal done_rkg_s : std_logic := 'Z'; -- Finish round key generation
	signal current_word_s : integer := 3; -- Current word being generated
	signal round_idx_s : integer := 1;
	
	-- Array holds all four words for current round key being generated
	type words_t is array(0 to 3) of std_logic_vector(31 downto 0);
	signal w_s : words_t;
	
	-- All round keys generated
	signal rkey_s : round_key_t; -- Type defined in package round_key_arr_pkg
	
	-- Round key generation
	component rkey_gen is
		port ( 
			clk : in std_logic;
			rst_rkg : in std_logic; -- Start round key generation
			round_idx : in integer;
	    	input_rkg : in std_logic_vector(127 downto 0);
			output_rkg : out std_logic_vector(127 downto 0);
			done_rkg : out std_logic -- Finish round key generation
		);
	end component;

begin
	
	rkey_gen_instance : rkey_gen port map
	(
		clk => clk,
		rst_rkg => rst_rkg_s,
		round_idx => round_idx_s,
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
				w_s(0) <= key(127 downto 96); -- Column 1 of cipher key
				w_s(1) <= key(95 downto 64); -- Column 2 
				w_s(2) <= key(63 downto 32); -- Column 3 
				w_s(3) <= key(31 downto 0); -- Column 4 
				
				-- First round key
				rkey(0) 	<= 	key(127 downto 96) 	& 
								key(95 downto 64)	&
								key(63 downto 32)	&
								key(31 downto 0);
				
				input_rkg_s <= key(127 downto 0); -- Passes first round key (cipher key) to rkey_gen
				rst_rkg_s <= '1';
				done_ks <= '0';
				round_idx <= 0;
			
			-- Generate subsequent key, eg. w(4), w(5), w(6), w(7)	
			elsif done_rkg_s = '1' then

				rkey(round_idx_s) <= output_rkg_s; 
				round_idx <= round_idx_s;
				
				-- If not generating the last round key
				if current_word_s < 39 then
					
					rst_rkg_s <= '1';
					current_word_s <= current_word_s + 4;
					input_rkg_s <= output_rkg_s;
					round_idx_s <= round_idx_s + 1;
				
				-- If generating the last ro
				else
					done_ks <= '1';

				end if;

			else

				rst_rkg_s <= '0';
				
			end if;
		end if;
	end process generate_keys;
end architecture;