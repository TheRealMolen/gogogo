library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity gogogo is
    Port ( LEDs : out STD_LOGIC_VECTOR( 7 downto 0 );
		     audio : out STD_LOGIC;
			  clk : in STD_LOGIC);
end gogogo;


architecture Behavioral of gogogo is
	COMPONENT dac8
	  PORT(
		clk : IN std_logic;
		data : IN unsigned(7 downto 0);          
		pulseStream : OUT std_logic
		);
	END COMPONENT;
	
	signal mix : UNSIGNED(7 downto 0) := (others => '0');
	signal hist : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal counter : UNSIGNED(16 downto 0) := (others => '0');
	
begin

	LEDs <= hist;

	tick: process( clk )
	begin
		if rising_edge( clk ) then
			counter <= counter + 1;
		
			-- generate signal
			if counter = to_unsigned( 36363, 17 ) then
				mix <= not mix;
				counter <= (others => '0');
			end if;
		
			-- build up tracking histogram (futile - needs to sync to signal to be useful)
			if counter = to_unsigned( 20000, 17 ) then
				hist(7 downto 1) <= hist(6 downto 0);
				hist(0) <= mix(7);
			end if;
		end if;
	end process;
		
	dac: dac8 PORT MAP(
		clk => clk,
		data => mix,
		pulseStream => audio
	);
	
end Behavioral;
