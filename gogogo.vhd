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
	
	
	function  divide  (a : UNSIGNED; b : UNSIGNED) return UNSIGNED is
		variable a1 : unsigned(a'length-1 downto 0):=a;
		variable b1 : unsigned(b'length-1 downto 0):=b;
		variable p1 : unsigned(b'length downto 0):= (others => '0');
		variable i : integer:=0;

	begin
		for i in 0 to b'length-1 loop
			p1(b'length-1 downto 1) := p1(b'length-2 downto 0);
			p1(0) := a1(a'length-1);
			a1(a'length-1 downto 1) := a1(a'length-2 downto 0);
			p1 := p1-b1;
			if(p1(b'length-1) ='1') then
				a1(0) :='0';
				p1 := p1+b1;
			else
				a1(0) :='1';
			end if;
		end loop;
		
		return a1;
	end divide;

	signal counter : UNSIGNED( 21 downto 0 ) := (others => '0');
	signal digit0 : UNSIGNED( 3 downto 0 ) := (others => '0');
	signal digit1 : UNSIGNED( 3 downto 0 ) := (others => '0');
	signal digit2 : UNSIGNED( 3 downto 0 ) := (others => '0');
	signal digit3 : UNSIGNED( 3 downto 0 ) := (others => '0');
begin

	tick: process( clk )
	begin
		if rising_edge(clk) then			
			counter <= counter + 1;
			
			-- has counter hit max?
			if counter(21) = '1' then
				digit0 <= digit0 + 1;
				counter <= (others => '0');
				
				-- trickle all the way down....
				-- WHY 9 AND NOT 10? the comparison must happen before the increment, but aren't processes sequential?
				if digit0 = to_unsigned(9,4) then
					digit0 <= (others => '0');
					digit1 <= digit1 + 1;
					
					if digit1 = to_unsigned(9,4) then
						digit1 <= (others => '0');
						digit2 <= digit2 + 1;
						
						if digit2 = to_unsigned(9,4) then
							digit2 <= (others => '0');
							digit3 <= digit3 + 1;
							
							if digit3 = to_unsigned(9,4) then
								digit3 <= (others => '0');
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Inst_sevenseg: sevenseg PORT MAP(
		clk => clk,
		digit0 => digit0,
		digit1 => digit1,
		digit2 => digit2,
		digit3 => digit3,
		digit_sel => digits,
		segments => segments
	);

	
	dp <= '1';
	
end Behavioral;
