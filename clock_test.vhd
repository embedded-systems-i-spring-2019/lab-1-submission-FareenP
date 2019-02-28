Library IEEE;
use IEEE.std_logic_1164.all,IEEE.numeric_std.all;

ENTITY Tb_clock_div IS
END Tb_clock_div;

architecture behave of Tb_clock_div is
Component clk_divider
port(clk :in std_logic;
    led0 :out std_logic;
    clk_out :out std_logic_vector(25 downto 0));
end Component;

signal clk_test : std_logic := '0';

signal led_test : std_logic;
signal clk_out_test : std_logic_vector(25 downto 0);

constant clk_period : time := 4 ns;

begin
uut: clk_divider PORT MAP (
clk => clk_test,
led0 => led_test,
clk_out => clk_out_test);

clk_process :process
begin
clk_test <= '0';
wait for clk_period/2;
clk_test <= '1';
wait for clk_period/2;
end process;

stim_proc: process
begin
    wait for 10ns;  
    wait;
    end process;
    end;

