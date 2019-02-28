library IEEE;
 use ieee.std_logic_1164.all, ieee.numeric_std.all;   
    
 entity crkt_1 is
 port(btn, sw :in std_logic_vector(3 downto 0);
      clk :in std_logic;
      led :out std_logic_vector(3 downto 0));
end crkt_1;

architecture crkt_sim of crkt_1 is

component debounce
port (clk : in std_logic;
      btn : in std_logic;
      dbnc : out std_logic);
end component;

component clk_div 
port(clk :in std_logic;
    div :out std_logic);
end component;

component fancy_counter
port(CLK,CLK_EN,LD,RST,dir,en,updn : in std_logic;
     val :in std_logic_vector(3 downto 0);
     cnt :out std_logic_vector(3 downto 0));
end component;

signal db1_rst, db2_en, db3_upd, db4_ld, cl_div_cl_en : std_logic;

begin
db_1 : debounce
port map(clk=> clk,
         btn=> btn(0),
         dbnc=>db1_rst);
db_2 :debounce
port map(clk=> clk,
         btn=> btn(1),
         dbnc=>db2_en);
db_3 :debounce
port map(clk=> clk,
         btn=> btn(2),
         dbnc=>db3_upd);
db_4 :debounce
port map(clk=> clk,
         btn=> btn(3),
         dbnc=>db4_ld);
c_div : clk_div
port map(clk=> clk,
         div=>cl_div_cl_en);
 
count : fancy_counter
port map(CLK=>clk,
         CLK_EN=>cl_div_cl_en,
         LD=>db4_ld,
         RST=>db1_rst,
         dir=>sw(0),
         en=>db2_en,
         updn=>db3_upd,
         val(3)=>sw(3),
         val(2)=>sw(2),
         val(1)=>sw(1),
         val(0)=>sw(0),
         cnt(3) =>led(3),
         cnt(2) =>led(2),
         cnt(1) =>led(1),
         cnt(0) =>led(0));
end crkt_sim;