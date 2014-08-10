library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gogogo is
    Port ( --switches : in STD_LOGIC_VECTOR( 7 downto 0 );
           digits : out  STD_LOGIC_VECTOR( 3 downto 0 );
			  segments : out  STD_LOGIC_VECTOR( 6 downto 0 );
			  dp : out STD_LOGIC;
			  clk : in STD_LOGIC);
end gogogo;


architecture Behavioral of gogogo is
	COMPONENT sevenseg
	PORT(
		clk : IN std_logic;
		digit0 : IN unsigned(3 downto 0);
		digit1 : IN unsigned(3 downto 0);
		digit2 : IN unsigned(3 downto 0);
		digit3 : IN unsigned(3 downto 0);          
		digit_sel : OUT std_logic_vector(3 downto 0);
		segments : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	signal counter : UNSIGNED( 33 downto 0 ) := (others => '0');
begin

	tick: process( clk )
	begin
		if rising_edge(clk) then			
			counter <= counter + 1;
		end if;
	end process;
	
	
	Inst_sevenseg: sevenseg PORT MAP(
		clk => clk,
		digit0 => counter(21 downto 18),
		digit1 => counter(25 downto 22),
		digit2 => counter(29 downto 26),
		digit3 => counter(33 downto 30),
		digit_sel => digits,
		segments => segments
	);

	
	dp <= '1';
	
end Behavioral;
