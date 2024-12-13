library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_fsm is
	port ( 
        SWITCHES : in std_logic_vector(15 to 0);
	    X, CLK : in std_logic;
		Z : out std_logic
    );
end my_fsm;

architecture fsm of my_fsm is
	type state_type is (ST0, ST1);
	signal PS, NS : state_type;
begin

    -- Synchronous process to update state
    sync_proc: process(CLK)
	begin
	   if rising_edge(CLK) then
	       PS <= NS;
       end if;
    end process sync_proc;

    -- Combinational process to determine next state and output
    comb_proc: process(PS, X, SWITCHES)
    begin
        case PS is
            when ST0 =>
                Z <= '0';  -- Display "PLAY"
                if X = '1' then 
                    NS <= ST1;  -- Transition to LOSE state if selected switch is ON
                else 
                    NS <= ST0;  -- Stay in PLAY state
                end if;

            when ST1 =>
                Z <= '1';  -- Display "LOSE"
                if SWITCHES = "0000000000000000" then 
                    NS <= ST0;  -- Reset to PLAY if all switches are OFF
                else 
                    NS <= ST1;  -- Stay in LOSE state
                end if;
        end case;
    end process comb_proc;
    
end fsm;
