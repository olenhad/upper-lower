----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:50:25 09/04/2013 
-- Design Name: 
-- Module Name:    STATE_MACHINE - Behavioral 
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

entity STATE_MACHINE is
    Port ( OP : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           RESET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CMPR_RESULT : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           COUNTER_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0);
           ADDSUB_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0));
end STATE_MACHINE;

architecture Behavioral of STATE_MACHINE is
type SM_STATE is (CONTROL_COUNTER, CONTROL_ADDSUB);
begin
	process(CLK)
	variable control_state : SM_STATE := control_counter;
	begin
		if rising_edge(CLK) then
		-- Counter control
			if (control_state = control_counter) then
				if (RESET = '1') then
					COUNTER_CONTROL <= b"11";
					control_state := control_addsub;
				else 
					if (OP = b"01" or OP = b"10") then
						COUNTER_CONTROL <= b"01";
						control_state := control_addsub;
					else
						COUNTER_CONTROL <= b"00";
					end if;
				end if;
		-- addsub control
			elsif (control_state = control_addsub) then
				if (CMPR_RESULT = b"00") then
					ADDSUB_CONTROL <= b"00";
				-- if lower case letter
				elsif (CMPR_RESULT = b"01") then
				-- if converting to upper case
					if (OP = b"10") then
						ADDSUB_CONTROL <= b"10";
				-- else nop
					else
						ADDSUB_CONTROL <= b"00";
					end if;
				-- if upper case letter
				elsif (CMPR_RESULT = b"10") then
					if (OP = b"01") then
						ADDSUB_CONTROL <= b"01";
					else
						ADDSUB_CONTROL <= b"00";
					end if;
				end if;
				
			end if;
		end if;
	end process;

end Behavioral;

