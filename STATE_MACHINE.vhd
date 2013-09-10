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
type SM_STATE is (NOP,CONTROL_COUNTER, CONTROL_ADDSUB);
begin
	process(CLK)
	variable control_state : SM_STATE := control_counter;
	variable op_latch : std_logic_vector(1 downto 0) := b"00";
	begin
		if rising_edge(CLK) then
			OP_LATCH := OP;
			if (OP_LATCH = b"00") then
				COUNTER_CONTROL <= b"00";
				ADDSUB_CONTROL <= b"00";
				control_state := CONTROL_COUNTER;
			elsif (OP_LATCH = b"01") then
			-- OP declares to lowercase
				if (control_state = CONTROL_COUNTER) then
					COUNTER_CONTROL <= b"01";
					ADDSUB_CONTROL <= b"00";
					control_state := CONTROL_ADDSUB;
				elsif (control_state = CONTROL_ADDSUB) then
					COUNTER_CONTROL <= b"00";
					if (CMPR_RESULT = b"01") then
					-- already lowercase is NOP
						ADDSUB_CONTROL <= b"00";
					elsif (CMPR_RESULT = b"10") then
						ADDSUB_CONTROL <= b"10";
					end if;
					control_state := NOP;
				elsif (control_state = NOP) then
					COUNTER_CONTROL <= b"00";
					ADDSUB_CONTROL <= b"00";
				end if;
			
			elsif (OP_LATCH = b"10") then
			-- OP declares to uppercase
				if (control_state = CONTROL_COUNTER) then
					COUNTER_CONTROL <= b"01";
					ADDSUB_CONTROL <= b"00";
					control_state := CONTROL_ADDSUB;
				elsif (control_state = CONTROL_ADDSUB) then
					COUNTER_CONTROL <= b"00";
					if (CMPR_RESULT = b"01") then
						ADDSUB_CONTROL <= b"01";
					elsif (CMPR_RESULT = b"10") then
					-- already uppercase implies NOP
						ADDSUB_CONTROL <= b"10";
					end if;
					control_state := NOP;
				elsif (control_state = NOP) then
					COUNTER_CONTROL <= b"00";
					ADDSUB_CONTROL <= b"00";
				end if;
			end if;
		end if;
	end process;

end Behavioral;

