--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:05:59 09/04/2013
-- Design Name:   
-- Module Name:   C:/Users/pc richard/Documents/CG3207/lab1/test_lab.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_lab IS
END test_lab;
 
ARCHITECTURE behavior OF test_lab IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         OP : IN  std_logic_vector(1 downto 0);
			MSB : in std_logic;
         CLK : IN  std_logic;
         RESET : IN  std_logic;
			DEBUG : out STD_LOGIC_VECTOR(7 downto 0);
			Drom : out std_logic_vector(7 downto 0);
			daddr: out std_logic_vector(4 downto 0);
			dcmpr: out std_logic_vector(1 downto 0);
         RESULT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
	 

   --Inputs
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
	signal msb : std_logic := '0';
	
 	--Outputs
   signal RESULT : std_logic_vector(3 downto 0);
	signal DEBUG : std_logic_vector(7 downto 0);
	signal drom : std_logic_vector(7 downto 0);
	signal daddr : std_logic_vector(4 downto 0);
	signal dcmpr : std_logic_vector(1 downto 0);
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
			 MSB => MSB,
          OP => OP,
          CLK => CLK,
          RESET => RESET,
			 DEBUG => DEBUG,
			 drom => drom,
			 daddr => daddr,
			 dcmpr => dcmpr,
          RESULT => RESULT
        );
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here
		OP <= "00";
		
		wait for CLK_period;	
		MSB <= '0';
		
		wait for CLK_period;	
		OP <= "01";
		MSB <= '0';
		
		wait for CLK_period;
		OP <= "01";
		MSB <= '0';
		
		wait for CLK_period;
		OP <= "01";
		MSB <= '0';
		
		
		wait for CLK_period;
		OP <= "01";
		MSB <= '0';
		
		wait for CLK_period;
		OP <= "00";
		MSB <= '0';
		
		wait for CLK_period;
		OP <= "00";
		MSB <= '0';
		
		wait for CLK_period;
		OP <= "01";
		MSB <= '0';
		
		wait for CLK_period*5;
		OP <= "00";
		MSB <= '0';
		wait for CLK_period*3;
		
		OP <= "01";
		wait for CLK_period*2;
		
		RESET <= '1';
		wait for CLK_period*2;
		
		RESET <= '0';
		OP <= "00";
		wait for CLK_period*5;
		
		OP <= "10";
		wait for CLK_period*2;
		
		OP <= "00";
		wait for CLK_period*3;
		
		OP <= "10";
		wait for CLK_period*2;
		
		OP <= "00";
      wait;
   end process;

END;
