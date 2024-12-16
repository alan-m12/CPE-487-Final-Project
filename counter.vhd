
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter is
    port(
        CLK : in std_logic;
        EN : in std_logic;
        R_N : out std_logic_vector(3 downto 0)
    );
end counter;

architecture Behavioral of counter is
    component tFlipFlop is
        Port ( 
            CLK, EN, T : in STD_LOGIC;
            Q : out STD_LOGIC
        );
    end component;
               
    signal Q0, Q1, Q2, Q3 : std_logic;
    signal f, g : std_logic;

begin 
    T0 : tFlipFlop port map(
        CLK => CLK,
        EN => EN,
        T => '1', 
        Q => Q0
    );
                                        
    T1 : tFlipFlop port map(
        CLK => CLK,
        EN => EN,
        T => Q0,
        Q => Q1
    );
                                        
    f <= Q1 and Q0;  
                
    T2 : tFlipFlop port map(
        CLK => CLK,
        EN => EN,
        T => f,
        Q => Q2
    );
                                        
    g <= Q1 and Q2 and Q0;
                                        
    T3 : tFlipFlop port map(
        CLK => CLK,
        EN => EN,
        T => g,
        Q => Q3
    );
      
    R_N <= Q3 & Q2 & Q1 & Q0;

end Behavioral;

