library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;

entity multiplex21 is
port(A0,A1 :in std_logic_vector(7 downto 0);
     sel :in std_logic;
     m_out :out std_logic_vector(7 downto 0));  
end multiplex21;

architecture m21 of multiplex21 is
begin
    WITH sel select
        m_out <= A1 When '1',
                 A0 When '0',
                 (others=>'0') when others;
end m21;

library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity reg1 is
port(LD, CLK :in std_logic;
     r_in :in std_logic_vector(7 downto 0);
     R_Out :out std_logic_vector(7 downto 0));
end reg1;

architecture reg_a of reg1 is
begin
    reg: process(CLK)
    begin
        if(falling_edge(CLK)) then
            if(LD='1') then
                R_out<=r_in;
            end if;
        end if;
     end process;
end reg_a;

library IEEE;
use ieee.std_logic_1164.all;
entity an_gat is
port(A1,A2 :in std_logic;
     a_out :out std_logic);
end an_gat;

architecture A_Gate of an_gat is
begin
    a_out <= (A1 AND A2);
end A_Gate;

library IEEE;
use ieee.std_logic_1164.all;
entity crt_4 is
port(LDB,LDA,RD,S1,S0,CLK : in std_logic;
     X,Y :in std_logic_vector(7 downto 0);
     RA :out std_logic_vector(7 downto 0);
     RB :inout std_logic_vector(7 downto 0));
end crt_4;

architecture crt_4_sim of crt_4 is
Component multiplex21
    port(A0,A1 :in std_logic_vector(7 downto 0);
         sel :in std_logic;
         m_out :out std_logic_vector(7 downto 0));      
end component;

component reg1
    port(LD, CLK :in std_logic;
         r_in :in std_logic_vector(7 downto 0);
         R_Out :out std_logic_vector(7 downto 0));
end component;

component an_gat
    port(A1,A2 :in std_logic;
         a_out :out std_logic);
end component;

signal mux1_out, mux2_out : std_logic_vector(7 downto 0);
signal an_top, an_bot : std_logic;
signal no_r : std_logic;
begin
    no_r<=not(RD);
    
    an_t : an_gat
    port map(A1=>LDB,
             A2=>no_r,
             a_out=>an_top);
    
    mux1 : multiplex21
    port map(A0=>Y,
             A1 =>X,
             sel => S1,
             m_out => mux1_out);
             
    an_b : an_gat
    port map(A1=>LDA,
             A2=>RD,
             a_out=>an_bot);
    
    regB : reg1
    port map(LD => an_top, 
             CLK =>clk,
             r_in => mux1_out,
             R_Out=>RB);
             
    mux2 : multiplex21
    port map(A0=>Y,
             A1 =>RB,
             sel => S0,
             m_out => mux2_out);      
   
   regA: reg1
    port map(LD => an_bot, 
             CLK =>clk,
             r_in => mux2_out,
             R_Out=>RA);
end crt_4_sim;
