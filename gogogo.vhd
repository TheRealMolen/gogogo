library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity gogogo is
    Port ( switches : in STD_LOGIC_VECTOR( 1 downto 0 );
           LEDs : out  STD_LOGIC_VECTOR( 7 downto 0 );
			  clk : in STD_LOGIC);
end gogogo;

architecture Behavioral of gogogo is
	signal counter : UNSIGNED( 29 downto 0 ) := (others => '0');
begin

	tick: process( clk, switches( 1 downto 0 ) )
	begin
		if switches(0) = '0' then
			counter <= (others => '0');
		else
			if rising_edge(clk) then
				if switches(1) = '0' then
					counter <= counter - 1;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
	
	LEDs <= std_logic_vector( counter(29 downto 22) );
	
end Behavioral;
