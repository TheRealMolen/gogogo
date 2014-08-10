library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity gogogo is
    Port ( switches : in STD_LOGIC_VECTOR( 7 downto 0 );
           LEDs : out  STD_LOGIC_VECTOR( 7 downto 0 );
			  clk : in STD_LOGIC);
end gogogo;

architecture Behavioral of gogogo is
	signal counter : UNSIGNED( 29 downto 0 ) := (others => '0');
begin

	tick: process( clk )
	begin
		if rising_edge(clk) then
			counter <= counter + 1;
		end if;
	end process;
	
	LEDs <= std_logic_vector( counter(29 downto 22) );
	
end Behavioral;

--
--architecture Behavioral of gogogo is
--  signal x      : UNSIGNED(3 downto 0);
--  signal y      : UNSIGNED(3 downto 0);
--  signal result : UNSIGNED(4 downto 0);
--begin
--
--	-- show 5 bit result on LEDs
--	LEDs <= "000" & std_logic_vector(result);
--
--	-- read 2 4 bit numbers from switches
--	x <= unsigned( switches(3 downto 0) );
--	y <= unsigned( switches(7 downto 4) );
--	
--	result(4 downto 0) <= ('0' & x) + y;
--	
--end Behavioral;
--

