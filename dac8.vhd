library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity dac8 is
	Port ( clk : in  STD_LOGIC;
          data : in  SIGNED (7 downto 0);
          pulseStream : out  STD_LOGIC);
end dac8;


architecture Behavioral of dac8 is
	signal sum : UNSIGNED (8 downto 0);
	signal shifted_data : UNSIGNED( 8 downto 0 );
	
begin

	pulseStream <= sum(8);
	
	shifted_data <= unsigned( (data(7) & data) + to_signed( 128, 9 ) );
	
   process (clk, sum)
   begin
      if rising_edge(Clk) then
         sum <= ("0" & sum(7 downto 0)) + shifted_data;
      end if;
   end process;
	
end Behavioral;