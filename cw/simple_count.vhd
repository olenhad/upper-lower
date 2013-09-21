----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:16:19 05/25/2008 
-- Design Name: 
-- Module Name:    simple_count - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_count is
    Port ( clock : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  dir : in STD_LOGIC;
			  reset: in STD_LOGIC;
			  speed: in STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (3 downto 0));
end simple_count;

architecture Behavioral of simple_count is

signal count: std_logic_vector (25 downto 0) := "00000000000000000000000000";

begin
process (clock, reset) 
	variable dir_latch : integer := 1;
	variable speed_control : integer := 1;
begin
   if clock='1' and clock'event then
      if enable='0' then
         count <= count + (dir_latch*speed_control);
      end if;
		if dir='1' then
			dir_latch := -1*dir_latch;
		end if;
		if speed = '1' then
			if speed_control < 4 then
				speed_control := speed_control + 1;
			else 
				speed_control := 1;
			end if;
		end if;
   end if;

	if reset='1' then
		if dir_latch = 1 then
			count <= "00000000000000000000000000";
		else
			count <= "11110000000000000000000000";
		end if;
	end if;
end process;
 
leds <= count(25 downto 22);
						
end Behavioral;

