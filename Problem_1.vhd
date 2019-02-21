library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;

entity mux_21 is
port(D1,D2 :in std_logic_vector(7 downto 0);
     sel :in std_logic;
     m_out :out std_logic_vector(7 downto 0));  
end mux_21;

architecture m21 of mux_21 is
begin
    WITH sel select
        m_out <= D1 When '1',
                 D2 When '0',
                 (others=>'0') when others;
end m21;

library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity reg_A is
port(LD, CLK :in std_logic;
     reg_in :in std_logic_vector(7 downto 0);
     R_Out :out std_logic_vector(7 downto 0));
end reg_A;

architecture reg_a of reg_a is
begin
    reg: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(LD='1') then
                R_out<=reg_in;
            end if;
        end if;
     end process;
end reg_a;

library IEEE;
use IEEE.std_logic_1164.all, IEEE.numeric_std.all;
entity circuit is
port(SEL,CLK, LDA : in std_logic;
    A,B :in std_logic_vector(7 downto 0);
    F :out std_logic_vector(7 downto 0));
end circuit;

architecture struct_ckt of circuit is
 component mux_21
    port (D1,D2 :in std_logic_vector(7 downto 0);
          sel :in std_logic;
          m_out :out std_logic_vector(7 downto 0));
 end component;
 component reg_a
    port(LD, CLK :in std_logic;
         reg_in :in std_logic_vector(7 downto 0);
         R_Out :out std_logic_vector(7 downto 0));
 end component;
 signal mux_result: std_logic_vector(7 downto 0);
 begin
    A_regist:  reg_a
    port map(LD => LDA,
             CLK => CLK,
             reg_in => mux_result,
             R_out => F);
    mux2to1: mux_21
    port map(D1 => A,
             D2 => B,
             sel => SEL,
             m_out =>mux_result);
end struct_ckt;                
--my 1st attempt at structural(let me know if something is wrong or if ihave some sort of misunderstanding with it)
