library IEEE;
use ieee.std_logic_1164.all, ieee.numeric_std.all;

entity fancy_counter is
port(CLK,CLK_EN,LD,RST,dir,en,updn : in std_logic;
     val :in std_logic_vector(3 downto 0);
     cnt :out std_logic_vector(3 downto 0));
end fancy_counter;

architecture fc of fancy_counter is
signal count : std_logic_vector(3 downto 0) := (others=>'0');
signal direction : std_logic;
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
                        cnt<=count;
                    end if;   
                    if(updn='1')then
                        direction<=dir;    --put dir into direction register
                        if(direction='1') then --if direction is 1 then it counts up
                             count<=std_logic_vector(unsigned(count)+1);
                             cnt<=count;
                             if(count=val) then --if you counted up to value reset
                               count<=(others=>'0');
                             end if;
                        elsif(direction='0') then --if direction is 0 then it counts down
                             count<=std_logic_vector(unsigned(count)-1);
                             cnt<=count;
                             if(count ="0000") then --if counting down reset back to original
                                count<=val;
                                cnt<=count;
                             end if;
                        end if;    
                    end if;
               end if;
     end if;
    end process;
    
    end fc;