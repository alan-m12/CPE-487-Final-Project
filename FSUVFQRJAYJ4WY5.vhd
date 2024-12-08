----------------------------------------------------------------------------------
-- 
-- Engineer: Astha, Chase
-- 
-- Create Date: 11/03/2017 03:34:15 PM
-- Module Name: Main Minesweeper Module
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
   port(
      CLK : in std_logic;
      SWITCHES : in std_logic_vector(0 to 15);
      R_N : in std_logic_vector(3 downto 0);
      X : out std_logic);
end main;

architecture Behavioral of main is

signal R_N_D : natural;
signal digit : std_logic_vector (3 downto 0);
               
begin
   process (R_N) is
   begin
        if (R_N = "0000") then 
            R_N_D <= 0;
        elsif R_N <= "0001" then
            R_N_D <= 1;
        elsif R_N <= "0010" then
            R_N_D <= 2;
        elsif R_N <= "0011" then
            R_N_D <= 3;
        elsif R_N <= "0100" then
            R_N_D <= 4;
        elsif R_N <= "0101" then
            R_N_D <= 5;
        elsif R_N <= "0110" then
            R_N_D <= 6;
        elsif R_N <= "0111" then
            R_N_D <= 7;
        elsif R_N <= "1000" then
            R_N_D <= 8;
        elsif R_N <= "1001" then
            R_N_D <= 9;
        elsif R_N <= "1010" then
            R_N_D <= 10;
        elsif R_N <= "1011" then
            R_N_D <= 11;
        elsif R_N <= "1100" then
            R_N_D <= 12;
        elsif R_N <= "1101" then
            R_N_D <= 13;
        elsif R_N <= "1110" then
            R_N_D <= 14;
        elsif R_N <= "1111" then
            R_N_D <= 15;
        end if;
   end process;

X <= SWITCHES(R_N_D);

end  Behavioral;