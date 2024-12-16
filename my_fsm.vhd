library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity my_fsm is
    port ( 
        SWITCHES : in std_logic_vector(15 downto 0);
        BTN0 : in std_logic;  -- Start/Reset button
        CLK : in std_logic;
        Z : out std_logic; -- Game state: 0 for active, 1 for game over
        START : out std_logic; -- New output for startup state
        BOMB_LOCATION : out std_logic_vector(3 downto 0); -- Random bomb location
        CURRENT_PLAYER : out std_logic  -- Current player indicator: 0 or 1
    );
end my_fsm;

architecture Behavioral of my_fsm is
    type state_type is (START_STATE, INIT, SET_BOMB, PLAYER_TURN, GAME_OVER, WAIT_RESET);
    signal PS, NS : state_type := START_STATE;
    signal bomb_pos : std_logic_vector(3 downto 0) := (others => '0');
    signal curr_player : std_logic := '0';
    signal seed : std_logic_vector(3 downto 0) := "0001";

begin
    -- Random Number Generator (LFSR)
    random_proc: process(CLK)
    begin
        if rising_edge(CLK) then
            seed <= seed(2 downto 0) & (seed(3) xor seed(2));
        end if;
    end process;

    -- Synchronous State Update
    process(CLK)
    begin
        if rising_edge(CLK) then
            PS <= NS;
        end if;
    end process;

    -- State Transition Logic
    process(PS, BTN0, SWITCHES, seed, bomb_pos, curr_player)
    begin
        -- Default assignments
        Z <= '0';
        START <= '0';
        CURRENT_PLAYER <= '0';

        case PS is
            when START_STATE =>
                START <= '1';  -- This will make display blank
                if BTN0 = '1' then
                    NS <= INIT;
                else
                    NS <= START_STATE;
                end if;

            when INIT =>
                Z <= '0';
                if BTN0 = '1' then
                    NS <= SET_BOMB;
                else
                    NS <= INIT;
                end if;

            when SET_BOMB =>
                bomb_pos <= seed;
                BOMB_LOCATION <= seed;
                NS <= PLAYER_TURN;

            when PLAYER_TURN =>
                CURRENT_PLAYER <= curr_player;
                if SWITCHES(to_integer(unsigned(bomb_pos))) = '1' then
                    NS <= GAME_OVER;
                else
                    curr_player <= not curr_player;
                    NS <= PLAYER_TURN;
                end if;

            when GAME_OVER =>
                Z <= '1';
                if BTN0 = '1' then
                    NS <= WAIT_RESET;
                else
                    NS <= GAME_OVER;
                end if;

            when WAIT_RESET =>
                Z <= '1';
                if SWITCHES = "0000000000000000" then
                    if BTN0 = '1' then
                        NS <= INIT;
                    else
                        NS <= WAIT_RESET;
                    end if;
                else
                    NS <= WAIT_RESET;
                end if;

            when others =>
                NS <= START_STATE;
        end case;
    end process;
end Behavioral;
