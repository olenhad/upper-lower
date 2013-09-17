----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:08:54 09/04/2013 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
port (CLK : in std_logic;
		CONTROL : in  STD_LOGIC_VECTOR(1 downto 0);
		DATA : out std_logic_vector(7 downto 0));
end ROM;



architecture Behavioral of ROM is
	type rom_type is array (0 to 31) of std_logic_vector(7 downto 0);
-- data contains "Hello World. Hardware rocks alot"	
	signal rom_data : rom_type := (X"48",X"65",X"6C",X"6C",X"6F",
											 X"20",X"57",X"6f",X"6F",X"72",
											 X"6C",X"64",X"2E",X"20",X"48",
											 X"61",X"72",X"64",X"77",X"61",
											 X"72",X"65",X"20",X"72",X"6F",
											 X"63",X"6B",X"73",X"20",X"61",
											 X"6C",X"6F");
	signal data_sig : std_logic_vector(7 downto 0);

begin

	process(CLK)
	variable current_value : std_logic_vector(7 downto 0) := x"00";
	variable current_address : std_logic_vector(4 downto 0) := b"00000";
	begin
		if (CLK'event and CLK='1') then
			if (CONTROL = b"01") then
				current_address := std_logic_vector(unsigned(current_address) + 1);
			elsif (CONTROL = b"11") then
				current_address := b"00000";
			end if;
			current_value := rom_data(conv_integer(current_address));
		end if;
		DATA <= current_value;
	end process;
end Behavioral;

