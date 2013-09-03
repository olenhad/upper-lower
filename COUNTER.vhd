----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:27:08 09/04/2013 
-- Design Name: 
-- Module Name:    COUNTER - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COUNTER is
    Port ( CONTROL : in  STD_LOGIC_VECTOR(1 downto 0);
           CLK : in  STD_LOGIC;
           COUNT : out  STD_LOGIC_VECTOR(4 downto 0));
end COUNTER;

architecture Behavioral of COUNTER is

begin
	process(CLK)
	variable cur_count : std_logic_vector(4 downto 0) := b"00000";
	begin
		if rising_edge(CLK) then
			if (CONTROL = b"11") then
				cur_count := b"00000";
			elsif (CONTROL = b"01") then
				cur_count := std_logic_vector(unsigned(cur_count) + 1);
			end if;
		end if;
		COUNT <= cur_count;
	end process;

end Behavioral;

