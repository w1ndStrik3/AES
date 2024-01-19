-- This program handles the encryption

-- Completion time: 40 CC
-- (cipher text will be written to output_enc on CC 40,
-- if the CC where start_enc = '1' is considered as CC 1)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity encryption_round is
	port
	(
		clk : in std_logic;
		start_enc : in std_logic; -- Start encryption round when first four words have been generated
		rkey_enc : in round_key_t;
		input_enc : in std_logic_vector(127 downto 0); -- state

		output_enc : out std_logic_vector(127 downto 0);
		round_idx : out integer;
		done_enc : out std_logic; -- Encryption round completed
		fin_enc : out std_logic -- Entire encryption completed, i.e. the ciphertext is ready
	);
end encryption_round;

architecture behavioral of encryption_round is

	signal step_count_s : integer := 0;

	signal state_io_s	: std_logic_vector(127 downto 0) := (others => '0');
	signal state_sb_s	: std_logic_vector(127 downto 0) := (others => 'Z');
	signal state_sr_s	: std_logic_vector(127 downto 0) := (others => 'Z');
	signal state_mc_s	: std_logic_vector(127 downto 0) := (others => 'Z');

	signal round_idx_s 	: integer := 0;
	signal done_enc_s	: std_logic := '0';
	signal fin_enc_s	: std_logic := '0';
	
	-- Substitute bytes
	component sub_bytes is
		port 
		(
			input_sb: in std_logic_vector(127 downto 0);
			output_sb : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;

	-- Shift rows
	component shift_rows is
		port 
		( 
			input_sr : in std_logic_vector(127 downto 0);
			output_sr : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;

	component mix_all_columns is
		port
		(
			input_mac : in std_logic_vector(127 downto 0);
			output_mac : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;

	begin
	
		sub_bytes_instance : sub_bytes port map
		(
			input_sb	 => state_io_s,
			output_sb	 => state_sb_s,
			clk			 => clk
		);

		shift_rows_instance : shift_rows port map
		(
			input_sr	 =>	state_sb_s,
			output_sr	 =>	state_sr_s,
			clk			 => clk
		);

		mix_all_columns_instance : mix_all_columns port map
		(
			input_mac	 => state_sr_s,
			output_mac	 => state_mc_s,
			clk			 => clk
		);

		process(clk)
			begin
				if rising_edge(clk) then
					
					if start_enc = '1' and fin_enc_s /= '1' then
						
						if round_idx_s = 0 then
							--CC 0: internal:
							--		reads from input_enc
							-- 		performs add round key
							--		writes to state_io_s
							state_io_s <= rkey_enc(round_idx_s) xor input_enc;
							
							done_enc_s <= '1';
							done_enc <= '1';
							
							round_idx_s <= 1;
							round_idx <= 1;

						else

							if done_enc_s = '1' then 
								-- CC 1: sub_bytes:
								--		reads from state_io_s
								--		writes to state_sb_s
								step_count_s <= 1;
								done_enc_s <= '0';
								done_enc <= '0';
							
							elsif round_idx_s = 10 and step_count_s = 2 then
								-- CC 3: internal - ON THE LAST ROUND ONLY
								--		reads from state_sr_s
								--		performs the add round key
								--		writes to output_enc
								output_enc <= rkey_enc(round_idx_s) xor state_sr_s;
								fin_enc_s <= '1';
								fin_enc <= '1';

							
							elsif step_count_s = 3 then
								-- CC 4: internal
								--		reads from state_ms_s
								--		performs the add round key
								--		writes to state_io_s
								state_io_s <= rkey_enc(round_idx_s) xor state_mc_s;
								round_idx_s <= round_idx_s + 1;
								round_idx <= round_idx_s + 1;

								done_enc_s <= '1';
								done_enc <= '1';
							
							else
								-- CC 2: shift_rows:
								--		reads from state_sb_s
								--		writes to state_sr_s

								-- CC 3: mix_all_columns:
								--		reads from state_sr_s
								--		writes to state_mc_s
								step_count_s <= step_count_s + 1;

							end if;
							
						end if;
						
					end if;

				end if;

		end process;

end architecture;