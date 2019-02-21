library IEEE;
use ieee.std_logic_1164.all;

entity d21 is
port(d_in :in std_logic;
       d0, d1 :out std_logic);
end d21;

architecture d2_1 of d21 is
begin
     process(d_in)
     begin
        if (d_in='0') then d0<='0';
        else d1<='1';
        end if;
     end process;
end d2_1;

library IEEE;
use ieee.std_logic_1164.all;

entity mult_21 is
port(A0,A1 :in std_logic_vector(7 downto 0);
     sel :in std_logic;
     m_out :out std_logic_vector(7 downto 0));  
end mult_21;

architecture m21 of mult_21 is
begin
    WITH sel select
        m_out <= A1 When '1',
                 A0 When '0',
                 (others=>'0') when others;
end m21;

library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity regrar is
port(LD, CLK :in std_logic;
     reg_in :in std_logic_vector(7 downto 0);
     R_Out :out std_logic_vector(7 downto 0));
end regrar;

architecture rega of regrar is
begin
    reg: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(LD='1') then
                R_out<=reg_in;
            end if;
        end if;
     end process;
end rega;

Library IEEE;
use IEEE.std_logic_1164.all;
Entity crt_5 is
port(A,B,C :in std_logic_vector(7 downto 0);
     SL1,SL2,CLK :in std_logic;
     RAX,RBX :out std_logic_vector(7 downto 0));
end crt_5;

architecture crt_5_sim of crt_5 is
component d21
    port(d_in :in std_logic;
       d0, d1 :out std_logic);
end component;

component mult_21
    port(A0,A1 :in std_logic_vector(7 downto 0);
         sel :in std_logic;
         m_out :out std_logic_vector(7 downto 0)); 
end component;

component  regrar
    port(LD, CLK :in std_logic;
         reg_in :in std_logic_vector(7 downto 0);
         R_Out :out std_logic_vector(7 downto 0));
 end component;
 
 signal d1_out, d0_out : std_logic;
 signal mux_out : std_logic_vector(7 downto 0);
 begin
 
 mux1 : mult_21
 port map(A0=>C,
          A1=>B,
          sel=>SL2,
          m_out=>mux_out);
 d12 : d21
   port map(d_in=>SL1,
            d0=>d0_out,
            d1=>d1_out);
            
 reg_1 : regrar
    port map(LD=> d1_out,
             clk=>clk,
             reg_in=>A,
             r_out=>RAX);
reg_2 : regrar
    port map(LD=> d0_out,
             clk=>clk,
             reg_in=>mux_out,
             r_out=>RBX);
end crt_5_sim;
     