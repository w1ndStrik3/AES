-- This program handles an encryption round.
-- Completion time:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity encryption_round is
    port (
		clk : in std_logic;
		rst_enc : in std_logic; -- Start key schedule
		rounds : in integer; -- Max. rounds. Specify 10, 12 or 14 in testbench
		round_idx : in integer;
		input_enc : in std_logic_vector(127 downto 0); -- Cipher key. Adjust size if 192/256
		output_enc : out round_key_t;
		done_enc : out std_logic -- Finish key schedule
    );
end encryption_round;

architecture behavioral of encryption_round is

	signal clk_s : std_logic := '0';
	signal step_count_s : integer := 0;
	
	-- Round key generation
	component sub_bytes is
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
	
	sub_bytes_instance : sub_bytes port map
	(
		clk => clk,
		rst_rkg => rst_rkg_s,
		round_index => round_idx,
		rounds => rounds,
		input_rkg => input_rkg_s,
		output_rkg => output_rkg_s,
		done_rkg => done_rkg_s
	);