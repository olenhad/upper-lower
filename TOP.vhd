----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:27:11 09/04/2013 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
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

entity TOP is
    Port ( OP : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  MSB : in std_logic;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  DEBUG : out STD_LOGIC_VECTOR(7 downto 0);
			  DROM : out std_logic_vector(7 downto 0);
			  daddr:out std_logic_vector(4 downto 0);
           RESULT : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end TOP;

architecture Behavioral of TOP is
component state_machine is
		Port ( OP : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           RESET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           CMPR_RESULT : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
           COUNTER_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0);
           ADDSUB_CONTROL : out  STD_LOGIC_VECTOR(1 DOWNTO 0));
end component;

component ROM is
port (CLK : in std_logic;
		ADDR: in std_logic_vector(4 downto 0);
		DATA : out std_logic_vector(7 downto 0));
end component;

component ADDSUB is
    Port ( DATA : in STD_LOGIC_VECTOR(7 downto 0);
           CONTROL : in  STD_LOGIC_VECTOR(1 downto 0);
			  CLK : in STD_LOGIC;
           RESULT : out  STD_LOGIC_VECTOR(7 downto 0));
end component;

component comparator is
    Port ( DATA : in  STD_LOGIC_VECTOR(7 downto 0);
			  CLK : in std_logic;
			  -- Result has 3 states, 00 = not a letter, 01 = lowercase letter, 10 = uppercase letter
           RESULT : out  STD_LOGIC_VECTOR(1 downto 0));
end component;

component counter is
    Port ( CONTROL : in  STD_LOGIC_VECTOR(1 downto 0);
           CLK : in  STD_LOGIC;
           COUNT : out  STD_LOGIC_VECTOR(4 downto 0));
end component;
component mux_2_1 is
    Port ( I0 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           I1 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           C : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;

signal counter_control : STD_LOGIC_VECTOR(1 downto 0);
signal compare_result : STD_LOGIC_VECTOR(1 downto 0);
signal addsub_control : STD_LOGIC_VECTOR(1 downto 0);
signal counter_result : std_logic_vector(4 downto 0);
signal rom_data : std_logic_vector(7 downto 0);
signal addsub_output :std_logic_vector(7 downto 0);
begin

t_sm : state_machine PORT MAP(OP,RESET,CLK, compare_result, counter_control,addsub_control);
t_counter : counter PORT MAP(counter_control, CLK, counter_result);
t_rom : ROM PORT MAP(CLK, counter_result, rom_data);
t_comparator : comparator PORT MAP(rom_data,CLK,compare_result);
t_addsub : addsub PORT MAP(rom_data, addsub_control,clk, addsub_output);
t_mux : mux_2_1 PORT MAP(addsub_output(7 downto 4),addsub_output(3 downto 0),MSB,RESULT);


DEBUG <= addsub_output;
drom <= rom_data;
daddr <= counter_result;
end Behavioral;

