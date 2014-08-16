library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity gogogo is
    Port ( LEDs : out STD_LOGIC_VECTOR( 7 downto 0 );
		     audio : out STD_LOGIC;
			  clk : in STD_LOGIC);
end gogogo;


architecture Behavioral of gogogo is

	COMPONENT square_wave
	PORT(
		clk : IN std_logic;
		divisor : IN UNSIGNED(18 downto 0);          
		sig : OUT SIGNED(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT dac8
	  PORT(
		clk : IN std_logic;
		data : IN signed(7 downto 0);          
		pulseStream : OUT std_logic
		);
	END COMPONENT;
	
	signal mix : SIGNED(7 downto 0) := (others => '0');
	signal hist : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal counter : UNSIGNED(16 downto 0) := (others => '0');
	
	signal bus0 : SIGNED(7 downto 0);
	signal bus1 : SIGNED(7 downto 0);
	
begin

	-- HISTORY
	LEDs <= hist;
	tick: process( clk )
	begin
		if rising_edge( clk ) then
			counter <= counter + 1;
		
			-- build up tracking histogram
			if counter = to_unsigned( 20000, 17 ) then
				counter <= (others => '0');
				hist(7 downto 1) <= hist(6 downto 0);
				hist(0) <= mix(7);
			end if;
		end if;
	end process;
	
	
	sq0: square_wave PORT MAP(
		clk => clk,
		divisor => to_unsigned( 36363, 19 ),
		sig => bus0
	);
	sq1: square_wave PORT MAP(
		clk => clk,
		divisor => to_unsigned( 30578, 19 ),
		sig => bus1
	);
	
	mix <= shift_right( bus0, 1 ) + shift_right( bus1, 1 );
		
	dac: dac8 PORT MAP(
		clk => clk,
		data => mix,
		pulseStream => audio
	);
	
end Behavioral;
