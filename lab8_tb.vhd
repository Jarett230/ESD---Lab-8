library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use std.textio.all;

entity lab8_tb is
end;

architecture lab8_tb_arch of lab8_tb is

  type arraytype is array (39 downto 0) of signed(15 downto 0);

  component lab8
      port (
      clk : in std_logic;
      reset_n : in std_logic;
      filter_en : in std_logic;
      data_in : in std_logic_vector(15 downto 0);
      data_out : out std_logic_vector(15 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 20 ns;
  -- Generics

  -- Ports
  signal clk : std_logic := '0';
  signal reset_n : std_logic := '1';
  signal filter_en : std_logic := '0';
  signal data_in : std_logic_vector(15 downto 0) := "0000000000000000";
  signal data_out : std_logic_vector(15 downto 0) := "0000000000000000";
  signal audioSampleArray : arraytype := (others => "0000000000000000");

begin

lab8_inst : lab8
    port map (
    clk => clk,
    reset_n => reset_n,
    filter_en => filter_en,
    data_in => data_in,
    data_out => data_out
    );

clk_process : process
    begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
    end process clk_process;

stimulus : process is 
    file read_file : text;
    file results_file : text;
    variable lineIn : line;
    variable lineOut : line;
    variable readValue : integer;
    variable writeValue : integer;
begin
    reset_n <= '0';
    wait for clk_period;
    reset_n <= '1';
    file_open(read_file, "one_cycle_integer.csv", read_mode);
    file_open(results_file, "output_waveform.csv", write_mode);
    -- Read data from file into an array
    for i in 0 to 39 loop
    readline(read_file, lineIn);
    read(lineIn, readValue);
    audioSampleArray(i) <= conv_signed(readValue, 16);
    end loop;
    file_close(read_file);
    
    -- Apply the test data and put the result into an output file
    for i in 1 to 10 loop
    for j in 0 to 39 loop
    
    -- Your code here...
    data_in <= std_logic_vector(audioSampleArray(j));
    filter_en <= '1';
    wait for clk_period;
    filter_en <= '0';
    wait for clk_period;
    -- Read the data from the array and apply it to Data_In
    -- Remember to provide an enable pulse with each new sample
    
    -- Write filter output to file
    writeValue := conv_integer(data_out);
    write(lineOut, writeValue);
    writeline(results_file, lineOut);
    
    -- Your code here...
    
    end loop;
    end loop;
    file_close(results_file);
    -- end simulation
    --sim_done <= true;
    wait for 100 ns;
    -- last wait statement needs to be here to prevent the process
    -- sequence from restarting at the beginning
    wait;
    end process stimulus;


end;
