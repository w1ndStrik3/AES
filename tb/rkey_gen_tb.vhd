-- This program is a testbench for rkey_gen.

-- Completion time: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rkey_gen_tb is
end rkey_gen_tb;

architecture behavioral of rkey_gen_tb is 

	-- Declares unit under test (UUT)
	component rkey_gen
		port
		(
			clk : in std_logic;
			rst_rkg : in std_logic; -- Reset round key generation
			input_rkg : in std_logic_vector(127 downto 0);
			round_idx : in integer; -- Current round being handled
			output_rkg : out std_logic_vector(127 downto 0);
			done_rkg : out std_logic -- Finish round key generation
		);
	end component;
	
	-- Clock
	constant clk_period_s_tb : time := 2 ns;
	
	-- Testbench
	signal rounds_s_tb : integer := 10;
	signal start_round_s_tb : integer := 1;
	signal key_s_tb : std_logic_vector(127 downto 0) := x"2B7E151628AED2A6ABF7158809CF4F3C";
		
	type word_t is array(0 to 43) of std_logic_vector(31 downto 0);
	signal w_s_tb : word_t;
		
	type round_key_t is array(0 to 10) of std_logic_vector(127 downto 0);
	signal rkey_s_tb : round_key_t;
		
	-- Hexadecimal definition
	constant hex_arr : string(1 to 16) := "0123456789ABCDEF";
		
	-- Converts 32-bit vector to hexadecimal string
	function to_hex_string(signal input : std_logic_vector) return string is

		variable tmp : std_logic_vector(31 downto 0) := input; -- tmp instead of input, ensures same indexing for all key values
		variable result : string(8 downto 1) := (others => '0'); -- Empty array, to insert 8 hex values (total 32-bit)
		variable four_bits : std_logic_vector(3 downto 0); -- One hex value (first four bits in tmp)
		variable letter : integer := 0;

		begin
			for idx in 8 downto 1 loop
				four_bits := tmp(idx*4-1 downto (idx-1)*4);
				letter := to_integer(unsigned(four_bits)); -- Letter in hex_arr
				result(idx) := hex_arr(letter+1); -- Fill index in result
			end loop;	
			return result;
		end to_hex_string;
	
	-- Inputs
	signal clk_s_tb : std_logic := '1';
	signal rst_rkg_s_tb : std_logic := '0';
	signal round_idx_s_tb : integer := 1;
	signal input_rkg_s_tb : std_logic_vector(127 downto 0):= (others => '0');
	
	-- Outputs
	signal output_rkg_s_tb : std_logic_vector(127 downto 0):= (others => 'Z');
	signal done_rkg_s_tb : std_logic := 'Z';	

-- Begin architecture
begin

	clk_s_tb <= not clk_s_tb after (clk_period_s_tb / 2);

	-- Instantiates UUT
	uut : rkey_gen port map 
	(
		clk => clk_s_tb,
		rst_rkg => rst_rkg_s_tb,
		round_idx => round_idx_s_tb,
		input_rkg => input_rkg_s_tb,
		output_rkg => output_rkg_s_tb,
		done_rkg => done_rkg_s_tb
	);

-- Stimulus process
	stimulus : process
	begin
		
		-- Round 0 (w(0) to w(3))
		rst_rkg_s_tb <= '1';
		round_idx_s_tb <= 1;
		input_rkg_s_tb <= key_s_tb;
		rkey_s_tb(0) <= key_s_tb;
			
		w_s_tb(0) <= key_s_tb(127 downto 96);
		w_s_tb(1) <= key_s_tb(95 downto 64);
		w_s_tb(2) <= key_s_tb(63 downto 32);
		w_s_tb(3) <= key_s_tb(31 downto 0 );
			
		report "w_0 = " & to_hex_string(key_s_tb(127 downto 96));
		report "w_1 = " & to_hex_string(key_s_tb(95 downto 64));
		report "w_2 = " & to_hex_string(key_s_tb(63 downto 32));
		report "w_3 = " & to_hex_string(key_s_tb(31 downto 0));		
			
		wait for clk_period_s_tb;
		
		-- Round 1-10 (w(4) to w(43))
		
			for j in 1 to rounds_s_tb loop
				rst_rkg_s_tb <= '0';
				
				while done_rkg_s_tb /= '1' loop 
				
					wait for clk_period_s_tb;
					
				end loop;
				
				rst_rkg_s_tb <= '1';
				
				input_rkg_s_tb <= output_rkg_s_tb;
				rkey_s_tb(round_idx_s_tb) <= output_rkg_s_tb;
				
				round_idx_s_tb <= round_idx_s_tb + 1;
				
				w_s_tb(j*4) 	<= output_rkg_s_tb(127 downto 96);
				w_s_tb(j*4+1) 	<= output_rkg_s_tb(95 downto 64);
				w_s_tb(j*4+2) 	<= output_rkg_s_tb(63 downto 32);
				w_s_tb(j*4+3) 	<= output_rkg_s_tb(31 downto 0);
				
				report "w_" & integer'image(j*4)   & " = " & to_hex_string(output_rkg_s_tb(127 downto 96));
				report "w_" & integer'image(j*4+1) & " = " & to_hex_string(output_rkg_s_tb(95 downto 64));
				report "w_" & integer'image(j*4+2) & " = " & to_hex_string(output_rkg_s_tb(63 downto 32));
				report "w_" & integer'image(j*4+3) & " = " & to_hex_string(output_rkg_s_tb(31 downto 0));
				
				wait for clk_period_s_tb;
				
			end loop;
	
	wait;
	end process;

end;

