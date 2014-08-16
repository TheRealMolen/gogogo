library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity gogogo is
    Port ( LEDs : out STD_LOGIC_VECTOR( 7 downto 0 );
			  clk : in STD_LOGIC);
end gogogo;


architecture Behavioral of gogogo is
	COMPONENT counter30
	  PORT (
		 clk : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
	  );
	END COMPONENT;
	COMPONENT memory
	  PORT (
		 clka : IN STD_LOGIC;
		 ena : IN STD_LOGIC;
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	attribute box_type : string;
	attribute box_type of counter30 : component is "black_box";
	attribute box_type of memory : component is "black_box";
	
	signal count: STD_LOGIC_VECTOR(29 downto 0);
	signal addr : STD_LOGIC_VECTOR(9 downto 0);
	
begin

	addr <= "0000" & count(25 downto 20);

	addr_counter : counter30
		PORT MAP (
			clk => clk,
			q => count
		);
	rom : memory
		PORT MAP (
			clka => clk,
			ena => '1',
			addra => addr,
			douta => LEDs
		);
	
end Behavioral;
