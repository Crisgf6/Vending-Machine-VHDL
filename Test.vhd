library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test is
end Test;

architecture Behavioral of Test is
    component FMS is
        Port (CLK, RST : in STD_LOGIC;
              COIN_IN : in STD_LOGIC_VECTOR(1 downto 0);
              LATA : out STD_LOGIC;
              COIN_OUT : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    signal CLK, RST, LATA : STD_LOGIC;
    signal COIN_IN, COIN_OUT : STD_LOGIC_VECTOR(1 downto 0);
begin
    DUT : FMS port map(CLK => CLK, RST => RST, COIN_IN => COIN_IN, COIN_OUT => COIN_OUT, LATA => LATA);
    
    process begin
        CLK <= '1'; wait;
    end process;
    
    process begin 
        COIN_IN <= "01"; wait for 10 ns;
        COIN_IN <= "10"; wait for 10 ns;
        COIN_IN <= "11"; wait for 10 ns;
        COIN_IN <= "10"; wait for 10 ns;
        COIN_IN <= "01"; wait;
    end process;
    
    process begin
        RST <= '1'; wait for 50 ns;
        RST <= '0'; wait for 50 ns;
    end process;
end Behavioral;
