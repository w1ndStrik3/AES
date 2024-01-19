library ieee;
use ieee.std_logic_1164.all;
use work.round_key_arr_pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.numeric_std.all;

entity decryption_round_tb is
end decryption_round_tb;

architecture decryption_round_tb_arch of decryption_round_tb is 

	-- Component Declaration for the Unit Under Test (UUT)
	component decryption_round is
		port
		(
			clk : in std_logic;
			start_dec : in std_logic; -- Start encryption round when first four words have been generated
			rkey_dec : in round_key_t;
			input_dec : in std_logic_vector(127 downto 0); -- state

			round_idx : out integer;
			output_dec : out std_logic_vector(127 downto 0);
			done_dec : out std_logic; -- Encryption round completed
			fin_dec : out std_logic -- Entire encryption completed, i.e. the ciphertext is ready
		);
	end component;
	
	--Clock
	constant clk_period_s_tb : time := 2 ns;
	
	--Test bench		
		--type round_key_t is array(0 to 10) of std_logic_vector(127 downto 0);
		
		constant hex_arr : string(1 to 16) := "0123456789ABCDEF";
		
		function to_hex_string(signal input : std_logic_vector) return string is
		
			variable tmp : std_logic_vector(127 downto 0) := input;
			variable result : string(32 downto 1) := (others => '0');
			variable four_bits : std_logic_vector(3 downto 0);
			variable letter : integer := 0;
			
			begin
			
			for idx in 32 downto 1 loop
			
				four_bits := tmp(idx*4-1 downto (idx-1)*4);
				letter := to_integer(unsigned(four_bits));
				result(idx) := hex_arr(letter+1);
				
			end loop;	
			
			return result;
			
		end to_hex_string;
		
		signal clk_s_tb 			: std_logic := '1';
		signal ciph_text_s_tb		: std_logic_vector(127 downto 0) := (others => '0'); -- Message to be decrypted
		signal ciph_rc_s_tb			: std_logic := '0'; -- Ciphertext received
		signal rkey_dec_s_tb		: round_key_t := (
														-- Reversed all round keys from encryption_round
														x"D014F9A8C9EE2589E13F0CC8B6630CA6",
														x"AC7766F319FADC2128D12941575C006E",
														x"EAD27321B58DBAD2312BF5607F8D292F",
														x"4E54F70E5F5FC9F384A64FB24EA6DC4F",
														x"6D88A37A110B3EFDDBF98641CA0093FD",
														x"D4D1C6F87C839D87CAF2B8BC11F915BC",
														x"EF44A541A8525B7FB671253BDB0BAD00",
														x"3D80477D4716FE3E1E237E446D7A883B",
														x"F2C295F27A96B9435935807A7359F67F",
														x"A0FAFE1788542CB123A339392A6C7605",
														x"2B7E151628AED2A6ABF7158809CF4F3C"
													);

	--Read
		signal message_s_tb			: std_logic_vector(127 downto 0) := (others => 'Z'); -- Plaintext output
		signal round_idx_s_tb		: integer := 0;
		signal done_dec_s_tb		: std_logic := 'Z';
		signal fin_dec_s_tb			: std_logic := 'Z';

	begin

	clk_s_tb <= not clk_s_tb after (clk_period_s_tb / 2);

	-- Instantiate the Unit Under Test (UUT)
	uut : decryption_round
		port map(
			-- Inputs
			clk			=> clk_s_tb,
			start_dec	=> ciph_rc_s_tb,
			rkey_dec	=> rkey_dec_s_tb,
			input_dec	=> ciph_text_s_tb,

			-- Outputs
			output_dec	=>	message_s_tb,
			round_idx	=>	round_idx_s_tb,
			done_dec	=>	done_dec_s_tb,
			fin_dec		=>  fin_dec_s_tb
		);

-- Stimulus process
	stim_proc : process
	begin
			
			wait for clk_period_s_tb;
			
			ciph_rc_s_tb <= '1';
			ciph_text_s_tb <= x"3925841d02dc09fbdc118597196a0b32"; -- Ciphertext given by NIST
			
			wait for clk_period_s_tb;
		
			while fin_dec_s_tb /= '1' loop
				
				wait for clk_period_s_tb;
				
			end loop;
			
			if fin_dec_s_tb = '1' then
				
				report "Plaintext: " & to_hex_string(message_s_tb); -- Desired plaintext is 3243f6a8885a308d313198a2e0370734
				
			end if;
		
		wait;

	end process;

end architecture;
