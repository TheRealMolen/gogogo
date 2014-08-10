library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity gogogo is
    Port ( switches : in STD_LOGIC_VECTOR( 0 downto 0 );
           LEDs : out  STD_LOGIC_VECTOR( 7 downto 0 );
			  clk : in STD_LOGIC);
end gogogo;

architecture Behavioral of gogogo is
	signal counter : UNSIGNED( 29 downto 0 ) := (others => '0');
	signal seconds : UNSIGNED( 7 downto 0 ) := (others => '0');
begin

	tick: process( clk, switches( 0 ) )
	begin
		if switches(0) = '0' then
			counter <= (others => '0');
		else
			if rising_edge(clk) then
				-- if we've hit a second, reset counter and inc seconds
				if counter = to_unsigned(32000000, counter'length) then
					seconds <= seconds + 1;
					counter <= (others => '0');
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
	
	LEDs <= std_logic_vector( seconds );
	
end Behavioral;
