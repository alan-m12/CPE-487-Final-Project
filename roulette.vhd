library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Roulette is
    port(
        CLK100MHZ : in std_logic;
        SW : in std_logic_vector(15 downto 0);
        BTN0 : in std_logic;
        BTNU : in std_logic;  -- New button for mode 2
        SEGMENTS : out std_logic_vector(7 downto 0);
        AN : out std_logic_vector(7 downto 0);
        LED : out std_logic_vector(1 downto 0)
    );
end entity Roulette;

architecture Behavioral of Roulette is
    component my_fsm is
        port (
            SWITCHES : in std_logic_vector(15 downto 0);
            BTN0 : in std_logic;
            BTNU : in std_logic;
            CLK : in std_logic;
            Z : out std_logic;
            START : out std_logic;
            BOMB_LOCATION : out std_logic_vector(3 downto 0);
            CURRENT_PLAYER : out std_logic;
            LED_STATE : out std_logic_vector(1 downto 0)
        );
    end component;

    component BC_DEC is
        port (    
            CLK, Z : in std_logic;
            START : in std_logic; 
            DISP_EN : out std_logic_vector(7 downto 0);  
            SEGMENTS : out std_logic_vector(7 downto 0)
        );
    end component;

    signal Z : std_logic;
    signal START : std_logic;
    signal BOMB_LOCATION : std_logic_vector(3 downto 0);
    signal CURRENT_PLAYER : std_logic;

begin
    FSM_INST : my_fsm port map (
        SWITCHES => SW,
        BTN0 => BTN0,
        BTNU => BTNU,
        CLK => CLK100MHZ,
        Z => Z,
        START => START,
        BOMB_LOCATION => BOMB_LOCATION,
        CURRENT_PLAYER => CURRENT_PLAYER,
        LED_STATE => LED
    );

    BC_DEC_INST : BC_DEC port map (
        CLK => CLK100MHZ,
        Z => Z,
        START => START,
        DISP_EN => AN,
        SEGMENTS => SEGMENTS
    );
end Behavioral;
