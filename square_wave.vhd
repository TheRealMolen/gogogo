library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity square_wave is
	Port ( clk : in  STD_LOGIC;
			 divisor : in UNSIGNED( 18 downto 0);
          sig : out  SIGNED (7 downto 0));
end square_wave;


architecture Behavioral of square_wave is
	signal counter : UNSIGNED(16 downto 0) := (others => '0');
	signal source : SIGNED( 7 downto 0 ) := (others => '0');
	
begin

	sig <= source;
	
	tick: process( clk )
	begin
		if rising_edge( clk ) then
			counter <= counter + 1;
		
			-- generate signal
			if counter = divisor then
				source <= not source;
				counter <= (others => '0');
			end if;
			
		end if;
	end process;

end Behavioral;

