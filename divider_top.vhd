Library IEEE;
use IEEE.std_logic_1164.all,IEEE.numeric_std.all;

entity divider_top is
port(Clk,CE,D : in std_logic;
     q :out std_logic);
end divider_top;

architecture div_top of divider_top is
signal tmp : std_logic;
begin

    process(Clk)
    begin
        if(rising_edge(clk)) then
            if(CE = '1') then
                Q<=Not(D);
            else
                Q<= D;
            end if;
        end if;
        end process;
end div_top;

Library IEEE;
use IEEE.std_logic_1164.all,IEEE.numeric_std.all;
 
entity crt_1 is
port(CLK :in std_logic;
     led0 :inout std_logic);
end crt_1;

architecture crt_1_sim of crt_1 is
component divider_top
    port(Clk,CE,D : in std_logic;
         q :out std_logic);
 end component;
 
component clk_div 
port(clk :in std_logic;
    div :out std_logic);
end component;

signal div_out, Q_D,N_Q_D : std_logic;

begin
N_Q_D <=NOT(led0);
clock_div : clk_Div
port map(CLK=>clk,
         div=>div_out);

led_reg : divider_top
port map(Clk=>clk,
         CE=>div_out,
         D=>N_Q_D,
         Q=>led0);
 end crt_1_sim;
