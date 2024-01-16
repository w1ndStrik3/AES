-- This program handles an encryption round.

-- Completion time:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity encryption_round is
    port
    (
		clk : in std_logic;
		rst_enc : in std_logic; -- Start encryption round
		rounds : in integer; -- Max. rounds. Specify 10, 12 or 14 in testbench
		round_idx : in integer;
        rkey_enc : in round_key_t;
		input_enc : in std_logic_vector(127 downto 0); -- state
		output_enc : out std_logic_vector(127 downto 0);
		done_enc : out std_logic -- Finish encryption round
    );
end encryption_round;

architecture behavioral of encryption_round is

	signal step_count_s : integer := 0;
	signal input_length_s : integer := 15;

	signal state_sb_s : std_logic_vector(127 downto 0) := (others => 'Z');
	signal state_sr_s : std_logic_vector(127 downto 0) := (others => 'Z');
	signal state_mc_s : std_logic_vector(127 downto 0) := (others => 'Z');

	signal round_idx_tmp_s : integer := 99;
	signal step_count_s : integer;
	
	-- Substitute bytes
	component sub_bytes is
		port 
        ( 
			input_sb: in std_logic_vector(127 downto 0);
        	output_sb : out std_logic_vector(127 downto 0);
			clk : in std_logic;
			input_length : in integer
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
			input_mac : in STD_LOGIC_Vector(127 downto 0);
			output_mac : out STD_LOGIC_Vector(127 downto 0);
			clk : in std_logic
		);
	end component;

    begin
    
    	sub_bytes_instance : sub_bytes port map
    	(
			input_sb	 => input_enc;
        	output_sb	 => state_sb_s;
			clk			 => clk;
			input_length => input_length_s
    	);

        shift_rows_instance : shift_rows port map
    	(
			input_sr	 =>	state_sb_s;
			output_sr	 =>	state_sr_s;
			clk			 => clk;
    	);

        mix_all_columns_instance : mix_all_columns port map
    	(
			input_mac	 => state_sr_s;
        	output_mac	 => state_mc_s;
			clk			 => clk;
    	);

        process(clk)
            begin
                if rising_edge(clk) then
                    if round_idx = 0 then
                        output_enc <= rkey_enc(round_idx) xor input_rnc;
                    elsif round_idx /= 0 then
                        if round_idx_tmp_s /= round_idx then
							round_idx_tmp_s <= round_idx;
							step_count_s <= 1;
						else
							step_count_s <= step_count_s + 1;
						end if;

						if step_count_s = 4 then
							if round_idx /= rounds then
								output_enc <= rkey_enc(round_idx) xor state_mc_s;
							else
								output_enc <= rkey_enc(round_idx) xor state_sr_s;
							end if;
						end if;
					end if;
                end if;
        end process;
end architecture;