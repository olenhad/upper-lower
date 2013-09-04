----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:31:52 09/04/2013 
-- Design Name: 
-- Module Name:    mux_2_1 - Behavioral 
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

entity mux_2_1 is
    Port ( I0 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           I1 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           C : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end mux_2_1;

architecture Behavioral of mux_2_1 is

begin
	O <= I0 when C = '0' else
	     I1;
end Behavioral;

