library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity lab8 is
	port(
		clk			:in std_logic;
		reset_n 	:in std_logic;
		filter_en 	:in std_logic;
		data_in		: in std_logic_vector(15 downto 0);
		data_out 	: out std_logic_vector(15 downto 0)
	);
end lab8;

architecture lab8_arch of lab8 is
--
--    component low_pass_filter is 
--		port (
--			clk         : in std_logic;
--			reset_n     : in std_logic;
--			data_in     : in std_logic_vector(15 downto 0);
--			filter_en   : in std_logic;
--			data_out    : out std_logic_vector(15 downto 0)
--		);
--	end component;

     component high_pass_filter is 
	 	port (
	 		clk         : in std_logic;
	 		reset_n     : in std_logic;
			data_in     : in std_logic_vector(15 downto 0);
	 		filter_en   : in std_logic;
	 		data_out    : out std_logic_vector(15 downto 0)
	 	);
	 end component;


begin
--
--	low_pass : low_pass_filter
--		port map(
--			clk			=> clk,
--			reset_n		=> reset_n,
--			data_in		=> data_in,
--			filter_en	=> filter_en,
--			data_out		=> data_out
--		);

	 high_pass : high_pass_filter
	 port map(
	 	clk			=> clk,
	 	reset_n		=> reset_n,
	 	data_in		=> data_in,
	 	filter_en	=> filter_en,
	 	data_out		=> data_out
	 );

end architecture lab8_arch;