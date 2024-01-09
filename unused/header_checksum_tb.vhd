--Aleksander Wind 2023
--***********************************************
-- *
-- IMPORTANT *
-- *
-- The program is designed to read headers as *
-- with the format as shown below: *
-- *
-- V4500E5FF09764000400621034ABF6B2B81E6F2AE *
-- I450037EC2C4B400040060C5F15F54423C7197492 *
-- *
-- This is an example of two headers as they *
-- are randomly generated. The important *
-- thing is that for debugging purposes, there *
-- is a letter at the begging of heach header. *
-- This letter is either "V" or "I" to indicate *
-- wheter the checksum is Valid or Invalid. *
-- this is is purely for debugging purposes. *
-- *
-- Aleksander Wind *
-- *
--***********************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity header_checksum_tb is
end entity header_checksum_tb;

architecture tb of header_checksum_tb is
	signal tb_clk : std_logic := '0';
	signal tb_reset : std_logic := '0';
	signal tb_start_of_data : std_logic := '0';
	signal tb_data_in : std_logic_vector(7 downto 0) := (others => '0');
	signal tb_cksum_calc : std_logic;
	signal tb_cksum_ok : std_logic;
	signal tb_cksum_ok_cnt : std_logic_vector(15 downto 0);
	signal tb_cksum_ko_cnt : std_logic_vector(15 downto 0);
	signal tb_test : std_logic := '1';

	signal tb_pass_int : integer := 0;
	signal tb_fail_int : integer := 0;
	constant clk_period : time := 10 ns;

	file tb_header_file : text;
	
	component header_checksum
	
		port
		(
			clk : in std_logic;
			reset : in std_logic;
			start_of_data : in std_logic;
			data_in : in std_logic_vector(7 downto 0);
			cksum_calc : out std_logic;
			cksum_ok : out std_logic;
			cksum_ok_cnt : out std_logic_vector(15 downto 0);
			cksum_ko_cnt : out std_logic_vector(15 downto 0)
		);
	
	end component;
		
	function hexToInt(hex : in string) return integer is
	
		variable res : integer := 0;
	
		begin
			for index in hex'range loop
		
				res := res * 16 + character'pos(hex(index)) - character'pos('0');
			
				if hex(index) >= 'A' and hex(index) <= 'F' then
			
					res := res - 7;
			
				elsif hex(index) >= 'a' and hex(index) <= 'f' then
			
					res := res - 39;
			
				end if;
		
			end loop;
		
			return res;
	
	end function hexToInt;
		begin
	
	
	
		header_checksum_instance: header_checksum port map
		(
			clk => tb_clk,
			reset => tb_reset,
			start_of_data => tb_start_of_data,
			data_in => tb_data_in,
			cksum_calc => tb_cksum_calc,
			cksum_ok => tb_cksum_ok,
			cksum_ok_cnt => tb_cksum_ok_cnt,
			cksum_ko_cnt => tb_cksum_ko_cnt
		);
	
		clk_process: process
		begin
	
			tb_clk <= '0';
			wait for clk_period/2;
			tb_clk <= '1';
			wait for clk_period/2;
	
		end process;
		
		test_process: process
		
			variable line_buffer : line;
			variable hex : string(1 to 2);
			--variable EOF : boolean := false; --EOF: End Of File
		begin
	
			tb_test <= '1';
			tb_reset <= '1';
			wait for clk_period*2;
			tb_reset <= '0';
			file_open(tb_header_file, "input_packet.txt", read_mode);
		
			while not endfile(tb_header_file) loop
		
				readline(tb_header_file, line_buffer);
			
				-- format of headers in the input_packet.txt:
				-- V45000073000040004011B861C0A80001C0A800C7
				-- note the V as the first character. This is
				-- intended for debugging. The V denotes that
				-- the header in question has a valid checksum
				-- a header with a bad checksum would have an I
				-- instead of the V.
				-- V = Valid checksum
				-- I = Invalid checksum
			
				for index in 1 to 22 loop
			
					if index < 21 then
						hex := line_buffer.all(index*2 to index*2+1);
						tb_data_in <= std_logic_vector(to_unsigned(hexToInt(hex),8));
					
						if index = 1 then
					
							tb_start_of_data <= '1';
					
						else
					
							tb_start_of_data <= '0';
					
						end if;
					end if;
					wait for clk_period;
					
					tb_pass_int <= to_integer(unsigned(tb_cksum_ok_cnt));
					tb_fail_int <= to_integer(unsigned(tb_cksum_ko_cnt));
			
				end loop;
		
			end loop;
			
			file_close(tb_header_file);
			
			wait for clk_period*2;
			
			tb_pass_int <= to_integer(unsigned(tb_cksum_ok_cnt));
			tb_fail_int <= to_integer(unsigned(tb_cksum_ko_cnt));
			tb_reset <= '1';
			
			wait;
	
		end process;
	
end architecture tb;