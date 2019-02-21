library IEEE;
use ieee.std_logic_1164.all;

entity de21 is
port(d_in :in std_logic;
       d0, d1 :out std_logic);
end de21;

architecture d2_1 of de21 is
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

entity multi_21 is
port(A0,A1 :in std_logic_vector(7 downto 0);
     sel :in std_logic;
     m_out :out std_logic_vector(7 downto 0));  
end multi_21;

architecture m21 of multi_21 is
begin
    WITH sel select
        m_out <= A1 When '1',
                 A0 When '0',
                 (others=>'0') when others;
end m21;

library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity registr is
port(LD, CLK :in std_logic;
     reg_in :in std_logic_vector(7 downto 0);
     R_Out :out std_logic_vector(7 downto 0));
end registr;

architecture rega of registr is
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
Entity crt_6 is
port(A,B,C :in std_logic_vector(7 downto 0);
     SEL1,SEL2,CLK :in std_logic;
     RAP,RBP :out std_logic_vector(7 downto 0));
end crt_6;

architecture crt_6_sim of crt_6 is
component de21
    port(d_in :in std_logic;
       d0, d1 :out std_logic);
end component;

component multi_21
    port(A0,A1 :in std_logic_vector(7 downto 0);
         sel :in std_logic;
         m_out :out std_logic_vector(7 downto 0)); 
end component;

component  registr
    port(LD, CLK :in std_logic;
         reg_in :in std_logic_vector(7 downto 0);
         R_Out :out std_logic_vector(7 downto 0));
 end component;
 
 signal de1_out, de0_out : std_logic;
 signal mux1_out : std_logic_vector(7 downto 0);
 begin
 
 mux1 : multi_21
 port map(A0=>B,
          A1=>A,
          sel=>SEL1,
          m_out=>mux1_out);
 d12 : de21
   port map(d_in=>SEL2,
            d0=>de0_out,
            d1=>de1_out);
            
 regi_A : registr
    port map(LD=> de1_out,
             clk=>clk,
             reg_in=>mux1_out,
             r_out=>RAP);
regi_B : registr
    port map(LD=> de0_out,
             clk=>clk,
             reg_in=>C,
             r_out=>RBP);
end crt_6_sim;
     