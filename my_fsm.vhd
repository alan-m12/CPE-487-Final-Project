library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity my_fsm is
    port ( 
        SWITCHES : in std_logic_vector(15 downto 0);
        BTN0, BTNU : in std_logic;
        CLK : in std_logic;
        Z : out std_logic;
        START : out std_logic;
        BOMB_LOCATION : out std_logic_vector(3 downto 0);
        CURRENT_PLAYER : out std_logic;
        LED_STATE : out std_logic_vector(1 downto 0)
    );
end my_fsm;

architecture Behavioral of my_fsm is
    type state_type is (START_STATE, INIT, SET_BOMB, PLAYER_TURN, GAME_OVER, WAIT_RESET,
                       INIT_MULTI, SET_BOMBS, PLAYER_TURN_MULTI);
    signal PS, NS : state_type := START_STATE;
    signal bomb_pos1, bomb_pos2, bomb_pos3 : std_logic_vector(3 downto 0) := (others => '0');
    signal curr_player : std_logic := '0';
    signal bomb_seed : std_logic_vector(5 downto 0) := "000001";
    signal player1_bombs, player2_bombs : integer range 0 to 3 := 0;
    signal last_switches : std_logic_vector(15 downto 0) := (others => '0');
    signal led_control : std_logic_vector(1 downto 0) := "00";
    signal slow_clock : std_logic := '0';
    signal clock_counter : integer range 0 to 50000000 := 0;
    signal game_over_trigger : std_logic := '0';

begin
    -- Clock divider for LED blinking
    process(CLK)
    begin
        if rising_edge(CLK) then
            if clock_counter = 50000000 then
                slow_clock <= not slow_clock;
                clock_counter <= 0;
            else
                clock_counter <= clock_counter + 1;
            end if;
        end if;
    end process;

    -- 6-bit LFSR for random bomb placement
    random_proc: process(CLK)
    begin
        if rising_edge(CLK) then
            bomb_seed <= bomb_seed(4 downto 0) & (bomb_seed(5) xor bomb_seed(4));
        end if;
    end process;

    -- Main game logic process
    process(CLK)
    begin
        if rising_edge(CLK) then
            PS <= NS;
            game_over_trigger <= '0';  -- Reset trigger by default
            
            -- Reset game state
            if PS = INIT or PS = INIT_MULTI then
                player1_bombs <= 0;
                player2_bombs <= 0;
                curr_player <= '0';
                last_switches <= (others => '0');
                led_control <= "00";
            end if;
            
            -- Set bomb positions ensuring they are different
            if PS = SET_BOMBS then
                bomb_pos1 <= bomb_seed(3 downto 0);
                bomb_pos2 <= not bomb_seed(3 downto 0);
                bomb_pos3 <= bomb_seed(5 downto 2);
            elsif PS = SET_BOMB then
                bomb_pos1 <= bomb_seed(3 downto 0);
            end if;

            -- Handle switch flips and bomb detection
            if SWITCHES /= last_switches then
                if PS = PLAYER_TURN_MULTI then
                    -- Check for new switch flips that hit bombs
                    if (SWITCHES(to_integer(unsigned(bomb_pos1))) = '1' and last_switches(to_integer(unsigned(bomb_pos1))) = '0') or
                       (SWITCHES(to_integer(unsigned(bomb_pos2))) = '1' and last_switches(to_integer(unsigned(bomb_pos2))) = '0') or
                       (SWITCHES(to_integer(unsigned(bomb_pos3))) = '1' and last_switches(to_integer(unsigned(bomb_pos3))) = '0') then
                        -- Bomb hit
                        led_control <= "10";  -- Red LED
                        if curr_player = '0' then
                            player1_bombs <= player1_bombs + 1;
                            if player1_bombs = 1 then  -- This will be the second hit
                                game_over_trigger <= '1';
                            end if;
                        else
                            player2_bombs <= player2_bombs + 1;
                            if player2_bombs = 1 then  -- This will be the second hit
                                game_over_trigger <= '1';
                            end if;
                        end if;
                    else
                        -- Safe switch
                        led_control <= "01";  -- Green LED
                    end if;
                    -- Always switch players after any switch flip
                    curr_player <= not curr_player;
                elsif PS = PLAYER_TURN then
                    -- Single bomb mode logic
                    if SWITCHES(to_integer(unsigned(bomb_pos1))) = '1' then
                        led_control <= "10";  -- Red LED
                    else
                        led_control <= "01";  -- Green LED
                    end if;
                end if;
                last_switches <= SWITCHES;
            end if;

            -- Game over LED flashing
            if PS = GAME_OVER then
                if slow_clock = '1' then
                    led_control <= "10";  -- Flash red
                else
                    led_control <= "00";  -- Off
                end if;
            end if;
        end if;
    end process;

    -- LED output
    LED_STATE <= led_control;

    -- State transition process
    process(PS, BTN0, BTNU, SWITCHES, bomb_pos1, curr_player, game_over_trigger)
    begin
        -- Default assignments
        Z <= '0';
        START <= '0';
        NS <= PS;
        CURRENT_PLAYER <= curr_player;
        BOMB_LOCATION <= bomb_pos1;

        case PS is
            when START_STATE =>
                START <= '1';
                if BTN0 = '1' then
                    NS <= INIT;
                elsif BTNU = '1' then
                    NS <= INIT_MULTI;
                end if;

            when INIT =>
                if BTN0 = '1' then
                    NS <= SET_BOMB;
                end if;

            when INIT_MULTI =>
                if BTNU = '1' then
                    NS <= SET_BOMBS;
                end if;

            when SET_BOMB =>
                NS <= PLAYER_TURN;

            when SET_BOMBS =>
                NS <= PLAYER_TURN_MULTI;

            when PLAYER_TURN =>
                if SWITCHES(to_integer(unsigned(bomb_pos1))) = '1' then
                    NS <= GAME_OVER;
                end if;

            when PLAYER_TURN_MULTI =>
                if game_over_trigger = '1' then
                    NS <= GAME_OVER;
                end if;

            when GAME_OVER =>
                Z <= '1';
                if BTN0 = '1' or BTNU = '1' then
                    NS <= WAIT_RESET;
                end if;

            when WAIT_RESET =>
                Z <= '1';
                if SWITCHES = "0000000000000000" then
                    if BTN0 = '1' then
                        NS <= INIT;
                    elsif BTNU = '1' then
                        NS <= INIT_MULTI;
                    end if;
                end if;

            when others =>
                NS <= START_STATE;
        end case;
    end process;
end Behavioral;
