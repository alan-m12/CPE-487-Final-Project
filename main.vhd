library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
   port(
      CLK : in std_logic;
      SWITCHES : in std_logic_vector(0 to 15);
      R_N : in std_logic_vector(3 downto 0);
      X : out std_logic);
end main;

architecture Behavioral of main is
begin
    process(R_N, SWITCHES)
    begin
        -- Convert R_N to integer index, ensuring it's within switch vector range
        X <= SWITCHES(to_integer(unsigned(R_N)));
    end process;
end Behavioral;
