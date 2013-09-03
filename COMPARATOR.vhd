----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:30:21 09/04/2013 
-- Design Name: 
-- Module Name:    COMPARATOR - Behavioral 
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


entity COMPARATOR is
    Port ( DATA : in  STD_LOGIC_VECTOR(7 downto 0);
			  CLK : in std_logic;
			  -- Result has 3 states, 00 = not a letter, 01 = lowercase letter, 10 = uppercase letter
           RESULT : out  STD_LOGIC_VECTOR(1 downto 0));
	constant CMPR_RESULT_NON_LETTER :STD_LOGIC_VECTOR(1 downto 0) := b"00";
	constant CMPR_RESULT_LOWER_LETTER :STD_LOGIC_VECTOR(1 downto 0) := b"01";
	constant CMPR_RESULT_UPPER_LETTER :STD_LOGIC_VECTOR(1 downto 0) := b"10";
end COMPARATOR;

architecture Behavioral of COMPARATOR is

begin
	process(CLK)
	begin
		if (CLK'event and CLK='1') then
			if (DATA >= X"41" and DATA <= X"5A") then
				RESULT <= CMPR_RESULT_UPPER_LETTER;
			elsif (DATA >= X"61" and DATA <= X"7A") then
				RESULT <= CMPR_RESULT_LOWER_LETTER;
			else
				RESULT <= CMPR_RESULT_NON_LETTER;
			end if;
		end if;
	end process;

end Behavioral;

