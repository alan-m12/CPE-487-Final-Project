----------------------------------------------------------------------------------
-- Engineer: Astha, Chase
-- 
-- Create Date: 10/27/2017 03:50:11 PM
-- Module Name: tFlipFlop - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tFlipFlop is
   port(
      T : in std_logic;
      CLK : in std_logic;
      EN : in std_logic;
      Q : out std_logic
   );
end entity tFlipFlop;


 
architecture Behavioral of tFlipFlop is
signal t_Q : std_logic := '0';
begin
   process (CLK) is
   begin
        if (EN = '1') then
            if rising_edge(CLK) then
                t_Q <= T XOR t_Q;
            end if;
        else
            t_Q <= t_Q;
        end if;
        
   end process;
   Q <= t_Q;
   
end architecture Behavioral;
