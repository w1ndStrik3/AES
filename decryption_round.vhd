-- This program handles the decryption

-- Completion time:



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity decryption_round is
	port
	(
		clk : in std_logic;
		start_dec : in std_logic; -- Start decryption round when last four words have been generated
		rkey_dec : in round_key_t;
		input_dec : in std_logic_vector(127 downto 0); -- state
		
		output_dec : out std_logic_vector(127 downto 0);
		round_idx : out integer;
		done_dec : out std_logic; -- Decryption round completed
		fin_dec : out std_logic -- Entire decryption completed, i.e. the plaintext is ready
	);
end decryption_round;

architecture behavioral of decryption_round is
	
	signal step_count_s : integer := 0;
	
	signal state_io_s	: std_logic_vector(127 downto 0) := (others => '0');
	signal state_sb_s	: std_logic_vector(127 downto 0) := (others => 'Z');
	signal state_sr_s	: std_logic_vector(127 downto 0) := (others => 'Z');
	signal state_mc_s	: std_logic_vector(127 downto 0) := (others => 'Z');
	
	signal use_init_s	: std_logic := '1';
	
	signal round_idx_s	: integer := 0;
	signal done_dec_s	: std_logic := '0';
	signal fin_dec_s	: std_logic := '0';
	
	signal state_in_mc_s	 : std_logic_vector(127 downto 0) := (others => 'Z'); --input used for inverse mix column
		
	-- Inverse shift rows
	component inv_shift_rows is
		port
		(
			input_inv_sr : in std_logic_vector(127 downto 0);
			input_inv_sr_init : in std_logic_vector(127 downto 0);
			use_init : in std_logic;
		
			output_inv_sr : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;
	
	-- Inverse substitute bytes
	component inv_sub_bytes is
		port
		(
			input_inv_sb: in std_logic_vector(127 downto 0);
			output_inv_sb : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;
	
	component inv_mix_all_columns is
		port
		(
			input_inv_mac : in std_logic_vector(127 downto 0);
			output_inv_mac : out std_logic_vector(127 downto 0);
			clk : in std_logic
		);
	end component;
	
	begin
	
		inv_shift_rows_instance : inv_shift_rows port map
		(
			input_inv_sr		=> state_mc_s,
			input_inv_sr_init	=> state_io_s,
			use_init 			=> use_init_s,
			
			output_inv_sr		=> state_sr_s,
			clk					=> clk
		);
		
		inv_sub_bytes_instance : inv_sub_bytes port map
		(
			input_inv_sb	=> state_sr_s,
			output_inv_sb	=> state_sb_s,
			clk				=> clk
		);
	
		inv_mix_all_columns_instance : inv_mix_all_columns port map
		(
			input_inv_mac	=> state_in_mc_s,
			output_inv_mac	=> state_mc_s,
			clk				=> clk
		);

		process(clk)
			begin
				if rising_edge(clk) then
					
					if start_dec = '1' and fin_dec_s /= '1' then
						
						if round_idx_s = 0 then

							state_io_s <= rkey_dec(10 - round_idx_s) xor input_dec;
							
							done_dec_s <= '1';
							done_dec <= '1';
							
							round_idx_s <= 1;
							round_idx <= 1;

						else
							
							use_init_s <= '0';
							
							if done_dec_s = '1' then 
								-- CC 1: inv_shift_rows:
								--		IF "use_init_s" is LOW
								--			reads from state_io_s
								--		ELSE
								--			reads from state_ms_s
								--		END IF
								--		writes to state_sr_s
								step_count_s <= 1;
								done_dec_s <= '0';
								done_dec <= '0';
							
							elsif round_idx_s = 10 and step_count_s = 2 then
								-- CC 3: internal - ON THE LAST ROUND ONLY
								--		reads from state_sb_s
								--		performs the add round key
								--		writes to output_dec
								output_dec <= rkey_dec(10 - round_idx_s) xor state_sb_s;
								fin_dec_s <= '1';
								fin_dec <= '1';

							
							elsif step_count_s = 3 then
								-- CC 4: inv_mix_all_columns:
								--		reads from state_in_mc_s
								--		performs the add round key
								--		writes to state_ms_s
								
								--state_io_s <= state_mc_s;
								--state_in_mc_s <= rkey_dec(round_idx_s) xor state_sb_s;
								round_idx_s <= round_idx_s + 1;
								round_idx <= round_idx_s + 1;

								done_dec_s <= '1';
								done_dec <= '1';
							
							else
								-- CC 2: inv_sub_bytes:
								--		reads from state_sr_s
								--		writes to state_sb_s
								
								step_count_s <= step_count_s + 1;
								
								-- CC 3: internal:
								--		reads from state_sb_s
								--		performs the add round key operation
								--		writes to state_in_mc_s
								
								if step_count_s = 2 then
								
									state_in_mc_s <= rkey_dec(10 - round_idx_s) xor state_sb_s;
									
								end if;
								
							end if;
							
						end if;
						
					end if;

				end if;

		end process;

end architecture;