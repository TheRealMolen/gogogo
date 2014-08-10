----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:58 08/10/2014 
-- Design Name: 
-- Module Name:    gadget_switches - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gadget_switches is
    Port ( switch0 : in  STD_LOGIC;
           switch1 : in  STD_LOGIC;
           led0 : out  STD_LOGIC;
           led1 : out  STD_LOGIC);
end gadget_switches;

architecture Behavioral of gadget_switches is

begin


end Behavioral;

