library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity key_schedule_tb is
end key_schedule_tb;

architecture behavioral of key_schedule_tb is
	component key_schedule is
		port (
			clk : in std_logic;
			rst_ks : in std_logic; -- Reset key schedule
			rounds : in integer;
			key : in std_logic_vector(127 downto 0); -- Cipher key. Adjust size if 192/256
			round_key : out std_logic_vector(127 downto 0);
			done_ks : out std_logic -- Finish key schedule
		);
	end component;
	
	-- Inputs
	signal clk, rst_ks, done_ks : std_logic := '0';
	signal key, round_key : std_logic_vector(127 downto 0) := (others => '0');
	signal rounds_sig : integer := 10;

begin

	key <= x"3130395F74696D65733F4F795F566579"; -- x"0D A8 31 6E CC 28 47 3F D8 FA 0D EF 6A 
	

	-- Clock and reset
	clk <= not clk after 1 ns;
	rounds_sig <= 10;
	-- Instantiate DUT
	dut : key_schedule
		port map (
			clk => clk,
			rst_ks => rst_ks,
			key => key,
			round_key => round_key,
			done_ks => done_ks,
			rounds => rounds_sig
		);
	
	-- Generate stimulus
	stimulus : process 
	begin
		
		rst_ks <= '1';
		wait until done_ks = '1';
		wait;
	end process;
	
end architecture;