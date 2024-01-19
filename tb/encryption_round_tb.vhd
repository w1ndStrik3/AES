library ieee;
use ieee.std_logic_1164.all;
use work.round_key_arr_pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.numeric_std.all;

entity encryption_round_tb is
end encryption_round_tb;

architecture encryption_round_tb_arch of encryption_round_tb is 

	-- Component Declaration for the Unit Under Test (UUT)
	component encryption_round is
		port
		(
			clk : in std_logic;
			start_enc : in std_logic; -- Start encryption round when first four words have been generated
			rkey_enc : in round_key_t;
			input_enc : in std_logic_vector(127 downto 0); -- state

			round_idx : out integer;
			output_enc : out std_logic_vector(127 downto 0);
			done_enc : out std_logic; -- Encryption round completed
			fin_enc : out std_logic -- Entire encryption completed, i.e. the ciphertext is ready
		);
	end component;
	
	component decryption_round is
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
	
	--Write
		-- Global
			signal clk_s_tb 			: std_logic := '1';
			signal message_s_tb			: std_logic_vector(127 downto 0) := (others => '0'); --message to be encrypted
			signal msg_rc_s_tb			: std_logic := '0';
			signal rkey_glob_s_tb 		: round_key_t :=(
														x"2B7E151628AED2A6ABF7158809CF4F3C",
														x"A0FAFE1788542CB123A339392A6C7605",
														x"F2C295F27A96B9435935807A7359F67F",
														x"3D80477D4716FE3E1E237E446D7A883B",
														x"EF44A541A8525B7FB671253BDB0BAD00",
														x"D4D1C6F87C839D87CAF2B8BC11F915BC",
														x"6D88A37A110B3EFDDBF98641CA0093FD",
														x"4E54F70E5F5FC9F384A64FB24EA6DC4F",
														x"EAD27321B58DBAD2312BF5607F8D292F",
														x"AC7766F319FADC2128D12941575C006E",
														x"D014F9A8C9EE2589E13F0CC8B6630CA6"
													);--(others => (others => '0'));
		
	--Read
		-- Encryption
			signal c_txt_s_tb			: std_logic_vector(127 downto 0) := (others => 'Z'); -- ciphertext output
			signal round_idx_enc_s_tb	: integer := 0;
			
			signal done_enc_s_tb		: std_logic := 'Z';
			signal fin_enc_s_tb			: std_logic := 'Z';
			
		-- Decryption
			signal p_txt_s_tb			: std_logic_vector(127 downto 0) := (others => 'Z'); -- plaintext output
			signal round_idx_dec_s_tb	: integer := 0;
			
			signal done_dec_s_tb		: std_logic := 'Z';
			signal fin_dec_s_tb			: std_logic := 'Z';
			--signal test_in_dec			: std_logic_vector(127 downto 0) := x"3925841D02DC09FBDC118597196A0B32";
	begin

	clk_s_tb <= not clk_s_tb after (clk_period_s_tb / 2);

	-- Instantiate the Unit Under Test (UUT)
	uut_enc : encryption_round
		port map(
			-- Inputs
			clk			=> clk_s_tb,
			start_enc	=> msg_rc_s_tb,
			rkey_enc	=> rkey_glob_s_tb,
			input_enc	=> message_s_tb,

			-- Outputs
			output_enc	=>	c_txt_s_tb,
			round_idx	=>	round_idx_enc_s_tb,
			done_enc 	=>	done_enc_s_tb,
			fin_enc		=>  fin_enc_s_tb
		);
		
	uut_dec : decryption_round
		port map(
			-- Inputs
			clk			=> clk_s_tb,
			start_dec	=> fin_enc_s_tb,
			rkey_dec	=> rkey_glob_s_tb,
			input_dec	=> c_txt_s_tb,

			-- Outputs
			output_dec	=>	p_txt_s_tb,
			round_idx	=>	round_idx_dec_s_tb,
			done_dec 	=>	done_dec_s_tb,
			fin_dec		=>  fin_dec_s_tb
		);
-- Stimulus process
	stim_proc : process
	begin
			
			wait for clk_period_s_tb;
			
			msg_rc_s_tb <= '1';
			message_s_tb <= x"3243f6a8885a308d313198a2e0370734";
							
			wait for clk_period_s_tb;
		
			while fin_enc_s_tb /= '1' loop
				
				wait for clk_period_s_tb;
				
			end loop;
			
			if fin_enc_s_tb = '1' then
				
				report "ciphertext: " & to_hex_string(c_txt_s_tb);
				
			end if;
			
			while fin_dec_s_tb /= '1' loop
			
				wait for clk_period_s_tb;
				
			end loop;
			
			if fin_enc_s_tb = '1' then
				
				report "init plaintext: " & to_hex_string(message_s_tb);
				report "decr plaintext: " & to_hex_string(p_txt_s_tb);
				
			end if;
	wait;
	end process;

end architecture;