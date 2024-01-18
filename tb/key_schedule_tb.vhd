-- This program is a testbench for key_schedule.

-- Completion time: 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.round_key_arr_pkg.all;

entity key_schedule_tb is
end key_schedule_tb;

architecture behavioral of key_schedule_tb is

	component key_schedule is
		port (
			clk : in std_logic;
			rst_ks : in std_logic; -- Start key schedule
			key : in std_logic_vector(127 downto 0); -- Cipher key
			round_idx : out integer;
			rkey : out round_key_t;
			done_ks : out std_logic -- Finish key schedule
		);
	end component;
	
	-- Inputs
	signal clk_s_tb, rst_ks_s_tb, done_ks_s_tb : std_logic := '0';
	signal round_idx_s_tb : integer := 0;
	signal rkey_s_tb : round_key_t;
	signal key_s_tb : std_logic_vector(127 downto 0) := x"2B7E151628AED2A6ABF7158809CF4F3C"; -- Cipher key from NIST
	
	constant clk_period_s_tb : time := 2 ns;
	
begin
	
	-- Clock and reset
	clk_s_tb <= not clk_s_tb after clk_period_s_tb;

	-- Instantiate DUT
	dut : key_schedule
		port map (
			clk => clk_s_tb,
			rst_ks => rst_ks_s_tb,
			key => key_s_tb,
			rkey => rkey_s_tb,
			done_ks => done_ks_s_tb,
			round_idx => round_idx_s_tb
		);
	
	-- Generate stimulus
	stimulus : process 
	begin
		
		rst_ks_s_tb <= '1';
		wait for clk_period_s_tb;
		rst_ks_s_tb <= '0';
		wait until done_ks_s_tb = '1';
		wait;

	end process;

end architecture;