-- This program substitutes each byte with the Rijndael S-box.

-- Completion time: 1 cycle.

library ieee;
use ieee.std_logic_1164.all;

entity sub_bytes is
    port
	(
		input_sb: in std_logic_vector(127 downto 0);
        output_sb : out std_logic_vector(127 downto 0);
		clk : in std_logic
	);
end entity sub_bytes;

architecture behavioral of sub_bytes is

begin
process(clk)
	begin
	if rising_edge(clk) then
	
		for i in 0 to 15 loop
		
			   if input_sb(i*8+7 downto i*8) = x"00" then output_sb(i*8+7 downto i*8) <= x"63";
			elsif input_sb(i*8+7 downto i*8) = x"01" then output_sb(i*8+7 downto i*8) <= x"7c";
			elsif input_sb(i*8+7 downto i*8) = x"02" then output_sb(i*8+7 downto i*8) <= x"77";
			elsif input_sb(i*8+7 downto i*8) = x"03" then output_sb(i*8+7 downto i*8) <= x"7b";
			elsif input_sb(i*8+7 downto i*8) = x"04" then output_sb(i*8+7 downto i*8) <= x"f2";
			elsif input_sb(i*8+7 downto i*8) = x"05" then output_sb(i*8+7 downto i*8) <= x"6b";
			elsif input_sb(i*8+7 downto i*8) = x"06" then output_sb(i*8+7 downto i*8) <= x"6f";
			elsif input_sb(i*8+7 downto i*8) = x"07" then output_sb(i*8+7 downto i*8) <= x"c5";
			elsif input_sb(i*8+7 downto i*8) = x"08" then output_sb(i*8+7 downto i*8) <= x"30";
			elsif input_sb(i*8+7 downto i*8) = x"09" then output_sb(i*8+7 downto i*8) <= x"01";
			elsif input_sb(i*8+7 downto i*8) = x"0a" then output_sb(i*8+7 downto i*8) <= x"67";
			elsif input_sb(i*8+7 downto i*8) = x"0b" then output_sb(i*8+7 downto i*8) <= x"2b";
			elsif input_sb(i*8+7 downto i*8) = x"0c" then output_sb(i*8+7 downto i*8) <= x"fe";
			elsif input_sb(i*8+7 downto i*8) = x"0d" then output_sb(i*8+7 downto i*8) <= x"d7";
			elsif input_sb(i*8+7 downto i*8) = x"0e" then output_sb(i*8+7 downto i*8) <= x"ab";
			elsif input_sb(i*8+7 downto i*8) = x"0f" then output_sb(i*8+7 downto i*8) <= x"76";
			elsif input_sb(i*8+7 downto i*8) = x"10" then output_sb(i*8+7 downto i*8) <= x"ca";
			elsif input_sb(i*8+7 downto i*8) = x"11" then output_sb(i*8+7 downto i*8) <= x"82";
			elsif input_sb(i*8+7 downto i*8) = x"12" then output_sb(i*8+7 downto i*8) <= x"c9";
			elsif input_sb(i*8+7 downto i*8) = x"13" then output_sb(i*8+7 downto i*8) <= x"7d";
			elsif input_sb(i*8+7 downto i*8) = x"14" then output_sb(i*8+7 downto i*8) <= x"fa";
			elsif input_sb(i*8+7 downto i*8) = x"15" then output_sb(i*8+7 downto i*8) <= x"59";
			elsif input_sb(i*8+7 downto i*8) = x"16" then output_sb(i*8+7 downto i*8) <= x"47";
			elsif input_sb(i*8+7 downto i*8) = x"17" then output_sb(i*8+7 downto i*8) <= x"f0";
			elsif input_sb(i*8+7 downto i*8) = x"18" then output_sb(i*8+7 downto i*8) <= x"ad";
			elsif input_sb(i*8+7 downto i*8) = x"19" then output_sb(i*8+7 downto i*8) <= x"d4";
			elsif input_sb(i*8+7 downto i*8) = x"1a" then output_sb(i*8+7 downto i*8) <= x"a2";
			elsif input_sb(i*8+7 downto i*8) = x"1b" then output_sb(i*8+7 downto i*8) <= x"af";
			elsif input_sb(i*8+7 downto i*8) = x"1c" then output_sb(i*8+7 downto i*8) <= x"9c";
			elsif input_sb(i*8+7 downto i*8) = x"1d" then output_sb(i*8+7 downto i*8) <= x"a4";
			elsif input_sb(i*8+7 downto i*8) = x"1e" then output_sb(i*8+7 downto i*8) <= x"72";
			elsif input_sb(i*8+7 downto i*8) = x"1f" then output_sb(i*8+7 downto i*8) <= x"c0";
			elsif input_sb(i*8+7 downto i*8) = x"20" then output_sb(i*8+7 downto i*8) <= x"b7";
			elsif input_sb(i*8+7 downto i*8) = x"21" then output_sb(i*8+7 downto i*8) <= x"fd";
			elsif input_sb(i*8+7 downto i*8) = x"22" then output_sb(i*8+7 downto i*8) <= x"93";
			elsif input_sb(i*8+7 downto i*8) = x"23" then output_sb(i*8+7 downto i*8) <= x"26";
			elsif input_sb(i*8+7 downto i*8) = x"24" then output_sb(i*8+7 downto i*8) <= x"36";
			elsif input_sb(i*8+7 downto i*8) = x"25" then output_sb(i*8+7 downto i*8) <= x"3f";
			elsif input_sb(i*8+7 downto i*8) = x"26" then output_sb(i*8+7 downto i*8) <= x"f7";
			elsif input_sb(i*8+7 downto i*8) = x"27" then output_sb(i*8+7 downto i*8) <= x"cc";
			elsif input_sb(i*8+7 downto i*8) = x"28" then output_sb(i*8+7 downto i*8) <= x"34";
			elsif input_sb(i*8+7 downto i*8) = x"29" then output_sb(i*8+7 downto i*8) <= x"a5";
			elsif input_sb(i*8+7 downto i*8) = x"2a" then output_sb(i*8+7 downto i*8) <= x"e5";
			elsif input_sb(i*8+7 downto i*8) = x"2b" then output_sb(i*8+7 downto i*8) <= x"f1";
			elsif input_sb(i*8+7 downto i*8) = x"2c" then output_sb(i*8+7 downto i*8) <= x"71";
			elsif input_sb(i*8+7 downto i*8) = x"2d" then output_sb(i*8+7 downto i*8) <= x"d8";
			elsif input_sb(i*8+7 downto i*8) = x"2e" then output_sb(i*8+7 downto i*8) <= x"31";
			elsif input_sb(i*8+7 downto i*8) = x"2f" then output_sb(i*8+7 downto i*8) <= x"15";
			elsif input_sb(i*8+7 downto i*8) = x"30" then output_sb(i*8+7 downto i*8) <= x"04";
			elsif input_sb(i*8+7 downto i*8) = x"31" then output_sb(i*8+7 downto i*8) <= x"c7";
			elsif input_sb(i*8+7 downto i*8) = x"32" then output_sb(i*8+7 downto i*8) <= x"23";
			elsif input_sb(i*8+7 downto i*8) = x"33" then output_sb(i*8+7 downto i*8) <= x"c3";
			elsif input_sb(i*8+7 downto i*8) = x"34" then output_sb(i*8+7 downto i*8) <= x"18";
			elsif input_sb(i*8+7 downto i*8) = x"35" then output_sb(i*8+7 downto i*8) <= x"96";
			elsif input_sb(i*8+7 downto i*8) = x"36" then output_sb(i*8+7 downto i*8) <= x"05";
			elsif input_sb(i*8+7 downto i*8) = x"37" then output_sb(i*8+7 downto i*8) <= x"9a";
			elsif input_sb(i*8+7 downto i*8) = x"38" then output_sb(i*8+7 downto i*8) <= x"07";
			elsif input_sb(i*8+7 downto i*8) = x"39" then output_sb(i*8+7 downto i*8) <= x"12";
			elsif input_sb(i*8+7 downto i*8) = x"3a" then output_sb(i*8+7 downto i*8) <= x"80";
			elsif input_sb(i*8+7 downto i*8) = x"3b" then output_sb(i*8+7 downto i*8) <= x"e2";
			elsif input_sb(i*8+7 downto i*8) = x"3c" then output_sb(i*8+7 downto i*8) <= x"eb";
			elsif input_sb(i*8+7 downto i*8) = x"3d" then output_sb(i*8+7 downto i*8) <= x"27";
			elsif input_sb(i*8+7 downto i*8) = x"3e" then output_sb(i*8+7 downto i*8) <= x"b2";
			elsif input_sb(i*8+7 downto i*8) = x"3f" then output_sb(i*8+7 downto i*8) <= x"75";
			elsif input_sb(i*8+7 downto i*8) = x"40" then output_sb(i*8+7 downto i*8) <= x"09";
			elsif input_sb(i*8+7 downto i*8) = x"41" then output_sb(i*8+7 downto i*8) <= x"83";
			elsif input_sb(i*8+7 downto i*8) = x"42" then output_sb(i*8+7 downto i*8) <= x"2c";
			elsif input_sb(i*8+7 downto i*8) = x"43" then output_sb(i*8+7 downto i*8) <= x"1a";
			elsif input_sb(i*8+7 downto i*8) = x"44" then output_sb(i*8+7 downto i*8) <= x"1b";
			elsif input_sb(i*8+7 downto i*8) = x"45" then output_sb(i*8+7 downto i*8) <= x"6e";
			elsif input_sb(i*8+7 downto i*8) = x"46" then output_sb(i*8+7 downto i*8) <= x"5a";
			elsif input_sb(i*8+7 downto i*8) = x"47" then output_sb(i*8+7 downto i*8) <= x"a0";
			elsif input_sb(i*8+7 downto i*8) = x"48" then output_sb(i*8+7 downto i*8) <= x"52";
			elsif input_sb(i*8+7 downto i*8) = x"49" then output_sb(i*8+7 downto i*8) <= x"3b";
			elsif input_sb(i*8+7 downto i*8) = x"4a" then output_sb(i*8+7 downto i*8) <= x"d6";
			elsif input_sb(i*8+7 downto i*8) = x"4b" then output_sb(i*8+7 downto i*8) <= x"b3";
			elsif input_sb(i*8+7 downto i*8) = x"4c" then output_sb(i*8+7 downto i*8) <= x"29";
			elsif input_sb(i*8+7 downto i*8) = x"4d" then output_sb(i*8+7 downto i*8) <= x"e3";
			elsif input_sb(i*8+7 downto i*8) = x"4e" then output_sb(i*8+7 downto i*8) <= x"2f";
			elsif input_sb(i*8+7 downto i*8) = x"4f" then output_sb(i*8+7 downto i*8) <= x"84";
			elsif input_sb(i*8+7 downto i*8) = x"50" then output_sb(i*8+7 downto i*8) <= x"53";
			elsif input_sb(i*8+7 downto i*8) = x"51" then output_sb(i*8+7 downto i*8) <= x"d1";
			elsif input_sb(i*8+7 downto i*8) = x"52" then output_sb(i*8+7 downto i*8) <= x"00";
			elsif input_sb(i*8+7 downto i*8) = x"53" then output_sb(i*8+7 downto i*8) <= x"ed";
			elsif input_sb(i*8+7 downto i*8) = x"54" then output_sb(i*8+7 downto i*8) <= x"20";
			elsif input_sb(i*8+7 downto i*8) = x"55" then output_sb(i*8+7 downto i*8) <= x"fc";
			elsif input_sb(i*8+7 downto i*8) = x"56" then output_sb(i*8+7 downto i*8) <= x"b1";
			elsif input_sb(i*8+7 downto i*8) = x"57" then output_sb(i*8+7 downto i*8) <= x"5b";
			elsif input_sb(i*8+7 downto i*8) = x"58" then output_sb(i*8+7 downto i*8) <= x"6a";
			elsif input_sb(i*8+7 downto i*8) = x"59" then output_sb(i*8+7 downto i*8) <= x"cb";
			elsif input_sb(i*8+7 downto i*8) = x"5a" then output_sb(i*8+7 downto i*8) <= x"be";
			elsif input_sb(i*8+7 downto i*8) = x"5b" then output_sb(i*8+7 downto i*8) <= x"39";
			elsif input_sb(i*8+7 downto i*8) = x"5c" then output_sb(i*8+7 downto i*8) <= x"4a";
			elsif input_sb(i*8+7 downto i*8) = x"5d" then output_sb(i*8+7 downto i*8) <= x"4c";
			elsif input_sb(i*8+7 downto i*8) = x"5e" then output_sb(i*8+7 downto i*8) <= x"58";
			elsif input_sb(i*8+7 downto i*8) = x"5f" then output_sb(i*8+7 downto i*8) <= x"cf";
			elsif input_sb(i*8+7 downto i*8) = x"60" then output_sb(i*8+7 downto i*8) <= x"d0";
			elsif input_sb(i*8+7 downto i*8) = x"61" then output_sb(i*8+7 downto i*8) <= x"ef";
			elsif input_sb(i*8+7 downto i*8) = x"62" then output_sb(i*8+7 downto i*8) <= x"aa";
			elsif input_sb(i*8+7 downto i*8) = x"63" then output_sb(i*8+7 downto i*8) <= x"fb";
			elsif input_sb(i*8+7 downto i*8) = x"64" then output_sb(i*8+7 downto i*8) <= x"43";
			elsif input_sb(i*8+7 downto i*8) = x"65" then output_sb(i*8+7 downto i*8) <= x"4d";
			elsif input_sb(i*8+7 downto i*8) = x"66" then output_sb(i*8+7 downto i*8) <= x"33";
			elsif input_sb(i*8+7 downto i*8) = x"67" then output_sb(i*8+7 downto i*8) <= x"85";
			elsif input_sb(i*8+7 downto i*8) = x"68" then output_sb(i*8+7 downto i*8) <= x"45";
			elsif input_sb(i*8+7 downto i*8) = x"69" then output_sb(i*8+7 downto i*8) <= x"f9";
			elsif input_sb(i*8+7 downto i*8) = x"6a" then output_sb(i*8+7 downto i*8) <= x"02";
			elsif input_sb(i*8+7 downto i*8) = x"6b" then output_sb(i*8+7 downto i*8) <= x"7f";
			elsif input_sb(i*8+7 downto i*8) = x"6c" then output_sb(i*8+7 downto i*8) <= x"50";
			elsif input_sb(i*8+7 downto i*8) = x"6d" then output_sb(i*8+7 downto i*8) <= x"3c";
			elsif input_sb(i*8+7 downto i*8) = x"6e" then output_sb(i*8+7 downto i*8) <= x"9f";
			elsif input_sb(i*8+7 downto i*8) = x"6f" then output_sb(i*8+7 downto i*8) <= x"a8";
			elsif input_sb(i*8+7 downto i*8) = x"70" then output_sb(i*8+7 downto i*8) <= x"51";
			elsif input_sb(i*8+7 downto i*8) = x"71" then output_sb(i*8+7 downto i*8) <= x"a3";
			elsif input_sb(i*8+7 downto i*8) = x"72" then output_sb(i*8+7 downto i*8) <= x"40";
			elsif input_sb(i*8+7 downto i*8) = x"73" then output_sb(i*8+7 downto i*8) <= x"8f";
			elsif input_sb(i*8+7 downto i*8) = x"74" then output_sb(i*8+7 downto i*8) <= x"92";
			elsif input_sb(i*8+7 downto i*8) = x"75" then output_sb(i*8+7 downto i*8) <= x"9d";
			elsif input_sb(i*8+7 downto i*8) = x"76" then output_sb(i*8+7 downto i*8) <= x"38";
			elsif input_sb(i*8+7 downto i*8) = x"77" then output_sb(i*8+7 downto i*8) <= x"f5";
			elsif input_sb(i*8+7 downto i*8) = x"78" then output_sb(i*8+7 downto i*8) <= x"bc";
			elsif input_sb(i*8+7 downto i*8) = x"79" then output_sb(i*8+7 downto i*8) <= x"b6";
			elsif input_sb(i*8+7 downto i*8) = x"7a" then output_sb(i*8+7 downto i*8) <= x"da";
			elsif input_sb(i*8+7 downto i*8) = x"7b" then output_sb(i*8+7 downto i*8) <= x"21";
			elsif input_sb(i*8+7 downto i*8) = x"7c" then output_sb(i*8+7 downto i*8) <= x"10";
			elsif input_sb(i*8+7 downto i*8) = x"7d" then output_sb(i*8+7 downto i*8) <= x"ff";
			elsif input_sb(i*8+7 downto i*8) = x"7e" then output_sb(i*8+7 downto i*8) <= x"f3";
			elsif input_sb(i*8+7 downto i*8) = x"7f" then output_sb(i*8+7 downto i*8) <= x"d2";
			elsif input_sb(i*8+7 downto i*8) = x"80" then output_sb(i*8+7 downto i*8) <= x"cd";
			elsif input_sb(i*8+7 downto i*8) = x"81" then output_sb(i*8+7 downto i*8) <= x"0c";
			elsif input_sb(i*8+7 downto i*8) = x"82" then output_sb(i*8+7 downto i*8) <= x"13";
			elsif input_sb(i*8+7 downto i*8) = x"83" then output_sb(i*8+7 downto i*8) <= x"ec";
			elsif input_sb(i*8+7 downto i*8) = x"84" then output_sb(i*8+7 downto i*8) <= x"5f";
			elsif input_sb(i*8+7 downto i*8) = x"85" then output_sb(i*8+7 downto i*8) <= x"97";
			elsif input_sb(i*8+7 downto i*8) = x"86" then output_sb(i*8+7 downto i*8) <= x"44";
			elsif input_sb(i*8+7 downto i*8) = x"87" then output_sb(i*8+7 downto i*8) <= x"17";
			elsif input_sb(i*8+7 downto i*8) = x"88" then output_sb(i*8+7 downto i*8) <= x"c4";
			elsif input_sb(i*8+7 downto i*8) = x"89" then output_sb(i*8+7 downto i*8) <= x"a7";
			elsif input_sb(i*8+7 downto i*8) = x"8a" then output_sb(i*8+7 downto i*8) <= x"7e";
			elsif input_sb(i*8+7 downto i*8) = x"8b" then output_sb(i*8+7 downto i*8) <= x"3d";
			elsif input_sb(i*8+7 downto i*8) = x"8c" then output_sb(i*8+7 downto i*8) <= x"64";
			elsif input_sb(i*8+7 downto i*8) = x"8d" then output_sb(i*8+7 downto i*8) <= x"5d";
			elsif input_sb(i*8+7 downto i*8) = x"8e" then output_sb(i*8+7 downto i*8) <= x"19";
			elsif input_sb(i*8+7 downto i*8) = x"8f" then output_sb(i*8+7 downto i*8) <= x"73";
			elsif input_sb(i*8+7 downto i*8) = x"90" then output_sb(i*8+7 downto i*8) <= x"60";
			elsif input_sb(i*8+7 downto i*8) = x"91" then output_sb(i*8+7 downto i*8) <= x"81";
			elsif input_sb(i*8+7 downto i*8) = x"92" then output_sb(i*8+7 downto i*8) <= x"4f";
			elsif input_sb(i*8+7 downto i*8) = x"93" then output_sb(i*8+7 downto i*8) <= x"dc";
			elsif input_sb(i*8+7 downto i*8) = x"94" then output_sb(i*8+7 downto i*8) <= x"22";
			elsif input_sb(i*8+7 downto i*8) = x"95" then output_sb(i*8+7 downto i*8) <= x"2a";
			elsif input_sb(i*8+7 downto i*8) = x"96" then output_sb(i*8+7 downto i*8) <= x"90";
			elsif input_sb(i*8+7 downto i*8) = x"97" then output_sb(i*8+7 downto i*8) <= x"88";
			elsif input_sb(i*8+7 downto i*8) = x"98" then output_sb(i*8+7 downto i*8) <= x"46";
			elsif input_sb(i*8+7 downto i*8) = x"99" then output_sb(i*8+7 downto i*8) <= x"ee";
			elsif input_sb(i*8+7 downto i*8) = x"9a" then output_sb(i*8+7 downto i*8) <= x"b8";
			elsif input_sb(i*8+7 downto i*8) = x"9b" then output_sb(i*8+7 downto i*8) <= x"14";
			elsif input_sb(i*8+7 downto i*8) = x"9c" then output_sb(i*8+7 downto i*8) <= x"de";
			elsif input_sb(i*8+7 downto i*8) = x"9d" then output_sb(i*8+7 downto i*8) <= x"5e";
			elsif input_sb(i*8+7 downto i*8) = x"9e" then output_sb(i*8+7 downto i*8) <= x"0b";
			elsif input_sb(i*8+7 downto i*8) = x"9f" then output_sb(i*8+7 downto i*8) <= x"db";
			elsif input_sb(i*8+7 downto i*8) = x"a0" then output_sb(i*8+7 downto i*8) <= x"e0";
			elsif input_sb(i*8+7 downto i*8) = x"a1" then output_sb(i*8+7 downto i*8) <= x"32";
			elsif input_sb(i*8+7 downto i*8) = x"a2" then output_sb(i*8+7 downto i*8) <= x"3a";
			elsif input_sb(i*8+7 downto i*8) = x"a3" then output_sb(i*8+7 downto i*8) <= x"0a";
			elsif input_sb(i*8+7 downto i*8) = x"a4" then output_sb(i*8+7 downto i*8) <= x"49";
			elsif input_sb(i*8+7 downto i*8) = x"a5" then output_sb(i*8+7 downto i*8) <= x"06";
			elsif input_sb(i*8+7 downto i*8) = x"a6" then output_sb(i*8+7 downto i*8) <= x"24";
			elsif input_sb(i*8+7 downto i*8) = x"a7" then output_sb(i*8+7 downto i*8) <= x"5c";
			elsif input_sb(i*8+7 downto i*8) = x"a8" then output_sb(i*8+7 downto i*8) <= x"c2";
			elsif input_sb(i*8+7 downto i*8) = x"a9" then output_sb(i*8+7 downto i*8) <= x"d3";
			elsif input_sb(i*8+7 downto i*8) = x"aa" then output_sb(i*8+7 downto i*8) <= x"ac";
			elsif input_sb(i*8+7 downto i*8) = x"ab" then output_sb(i*8+7 downto i*8) <= x"62";
			elsif input_sb(i*8+7 downto i*8) = x"ac" then output_sb(i*8+7 downto i*8) <= x"91";
			elsif input_sb(i*8+7 downto i*8) = x"ad" then output_sb(i*8+7 downto i*8) <= x"95";
			elsif input_sb(i*8+7 downto i*8) = x"ae" then output_sb(i*8+7 downto i*8) <= x"e4";
			elsif input_sb(i*8+7 downto i*8) = x"af" then output_sb(i*8+7 downto i*8) <= x"79";
			elsif input_sb(i*8+7 downto i*8) = x"b0" then output_sb(i*8+7 downto i*8) <= x"e7";
			elsif input_sb(i*8+7 downto i*8) = x"b1" then output_sb(i*8+7 downto i*8) <= x"c8";
			elsif input_sb(i*8+7 downto i*8) = x"b2" then output_sb(i*8+7 downto i*8) <= x"37";
			elsif input_sb(i*8+7 downto i*8) = x"b3" then output_sb(i*8+7 downto i*8) <= x"6d";
			elsif input_sb(i*8+7 downto i*8) = x"b4" then output_sb(i*8+7 downto i*8) <= x"8d";
			elsif input_sb(i*8+7 downto i*8) = x"b5" then output_sb(i*8+7 downto i*8) <= x"d5";
			elsif input_sb(i*8+7 downto i*8) = x"b6" then output_sb(i*8+7 downto i*8) <= x"4e";
			elsif input_sb(i*8+7 downto i*8) = x"b7" then output_sb(i*8+7 downto i*8) <= x"a9";
			elsif input_sb(i*8+7 downto i*8) = x"b8" then output_sb(i*8+7 downto i*8) <= x"6c";
			elsif input_sb(i*8+7 downto i*8) = x"b9" then output_sb(i*8+7 downto i*8) <= x"56";
			elsif input_sb(i*8+7 downto i*8) = x"ba" then output_sb(i*8+7 downto i*8) <= x"f4";
			elsif input_sb(i*8+7 downto i*8) = x"bb" then output_sb(i*8+7 downto i*8) <= x"ea";
			elsif input_sb(i*8+7 downto i*8) = x"bc" then output_sb(i*8+7 downto i*8) <= x"65";
			elsif input_sb(i*8+7 downto i*8) = x"bd" then output_sb(i*8+7 downto i*8) <= x"7a";
			elsif input_sb(i*8+7 downto i*8) = x"be" then output_sb(i*8+7 downto i*8) <= x"ae";
			elsif input_sb(i*8+7 downto i*8) = x"bf" then output_sb(i*8+7 downto i*8) <= x"08";
			elsif input_sb(i*8+7 downto i*8) = x"c0" then output_sb(i*8+7 downto i*8) <= x"ba";
			elsif input_sb(i*8+7 downto i*8) = x"c1" then output_sb(i*8+7 downto i*8) <= x"78";
			elsif input_sb(i*8+7 downto i*8) = x"c2" then output_sb(i*8+7 downto i*8) <= x"25";
			elsif input_sb(i*8+7 downto i*8) = x"c3" then output_sb(i*8+7 downto i*8) <= x"2e";
			elsif input_sb(i*8+7 downto i*8) = x"c4" then output_sb(i*8+7 downto i*8) <= x"1c";
			elsif input_sb(i*8+7 downto i*8) = x"c5" then output_sb(i*8+7 downto i*8) <= x"a6";
			elsif input_sb(i*8+7 downto i*8) = x"c6" then output_sb(i*8+7 downto i*8) <= x"b4";
			elsif input_sb(i*8+7 downto i*8) = x"c7" then output_sb(i*8+7 downto i*8) <= x"c6";
			elsif input_sb(i*8+7 downto i*8) = x"c8" then output_sb(i*8+7 downto i*8) <= x"e8";
			elsif input_sb(i*8+7 downto i*8) = x"c9" then output_sb(i*8+7 downto i*8) <= x"dd";
			elsif input_sb(i*8+7 downto i*8) = x"ca" then output_sb(i*8+7 downto i*8) <= x"74";
			elsif input_sb(i*8+7 downto i*8) = x"cb" then output_sb(i*8+7 downto i*8) <= x"1f";
			elsif input_sb(i*8+7 downto i*8) = x"cc" then output_sb(i*8+7 downto i*8) <= x"4b";
			elsif input_sb(i*8+7 downto i*8) = x"cd" then output_sb(i*8+7 downto i*8) <= x"bd";
			elsif input_sb(i*8+7 downto i*8) = x"ce" then output_sb(i*8+7 downto i*8) <= x"8b";
			elsif input_sb(i*8+7 downto i*8) = x"cf" then output_sb(i*8+7 downto i*8) <= x"8a";
			elsif input_sb(i*8+7 downto i*8) = x"d0" then output_sb(i*8+7 downto i*8) <= x"70";
			elsif input_sb(i*8+7 downto i*8) = x"d1" then output_sb(i*8+7 downto i*8) <= x"3e";
			elsif input_sb(i*8+7 downto i*8) = x"d2" then output_sb(i*8+7 downto i*8) <= x"b5";
			elsif input_sb(i*8+7 downto i*8) = x"d3" then output_sb(i*8+7 downto i*8) <= x"66";
			elsif input_sb(i*8+7 downto i*8) = x"d4" then output_sb(i*8+7 downto i*8) <= x"48";
			elsif input_sb(i*8+7 downto i*8) = x"d5" then output_sb(i*8+7 downto i*8) <= x"03";
			elsif input_sb(i*8+7 downto i*8) = x"d6" then output_sb(i*8+7 downto i*8) <= x"f6";
			elsif input_sb(i*8+7 downto i*8) = x"d7" then output_sb(i*8+7 downto i*8) <= x"0e";
			elsif input_sb(i*8+7 downto i*8) = x"d8" then output_sb(i*8+7 downto i*8) <= x"61";
			elsif input_sb(i*8+7 downto i*8) = x"d9" then output_sb(i*8+7 downto i*8) <= x"35";
			elsif input_sb(i*8+7 downto i*8) = x"da" then output_sb(i*8+7 downto i*8) <= x"57";
			elsif input_sb(i*8+7 downto i*8) = x"db" then output_sb(i*8+7 downto i*8) <= x"b9";
			elsif input_sb(i*8+7 downto i*8) = x"dc" then output_sb(i*8+7 downto i*8) <= x"86";
			elsif input_sb(i*8+7 downto i*8) = x"dd" then output_sb(i*8+7 downto i*8) <= x"c1";
			elsif input_sb(i*8+7 downto i*8) = x"de" then output_sb(i*8+7 downto i*8) <= x"1d";
			elsif input_sb(i*8+7 downto i*8) = x"df" then output_sb(i*8+7 downto i*8) <= x"9e";
			elsif input_sb(i*8+7 downto i*8) = x"e0" then output_sb(i*8+7 downto i*8) <= x"e1";
			elsif input_sb(i*8+7 downto i*8) = x"e1" then output_sb(i*8+7 downto i*8) <= x"f8";
			elsif input_sb(i*8+7 downto i*8) = x"e2" then output_sb(i*8+7 downto i*8) <= x"98";
			elsif input_sb(i*8+7 downto i*8) = x"e3" then output_sb(i*8+7 downto i*8) <= x"11";
			elsif input_sb(i*8+7 downto i*8) = x"e4" then output_sb(i*8+7 downto i*8) <= x"69";
			elsif input_sb(i*8+7 downto i*8) = x"e5" then output_sb(i*8+7 downto i*8) <= x"d9";
			elsif input_sb(i*8+7 downto i*8) = x"e6" then output_sb(i*8+7 downto i*8) <= x"8e";
			elsif input_sb(i*8+7 downto i*8) = x"e7" then output_sb(i*8+7 downto i*8) <= x"94";
			elsif input_sb(i*8+7 downto i*8) = x"e8" then output_sb(i*8+7 downto i*8) <= x"9b";
			elsif input_sb(i*8+7 downto i*8) = x"e9" then output_sb(i*8+7 downto i*8) <= x"1e";
			elsif input_sb(i*8+7 downto i*8) = x"ea" then output_sb(i*8+7 downto i*8) <= x"87";
			elsif input_sb(i*8+7 downto i*8) = x"eb" then output_sb(i*8+7 downto i*8) <= x"e9";
			elsif input_sb(i*8+7 downto i*8) = x"ec" then output_sb(i*8+7 downto i*8) <= x"ce";
			elsif input_sb(i*8+7 downto i*8) = x"ed" then output_sb(i*8+7 downto i*8) <= x"55";
			elsif input_sb(i*8+7 downto i*8) = x"ee" then output_sb(i*8+7 downto i*8) <= x"28";
			elsif input_sb(i*8+7 downto i*8) = x"ef" then output_sb(i*8+7 downto i*8) <= x"df";
			elsif input_sb(i*8+7 downto i*8) = x"f0" then output_sb(i*8+7 downto i*8) <= x"8c";
			elsif input_sb(i*8+7 downto i*8) = x"f1" then output_sb(i*8+7 downto i*8) <= x"a1";
			elsif input_sb(i*8+7 downto i*8) = x"f2" then output_sb(i*8+7 downto i*8) <= x"89";
			elsif input_sb(i*8+7 downto i*8) = x"f3" then output_sb(i*8+7 downto i*8) <= x"0d";
			elsif input_sb(i*8+7 downto i*8) = x"f4" then output_sb(i*8+7 downto i*8) <= x"bf";
			elsif input_sb(i*8+7 downto i*8) = x"f5" then output_sb(i*8+7 downto i*8) <= x"e6";
			elsif input_sb(i*8+7 downto i*8) = x"f6" then output_sb(i*8+7 downto i*8) <= x"42";
			elsif input_sb(i*8+7 downto i*8) = x"f7" then output_sb(i*8+7 downto i*8) <= x"68";
			elsif input_sb(i*8+7 downto i*8) = x"f8" then output_sb(i*8+7 downto i*8) <= x"41";
			elsif input_sb(i*8+7 downto i*8) = x"f9" then output_sb(i*8+7 downto i*8) <= x"99";
			elsif input_sb(i*8+7 downto i*8) = x"fa" then output_sb(i*8+7 downto i*8) <= x"2d";
			elsif input_sb(i*8+7 downto i*8) = x"fb" then output_sb(i*8+7 downto i*8) <= x"0f";
			elsif input_sb(i*8+7 downto i*8) = x"fc" then output_sb(i*8+7 downto i*8) <= x"b0";
			elsif input_sb(i*8+7 downto i*8) = x"fd" then output_sb(i*8+7 downto i*8) <= x"54";
			elsif input_sb(i*8+7 downto i*8) = x"fe" then output_sb(i*8+7 downto i*8) <= x"bb";
			elsif input_sb(i*8+7 downto i*8) = x"ff" then output_sb(i*8+7 downto i*8) <= x"16";
			else  null; -- Handling the 'others' case
			end if;

		end loop;

	end if;
end process;
end behavioral;

