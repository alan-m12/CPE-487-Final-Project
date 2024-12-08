
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity my_fsm is
	port ( SWITCHES : in std_logic_vector(0 to 15);
	       X, CLK : in std_logic;
		   Z : out std_logic);
end my_fsm;

architecture fsm of my_fsm is
	type state_type is (ST0,ST1);
	signal PS,NS : state_type;
begin

sync_proc: process(CLK,NS)
	begin
	   if (rising_edge(CLK)) then
	       PS <= NS;
       end if;
    end process sync_proc;

comb_proc: process(PS,X)
begin
	case PS is
		when ST0 =>
		Z <= '0';
		if(X = '1') then NS <= ST1;
		else NS <= ST0;
		end if;

		when ST1 =>
		Z <= '1';
		if(SWITCHES /= "0000000000000000") then NS <= ST1;
		else NS <= ST0;
		end if;
    end case;
    end process comb_proc;
    
end fsm;
