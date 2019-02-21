Library IEEE;
use IEEE.std_logic_1164.all;

entity mux_41 is
port(A,B,C,D :in std_logic_vector(7 downto 0);
    SEL :in std_logic_vector(1 downto 0);
    Mux_out :out std_logic_vector(7 downto 0));
end mux_41;

architecture mux4 of mux_41 is
begin
    with SEL select
        mux_out <=  A when "00",
                    B when "01",
                    C when "10",
                    D when "11",
                    (others=>'0') when others;
end mux4; 
Library IEEE;
use IEEE.std_logic_1164.all;

entity reg_8 is
port( clk, load : in std_logic;
      reg_in :in std_logic_vector(7 downto 0);
      reg_out: out std_logic_vector(7 downto 0));
end reg_8;

architecture reg_8 of reg_8 is
begin
    reg: process(CLK)
    begin
        if(falling_edge(CLK)) then
            if(load='1') then
                reg_out<=reg_in;
            end if;
        end if;
     end process;
end reg_8;

library IEEE;
use ieee.std_logic_1164.all;

entity dec_21 is
port(d_in :in std_logic;
       d0, d1 :out std_logic);
end dec_21;

architecture d2_1 of dec_21 is
begin
     process(d_in)
     begin
        if (d_in='0') then d0<='0';
        else d1<='1';
        end if;
     end process;
end d2_1;

Library IEEE;
use IEEE.std_logic_1164.all;
entity ckt_sim is
port(X,Y,Z :in std_logic_vector(7 downto 0);
     MS : in std_logic_vector(1 downto 0);
     RA,RB :inout std_logic_vector(7 downto 0);
     CLK, DS :in std_logic);
end ckt_sim;
     
architecture rtl_ckt of ckt_sim is
Component mux_41
    port(A,B,C,D :in std_logic_vector(7 downto 0);
         SEL :in std_logic_vector(1 downto 0);
         Mux_out :out std_logic_vector(7 downto 0));
end component; 

component reg_8
    port(clk, load : in std_logic;
         reg_in :in std_logic_vector(7 downto 0);
         reg_out :out std_logic_vector(7 downto 0));
end component;

component dec_21
    port(d_in :in std_logic;
         d0, d1 :out std_logic);
end component;
signal m_out : std_logic_vector(7 downto 0);
signal d1_ld : std_logic;
signal d0_ld : std_logic;
signal r_aout, m_rb : std_logic_vector(7 downto 0);

begin
    m4_1 : mux_41
    port map(A => X,
             B => Y,
             C => Z,
             D => RB,
             SEL => MS,
             Mux_out => m_out);
    
    Reg_A: reg_8
    port map(clk => CLK,
             load => d0_ld,
             reg_in => m_out,
             reg_out => RA);
             
    reg_b: reg_8
    port map(clk => CLK,
             load => d1_ld,
             reg_in => RA,
             reg_out =>RB);
             
    deco_2_1: dec_21
    port map(d_in=> DS,
             d0 => d0_ld,
             d1 => d1_ld);
end rtl_ckt;