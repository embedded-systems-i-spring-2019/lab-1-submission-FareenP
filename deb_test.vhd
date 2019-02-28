Library IEEE;
use IEEE.std_logic_1164.all,IEEE.numeric_std.all;

ENTITY deb_t IS
END deb_t;

architecture behave of deb_t is
Component debounce
port(clk :in std_logic;
    btn :in std_logic;
    dbnc :out std_logic);
end Component;

signal clk_test : std_logic := '0';
signal btn_test : std_logic;
signal dbnc_test : std_logic;

constant clk_period : time := 10 ns;

begin
uut: debounce PORT MAP (
clk => clk_test,
btn => btn_test,
dbnc => dbnc_test);

clk_process :process
begin
clk_test <= '0';
wait for clk_period/2;
clk_test <= '1';
wait for clk_period/2;


end process;


stim_proc: process
begin
    wait for 100ns;
   btn_test<='1';
    wait;
    end process;
    end;
 
