library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Roulette is
   port(
      SWITCHES : in std_logic_vector(15 to 0);
      CLK, BTN1 : in std_logic;
      SEGMENTS : out std_logic_vector(7 to 0);
      DISP_EN : out std_logic_vector(3 to 0)
   );
end entity Roulette;
 
architecture Behavioral of Roulette is
    
    component counter is
        Port (CLK, EN : in STD_LOGIC;
              R_N : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component main is
     port ( CLK : in std_logic;
            SWITCHES : in std_logic_vector(15 to 0);
            R_N : in std_logic_vector(3 downto 0);
            X : out std_logic);
    end component;
    
    component my_fsm is
        port ( SWITCHES : in std_logic_vector(15 to 0);
               X, CLK : in std_logic;
               Z : out std_logic);
    end component;
    
    component BC_DEC is
        Port ( CLK,Z : in std_logic;   
               DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 to 0));
    end component;
               
signal R_N : std_logic_vector(3 downto 0);
signal X,Z : std_logic;
       
begin

    counter1 : counter port map (
        CLK => CLK,
        EN => BTN1,
        R_N => R_N
    );
                                 
    main1 : main port map (
        CLK => CLK,
        SWITCHES => SWITCHES,
        R_N => R_N,
        X => X
    );
                           
    FSM1 : my_fsm port map (
        SWITCHES => SWITCHES,
        CLK => CLK,
        X => X,
        Z => Z
    );
                         
    BC_DEC1 : BC_DEC port map (
        CLK => CLK,
        Z => Z,
        DISP_EN => DISP_EN,
        SEGMENTS => SEGMENTS
    );
                                     
end Behavioral;
