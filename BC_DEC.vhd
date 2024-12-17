library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BC_DEC is
    Port (    
        CLK, Z : in std_logic;
        START : in std_logic; 
        DISP_EN : out std_logic_vector(7 downto 0);  
        SEGMENTS : out std_logic_vector(7 downto 0)
    );
end BC_DEC;

architecture BC_DEC of BC_DEC is
    component clk_div
        Port (  
            clk : in std_logic;
            sclk : out std_logic
        );
    end component;
   
    signal cnt_dig : std_logic_vector(1 downto 0) := "00"; 
    signal digit : std_logic_vector(3 downto 0) := "0000"; 
    signal sclk : std_logic; 

begin
    my_clk: clk_div 
    port map (
        clk => clk,
        sclk => sclk 
    ); 

    process (SCLK)
    begin
        if (rising_edge(SCLK)) then 
            cnt_dig <= cnt_dig + 1; 
        end if; 
    end process; 

    SEGMENTS <= "11111111" when START = '1' else  -- Blank
                "11100011" when digit = "0000" and Z = '1' else  -- L
                "00000011" when digit = "0001" and Z = '1' else  -- O
                "01001001" when digit = "0010" and Z = '1' else  -- S
                "01100001" when digit = "0011" and Z = '1' else  -- E
                "00110000" when digit = "0100" and Z = '0' else  -- P
                "11100011" when digit = "0101" and Z = '0' else  -- L
                "00010001" when digit = "0110" and Z = '0' else  -- A
                "10001001" when digit = "0111" and Z = '0' else  -- Y
                "11111111";                                      

    DISP_EN <= "11111110" when cnt_dig = "00" else 
               "11111101" when cnt_dig = "01" else
               "11111011" when cnt_dig = "10" else
               "11110111" when cnt_dig = "11" else
               "11111111"; 
 
    process (cnt_dig, Z, START)
    begin
        if (START = '1') then
            digit <= "1111";  -- Blank digit during startup
        elsif (Z = '1') then
            case cnt_dig is
                when "00" => digit <= "0011";  -- E
                when "01" => digit <= "0010";  -- S
                when "10" => digit <= "0001";  -- O
                when "11" => digit <= "0000";  -- L
                when others => digit <= "1111"; 
            end case; 
        else
            case cnt_dig is 
                when "00" => digit <= "0111";  -- Y
                when "01" => digit <= "0110";  -- A
                when "10" => digit <= "0101";  -- L
                when "11" => digit <= "0100";  -- P
                when others => digit <= "1111";
            end case;
        end if;
    end process;
         
end BC_DEC;
