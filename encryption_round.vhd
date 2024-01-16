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
	
	-- Substitute bytes
	component sub_bytes is
		port 
        ( 
			clk : in std_logic;
			rst_rkg : in std_logic; -- Start round key generation
			round_index : in integer;
			rounds : in integer; -- Specify 10, 12 or 14 in testbench
	    	input_rkg : in std_logic_vector(127 downto 0);
			output_rkg : out std_logic_vector(127 downto 0);
			done_rkg : out std_logic -- Finish round key generation
		);
	end component;

    -- Shift rows
	component shift_rows is
		port 
        ( 
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

    	);

        shift_rows_instance : shift_rows port map
    	(

    	);

        mix_all_columns_instance : mix_all_columns port map
    	(

    	);

        encrypt : process(clk)
            begin
                if rising_edge(clk) then
                    if round_idx = 0 then
                        output_enc <= rkey_enc(round_idx) xor input_rnc;
                    elsif (round_idx /= 0) and (round_idx /= rounds) then
                        
                    elsif round_idx = rounds then
                        
                    end if;
                end if;
        end process encrypt;
end architecture;