-- This program assigns round keys to all rounds.
-- 128-bit round key consists of four 32-bit words (4-byte words).

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity key_schedule is
    port (
		start_ks : in std_logic; -- Start key schedule
		clk : in std_logic;
		key : in std_logic_vector(127 downto 0); -- Initial key
		round_key : out std_logic_vector(127 downto 0);
        -- round_key : out std_logic_vector((128*(rounds+1))-1 downto 0); -- 10 round keys
		done_ks : out std_logic; -- Finish key schedule
    );
end key_schedule;

architecture behavioral of key_schedule is
	
	-- Signals
	signal step_count : integer := 0;
	signal rounds : integer; -- Max. rounds. Specify 10, 12 or 14 in testbench
	signal done : std_logic := '0'; -- Indicates finished key expansion
	
	signal output_sb : std_logic_vector(31 downto 0); -- S-box output
	
	signal done_rkg : std_logic;
	signal round_index : integer := 0; -- Current round being handled
	signal w_vector : std_logic_vector(127 downto 0);
	
	signal start_rkg : std_logic; -- Start round key generation
	
	-- Arrays
	-- Word array: 128-bit has 0-43 words, 192-bit has 0-51, 256-bit has 0-59.
	-- For 256-bit we need 8 4-byte words
	type word is array(0 to 7) of std_logic_vector(31 downto 0);
	signal w : word;
	
	-- All key words in 44-word array in 2D (if 10 rounds)
	type key_words is array(0 to (4*(rounds+1))-1) of std_logic_vector(31 downto 0); 
	signal words : key_words := (others => (others => '0')); -- Initialize all 0
	
	-- Current word being generated
	signal current_word : integer range 0 to key_words'length-1 := 0;
	
	-- Current round being handled
	signal round_index : integer := 0;
	
	-- Round key generation
	component rkey_gen is
		port ( 
			input_rkg : in std_logic_vector(31 downto 0);
			output_rkg : out std_logic_vector(31 downto 0)
			);
	end component;

begin

	rkey_gen_instance : rkey_gen port map
	(
		input_rkg => input_rkg;
		output_rkg => output_rkg;
		done_rkg => done_rkg
		round_index => round_index;
		w_vector => w_vector;
		round_index => round_index;
		start_rkg => start_rkg;
	);

	-- Key generation
	generate_keys : process(clk, rst) 
		variable temp_word : std_logic_vector(31 downto 0); -- Temporary word
		variable i : integer;
	begin
		i := current_word;
		if rising_edge(clk) then
			-- Reset and generate first words directly from cipher key
			-- 128-bit
			if start = '1' then -- AND rounds = 10
				current_word <= 0;
				w(0) <= key(127 downto 96);
				w(1) <= key(95 downto 64);
				w(2) <= key(63 downto 32);
				w(3) <= key(31 downto 0);
			-- 192-bit
			-- elsif start = '1' AND rounds = 12 then
			-- 256-bit
			-- elsif start = '1' AND rounds = 14 then
				round_index <= 2;
				step_count <= 1;
				start_rkg <= '1';
			
			elsif done_rkg = '1' then
				-- Generate subsequent keys, eg. w4 to w7
				for j in 0 to 3 loop
					w(round_index*4+j) <= w_vector(127-(j*32) downto 96-(j*32));
					-- w(round_index*4+j) <= w_vector(127-(j*32) downto 96-(j*32));
				end loop;
				
				start_rkg <= '1';
				step_count <= step_count + 1;
				round_index <= round_index + 1;
			else
				start_rkg <= '0';
			end if;
			
			-- Finish key generation
				if current_word = (4*(rounds+1)-1) then
					done_ks <= '1';
				end if;
			end if;
		end if;
	end process generate_keys;
	
	-- Output round keys handled in main
	for 

end behavioral;