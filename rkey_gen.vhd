-- This program generates round keys for the key schedule.

-- completion time: 3 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rkey_gen is
	port ( 
		clk : in std_logic;
		rounds : integer; -- 
		start_rkg : in std_logic; -- Start round key generation
	    input_rkg : in std_logic_vector(31 downto 0);
		w_g : inout std_logic_vector(31 downto 0) -- Word after g-function
		--w_vector : inout std_logic_vector(127 downto 0);
		round_index : in integer;
		output_rkg : out std_logic_vector(31 downto 0);
		done_rkg : out std_logic; -- Finish round key generation
	);
end rkey_gen;

architecture behavioral of rkey_gen is
	
	signal step_count : integer := 0; -- Keeps track of current step
	signal rot_word : std_logic_vector(31 downto 0); 
	
	type word is array(0 to 3) of std_logic_vector(31 downto 0);
	signal w : word;
	
	-- Round constants
	type round_constant is array(1 to rounds) of std_logic_vector(31 downto 0); 
	constant rcon : round_constant := x"36" & -- Round 1
									  x"1b" &
									  x"80" &
									  x"40" &
									  x"20" &
									  x"10" &
									  x"08" &
								      x"04" &
									  x"02" &
									  x"01" &; -- Round 10
											
	-- 10 1-byte round constants, so 80-bit array
	signal RC : std_logic_vector(79 downto 0) := x"36" &
												 x"1b" &
												 x"80" &
												 x"40" &
												 x"20" &
												 x"10" &
												 x"08" &
												 x"04" &
												 x"02" &
												 x"01" &;											
	-- S-box
	component sbox is
		port ( 
			input_sb : in std_logic_vector(31 downto 0);
			output_sb : out std_logic_vector(31 downto 0) 
			);
	end component;

begin

	sbox_instance : sbox port map
	(
		input_sb => rot_word;
		output_sb => output_sb;
	);
	
	process(clk) 
	begin
		if rising_edge(clk) then
			-- Reset
			if start_rkg = '1' then
				done_rkg <= '0';
				-- Rotate word (shift each byte in word left by one)
				rot_word <= w_vector(23 downto 0) & w_vector(31 downto 24);
				step_count <= 1;
			elsif step_count = 1 then
				-- Add round constant
				w_g <= output_sb XOR (RC(round_index*8-1 downto round_index*8-8) & x"000000");
				step_count = 2;
			elsif step_count = 2 then
				-- 4 words always for round keys
				w(0) <= w(0) XOR w_g; -- w4
				w(1) <= w(1) XOR (w(0) XOR w_g); -- w5
				w(2) <= w(2) XOR (w(1) XOR (w(0) XOR w_g)); -- w6
				w(3) <= w(3) XOR (w(2) XOR (w(1) XOR (w(0) XOR w_g))); -- w7
				done_rkg <= '1';
			else
				-- step_count <= step_count + 1;
				done_rkg <= '0';
			end if;
		end if;
	end process;
	
end architecture;


-- Word array corresponds to:
-- w_vector(127 downto 96)	<= w_vector(127 downto 96) XOR w_g; -- w4
-- w_vector(95 downto 64)	<= w_vector(95 downto 64) XOR (w_vector(127 downto 96) XOR w_g); -- w5
-- w_vector(63 downto 32)	<= w_vector(63 downto 32) XOR (w_vector(95 downto 64) XOR (w_vector(127 downto 96) XOR w_g)); -- w6
-- w_vector(31 downto 0) 	<= w_vector(31 downto 0) XOR (w_vector(63 downto 32) XOR (w_vector(95 downto 64) XOR (w_vector(127 downto 96) XOR w_g))); -- w7