library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;

entity multi21 is
port(A0,A1 :in std_logic_vector(7 downto 0);
     sel :in std_logic;
     m_out :out std_logic_vector(7 downto 0));  
end multi21;

architecture m21 of multi21 is
begin
    WITH sel select
        m_out <= A1 When '1',
                 A0 When '0',
                 (others=>'0') when others;
end m21;

library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity regis is
port(LD, CLK :in std_logic;
     r_in :in std_logic_vector(7 downto 0);
     R_Out :out std_logic_vector(7 downto 0));
end regis;

architecture reg_a of regis is
begin
    reg: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(LD='1') then
                R_out<=r_in;
            end if;
        end if;
     end process;
end reg_a;

library IEEE;
use IEEE.std_logic_1164.all;
entity whol_crt is
port(LDA, LDB,S0,S1,CLK :in std_logic;
     X,Y :in std_logic_vector(7 downto 0);
     RB :inout std_logic_vector(7 downto 0));
end whol_crt;

architecture stim_cirk of whol_crt is
component multi21
    port(A0,A1 :in std_logic_vector(7 downto 0);
     sel :in std_logic;
     m_out :out std_logic_vector(7 downto 0)); 
end component;

component regis
    port(LD, CLK :in std_logic;
     r_in :in std_logic_vector(7 downto 0);
     R_Out :out std_logic_vector(7 downto 0));
end component;


signal m1_out,regAOut,X_regB, m2out : std_logic_vector(7 downto 0);
begin
mux1 : multi21
    port map(A0 => RB,
             A1 => X,
             sel =>S1,
             m_out =>m1_out);
rega : regis
    port map(LD=> LDA,
             CLK => CLK,
             r_in=>m1_out,
             r_out=>regaout);
mux2 : multi21
    port map(A0 => Y,
             A1 => regaout,
             sel =>S0,
             m_out =>m2out);
regb : regis
    port map(LD=> LDB,
             CLK => CLK,
             r_in=>m2out,
             r_out=>RB);
end stim_cirk;
