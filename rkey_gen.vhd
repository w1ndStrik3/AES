-- This program generates round keys for the key schedule.

-- Completion time: 3 cycles.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rkey_gen is
	port ( 
		clk : in std_logic;
		rst_rkg : in std_logic; -- Reset round key generation
		input_rkg : in std_logic_vector(127 downto 0);
		round_idx : in integer; -- Current round being handled
		output_rkg : out std_logic_vector(127 downto 0);
		done_rkg : out std_logic -- Finish round key generation
	);
end rkey_gen;

architecture behavioral of rkey_gen is
	
	-- Signals
	signal step_count_s : integer := 0; -- Keeps track of current step
	signal rot_word_s : std_logic_vector(127 downto 0); -- Left-rotates bytes in word by one
	signal padding_s : std_logic_vector(127 downto 32) := (others => '0'); -- Pads rot_word_s
	signal output_sb_s : std_logic_vector(127 downto 0);
	
	-- Array holds four words for each round key
	type word_t is array(0 to 3) of std_logic_vector(31 downto 0);
	signal w_s : word_t;
	
	-- Round constants
	type round_constant_t is array(1 to 10) of std_logic_vector(7 downto 0); 
	constant rcon : round_constant_t := (	
											x"01", -- Round 1
											x"02", -- Round 2
											x"04", -- Round 3
											x"08", -- Round 4
											x"10", -- Round 5
											x"20", -- Round 6
											x"40", -- Round 7
											x"80", -- Round 8
											x"1b", -- Round 9
											x"36" -- Round 10
										); 
	-- S-box
	component sub_bytes is
		port 
		(
			input_sb : in std_logic_vector(127 downto 0);
			output_sb : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;

begin
	
	sbox_instance : sub_bytes port map
	(
		input_sb => rot_word_s,
		output_sb => output_sb_s,
		clk => clk
	);
	
	process(clk) 
	variable w_g_v : std_logic_vector(31 downto 0); -- Word after g-function
	begin
		if rising_edge(clk) then
		
			-- Reset to generate new round key (4 words)
			if rst_rkg = '1' then
			
				w_s <= -- Fill 4-word array 
				(
					input_rkg(127 downto 96), -- w(4) etc.
					input_rkg(95 downto 64), -- w(5) etc.
					input_rkg(63 downto 32), -- w(6) etc.
					input_rkg(31 downto 0) -- w(7) etc.
				);
				done_rkg <= '0';
				
				-- Rotate left so [b0, b1, b2, b3] becomes [b1, b2, b3, b0]
				-- Substitute all bytes in word. Assigns input rot_word_s to S-box
				rot_word_s <= padding_s & 
							  input_rkg(23 downto 16) & -- Byte 1
							  input_rkg(15 downto 8) & -- Byte 2
  							  input_rkg(7 downto 0) &  -- Byte 3
							  input_rkg(31 downto 24); -- Byte 0
				step_count_s <= 1;
			
			-- Runs S-box
			elsif step_count_s = 1 then
				
				step_count_s <= 2;
				done_rkg <= '0';
				
			elsif step_count_s = 2 then
				-- Add round constant to each byte???
				w_g_v := output_sb_s(31 downto 0) XOR (rcon(round_idx) & x"000000"); -- 128 bits
				
				output_rkg <= 
				(
					(w_s(0) XOR w_g_v) & -- w4
					(w_s(1) XOR (w_s(0) XOR w_g_v)) & -- w5
					(w_s(2) XOR (w_s(1) XOR (w_s(0) XOR w_g_v))) & -- w6
					(w_s(3) XOR (w_s(2) XOR (w_s(1) XOR (w_s(0) XOR w_g_v)))) -- w7
				);
				done_rkg <= '1';
				
				step_count_s <= 3;
				
			else
			
				done_rkg <= '0';
				
			end if;
		end if;
	end process;
	
end architecture;