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
	signal counter : UNSIGNED( 33 downto 0 ) := (others => '0');
	signal activeDigit : UNSIGNED( 3 downto 0 ) := "0000";
begin

	tick: process( clk )
	begin
		if rising_edge(clk) then
			counter <= counter + 1;
		
			-- mux digit select
			-- bit 15 changes at 488Hz (assuming 32MHz clock)
			case counter(16 downto 15) is
				when "00" =>
					digits <= "1110";
					activeDigit <= counter(21 downto 18);
				when "01" =>
					digits <= "1101";
					activeDigit <= counter(25 downto 22);
				when "10" =>
					digits <= "1011";
					activeDigit <= counter(29 downto 26);
				when "11" =>
					digits <= "0111";
					activeDigit <= counter(33 downto 30);
					
				when others =>
					digits <= "1111";
					activeDigit <= ( others => '0' );
			end case;
			
			case activeDigit is
				when "0000" =>
					segments <= "1000000";
				when "0001" =>
					segments <= "1111001";
				when "0010" =>
					segments <= "0100100";
				when "0011" =>
					segments <= "0110000";
				when "0100" =>
					segments <= "0011001";
				when "0101" =>
					segments <= "0010010";
				when "0110" =>
					segments <= "0000010";
				when "0111" =>
					segments <= "1111000";
				when "1000" =>
					segments <= "0000000";
				when "1001" =>
					segments <= "0010000";
				when "1010" =>
					segments <= "0001000";
				when "1011" =>
					segments <= "0000011";
				when "1100" =>
					segments <= "0100111";
				when "1101" =>
					segments <= "0100001";
				when "1110" =>
					segments <= "0000110";
				when "1111" =>
					segments <= "0001110";
				
				when others =>
					segments <= (others => '0');
			end case;
			
		end if;
	end process;
	
	dp <= '1';
	
end Behavioral;
