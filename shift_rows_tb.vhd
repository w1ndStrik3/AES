library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_rows_tb is
end shift_rows_tb;

architecture behavioral of shift_rows_tb is
	component shift_rows is
		port (
			clk : in std_logic;
			input_byte : in std_logic_vector(127 downto 0);
			output_byte : out std_logic_vector(127 downto 0)
		);
	end component;
	
	-- Inputs
	signal clk : std_logic := '0';
	signal input_byte : std_logic_vector(127 downto 0) := (others => '0');
	signal output_byte : std_logic_vector(127 downto 0):= (others => '0');
	signal reset : std_logic := '1';

begin
	-- Clock and reset
	clk <= not clk after 1 ns;
	--reset <= '1', '0' after 5 ns; 
	--reset <= not reset after 5 ns;
	--wait for 4 ns;
	--reset <= '0';
	--input_byte <= (others => '0');
	--output_byte <= (others => '0');

	-- Instantiate DUT
	dut : shift_rows
		port map (
			clk => clk,
			input_byte => input_byte,
			output_byte => output_byte
		);
	
	-- Generate stimulus
	stimulus : process begin
		--wait until (reset = '0');
		input_byte <= input_byte(127 downto 8) & "00000000";
		wait for 2 ns;
		input_byte <= input_byte(127 downto 8) & "00000001";
		wait for 2 ns;
		input_byte <= input_byte(127 downto 8) & "00000010";
		wait;
	end process;
	
end behavioral;