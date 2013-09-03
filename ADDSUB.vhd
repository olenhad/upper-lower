----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:34:39 09/04/2013 
-- Design Name: 
-- Module Name:    ADDSUB - Behavioral 
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

entity ADDSUB is
    Port ( DATA : in STD_LOGIC_VECTOR(7 downto 0);
           CONTROL : in  STD_LOGIC_VECTOR(1 downto 0);
			  CLK : in STD_LOGIC;
           RESULT : out  STD_LOGIC_VECTOR(7 downto 0));
end ADDSUB;

architecture Behavioral of ADDSUB is

begin
	process(CLK)
	begin
		if (CLK'event and CLK='1') then
			if (CONTROL = b"01") then
			-- to lowercase
				RESULT <= std_logic_vector(unsigned(DATA) + X"20");
			elsif (CONTROL = b"10") then
			-- to uppercase
				RESULT <= std_logic_vector(unsigned(DATA) - X"20");
			else
				RESULT <= DATA;
			end if;
		end if;
	end process;

end Behavioral;

