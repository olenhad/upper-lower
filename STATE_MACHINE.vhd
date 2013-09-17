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
use ieee.std_logic_misc.all;

entity STATE_MACHINE is
    Port ( OP : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           RESET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CMPR_RESULT : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           COUNTER_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0);
           ADDSUB_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0));
	constant CMPR_RESULT_NON_LETTER :STD_LOGIC_VECTOR(1 downto 0) := b"00";
	constant CMPR_RESULT_LOWER_LETTER :STD_LOGIC_VECTOR(1 downto 0) := b"01";
	constant CMPR_RESULT_UPPER_LETTER :STD_LOGIC_VECTOR(1 downto 0) := b"10";
end STATE_MACHINE;

architecture Behavioral of STATE_MACHINE is
type SM_STATE is (NOP,CONTROL_COUNTER, CONTROL_ADDSUB);
begin
	process(CLK)
	variable control_state : SM_STATE := control_counter;
	variable is_op_active : std_logic := '0';
	variable op_latch : std_logic_vector(1 downto 0) := b"00";
	begin
		if rising_edge(CLK) then
		
			is_op_active := or_reduce(OP xor op_latch);
			if(is_op_active = '1') then
				op_latch := OP;
			end if;
			if (OP = b"00") then
				COUNTER_CONTROL <= b"00";
			elsif ((OP = "01" or OP = "10") and is_op_active = '1') then
				COUNTER_CONTROL <= b"01";
			else 
				COUNTER_CONTROL <= b"00";
			end if;
			if((OP = "01" or OP = "10") and is_op_active = '1') then
				if (CMPR_RESULT = b"10" and OP = b"01") then
				-- to lowercase
					ADDSUB_CONTROL <= b"01";
				elsif (CMPR_RESULT = b"01" and OP = b"10") then
				-- to uppercase
					ADDSUB_CONTROL <= b"11";
				else
					ADDSUB_CONTROL <= b"00";
				end if;
			end if;

		end if;
	end process;

end Behavioral;

