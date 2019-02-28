library IEEE;
use ieee.std_logic_1164.all, ieee.numeric_std.all;

entity fancy_counter is
port(CLK,CLK_EN,LD,RST,dir,en,updn : in std_logic;
     val :in std_logic_vector(3 downto 0);
     cnt :out std_logic_vector(3 downto 0));
end fancy_counter;

architecture fc of fancy_counter is
signal count,count_d : std_logic_vector(3 downto 0) := (others=>'0');
begin
    process(CLK)
    begin
    if( rising_edge(clk) and en='1')then
                if(rst='1')then
                    cnt<= (others=> '0');
                end if;
                if(clk_en='1') then
                    if(ld='1') then
                        count<=val;
                        count_d<=count; 
                        cnt<=count;
                    end if;   
                    if(updn='1')then    
                        if(dir='1') then
                             count<=std_logic_vector(unsigned(count)+1);
                             cnt<=count;
                             if(count=val) then
                               count<="0000";
                             end if;
                        elsif(dir='0') then
                             count<=std_logic_vector(unsigned(count)-1);
                             cnt<=count;
                             if(count ="0000") then
                                count<=count_d;
                                cnt<=count;
                             end if;
                        end if;    
                    end if;
               end if;
     end if;
    end process;
    
    end fc;
