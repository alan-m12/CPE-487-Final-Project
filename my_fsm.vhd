library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity my_fsm is
	port ( 
        SWITCHES : in std_logic_vector(15 downto 0);
        BTN0 : in std_logic;  -- Middle button to set bomb
	    CLK : in std_logic;
		Z : out std_logic;
        BOMB_LOCATION : out std_logic_vector(3 downto 0);  -- Bomb location
        CURRENT_PLAYER : out std_logic  -- 0 or 1 to indicate current player
    );
end my_fsm;

architecture fsm of my_fsm is
	type state_type is (INIT, SET_BOMB, PLAYER_TURN, GAME_OVER);
	signal PS, NS : state_type;
	signal bomb_pos : std_logic_vector(3 downto 0) := "0000";
	signal current_player : std_logic := '0';
	signal seed : std_logic_vector(3 downto 0) := "0001";
begin

    -- Simple pseudo-random number generator
    random_proc: process(CLK)
    begin
        if rising_edge(CLK) then
            -- Linear feedback shift register for randomness
            seed <= seed(2 downto 0) & (seed(3) xor seed(2));
        end if;
    end process;

    -- Synchronous State Update
    sync_proc: process(CLK)
	begin
	   if rising_edge(CLK) then
	       PS <= NS;
       end if;
    end process sync_proc;

    -- State Transition and Logic Process
    comb_proc: process(PS, BTN0, SWITCHES, seed, bomb_pos)
    begin
        case PS is
            when INIT =>
                Z <= '0';  -- Blank display
                CURRENT_PLAYER <= '0';
                if BTN0 = '1' then 
                    NS <= SET_BOMB;
                else 
                    NS <= INIT;
                end if;

            when SET_BOMB =>
                -- Use the current seed value to set bomb location
                bomb_pos <= seed;
                BOMB_LOCATION <= seed;
                Z <= '0';
                NS <= PLAYER_TURN;

            when PLAYER_TURN =>
                Z <= '0';
                CURRENT_PLAYER <= current_player;
                
                -- Check if the selected switch matches bomb location
                if SWITCHES(to_integer(unsigned(bomb_pos))) = '1' then
                    NS <= GAME_OVER;
                else
                    -- Toggle player if a non-bomb switch is selected
                    current_player <= not current_player;
                    NS <= PLAYER_TURN;
                end if;

            when GAME_OVER =>
                Z <= '1';  -- Display LOSE for the current player
                if BTN0 = '1' then 
                    NS <= INIT;  -- Reset game
                else 
                    NS <= GAME_OVER;
                end if;
        end case;
    end process comb_proc;
    
end fsm;
