library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FMS is
    Port (CLK, RST : in STD_LOGIC;
          COIN_IN : in STD_LOGIC_VECTOR(1 downto 0);
          LATA : out STD_LOGIC;
          COIN_OUT : out STD_LOGIC_VECTOR(1 downto 0)
    );
end FMS;

architecture Behavioral of FMS is
    type state_type is (S0, S1, S2, S3, S4, S5); signal CS, NS : state_type;
    signal CUENTA : integer := 3;
    signal EMPTY :  STD_LOGIC;
begin
    process (CLK) begin
        if(rising_edge(CLK)) then
            if(RST = '1') then
                CS <= S0;
            else
                CS <= NS;
            end if;
        end if;
    end process;

    process (CS, COIN_IN) begin
        case CS is
            when S0 =>        
                if(COIN_IN = "00") then
                    COIN_OUT <= "00"; LATA <= '0'; NS <= S0;
                elsif(COIN_IN = "01") then
                    COIN_OUT <= "00"; LATA <= '0'; NS <= S1;
                elsif(COIN_IN = "10") then
                    COIN_OUT <= "00"; LATA <= '1'; NS <= S2; CUENTA <= CUENTA -1;
                elsif(COIN_IN = "11") then
                    COIN_OUT <= "10"; LATA <= '1'; NS <= S3; CUENTA <= CUENTA -1;
                end if;  
            when S1 =>           
                if(COIN_IN = "00") then
                    COIN_OUT <= "00"; LATA <= '0'; NS <= S1;
                elsif(COIN_IN = "01") then
                    COIN_OUT <= "00"; LATA <= '1'; NS <= S2; CUENTA <= CUENTA -1;
                elsif(COIN_IN = "10") then
                    COIN_OUT <= "01"; LATA <= '1'; NS <= S4; CUENTA <= CUENTA -1;
                elsif(COIN_IN = "11") then
                    COIN_OUT <= "11"; LATA <= '1'; NS <= S5; CUENTA <= CUENTA -1;
                end if;
            when S2 =>
                NS <= S0;
            when S3 =>
                NS <= S0;
            when S4 => 
                NS <= S0;
            when S5 =>
                NS <= S0;
            when others =>
                COIN_OUT <= "00"; LATA <= '0'; NS <= S0;
        end case;
    end process;
    
    process (CUENTA) begin
        if(CUENTA < 1) then
            EMPTY <= '1';
        end if;
    end process;
end Behavioral;
