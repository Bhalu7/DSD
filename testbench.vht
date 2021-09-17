LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
ENTITY testbench IS 
END testbench;
ARCHITECTURE Behaviour OF testbench IS
COMPONENT multi
	PORT(
		sub : IN STD_LOGIC;
		c0: IN STD_LOGIC;
		a,b,c,d : IN STD_LOGIC_VECTOR (4 downto 1);
		c4 : OUT STD_LOGIC;
		minus : OUT STD_LOGIC;
		sumR,sumL : OUT STD_LOGIC_VECTOR(4 downto 1);
		 top : OUT STD_LOGIC_VECtoR(8 DOWNTO 1);
	 bottom : OUT STD_LOGIC_VECtoR(8 DOWNTO 1);
	 answer : OUT STD_LOGIC_VECtoR(8 DOWNTO 1));
	END COMPONENT;
	SIGNAL sub : STD_LOGIC;
	SIGNAL c0 : STD_LOGIC;
	SIGNAL a : STD_LOGIC_VECTOR(4 DOWNTO 1);
	SIGNAL b : STD_LOGIC_VECTOR(4 DOWNTO 1);
	SIGNAL c : STD_LOGIC_VECTOR(4 DOWNTO 1);
	SIGNAL d : STD_LOGIC_VECTOR(4 DOWNTO 1);
	SIGNAL c4 : STD_LOGIC;
	SIGNAL minus : STD_LOGIC;
	SIGNAL sumR : STD_LOGIC_VECTOR(4 DOWNTO 1);
	SIGNAL sumL : STD_LOGIC_VECTOR(4 DOWNTO 1);
	SIGNAL  top :  STD_LOGIC_VECtoR(8 DOWNTO 1);
	SIGNAL  bottom :  STD_LOGIC_VECtoR(8 DOWNTO 1);
	SIGNAL  answer : STD_LOGIC_VECtoR(8 DOWNTO 1);
BEGIN
U1 : multi PORT MAP(sub, c0, a, b, c, d, c4, minus, sumR, sumL, top, bottom, answer);
vectors : PROCESS
BEGIN
	a<= "0111"; b <="0011"; c<="0101"; d<="0010"; sub<='1'; c0 <= '0';
	WAIT FOR 20 ns;
	a<= "0010"; b <="0100"; c<="0110"; d<="1001"; sub<='0'; c0 <= '0';
	WAIT FOR 20 ns;
	a<= "0001"; b <="0011"; c<="0101"; d<="0111"; sub<='1';c0 <= '0';
	WAIT FOR 20 ns;
	a<= "1000"; b <="1000"; c<="1000"; d<="1000"; sub<='0';c0 <= '0';
	WAIT FOR 20 ns;
	a<= "1001"; b <="1001"; c<="1001"; d<="1001"; sub<='1';c0 <= '0';
	WAIT FOR 20 ns;
	a<= "0110"; b <="0110"; c<="0110"; d<="0110"; sub<='0';c0 <= '0';
	WAIT FOR 20 ns;
	a<= "0000"; b <="1001"; c<="0000"; d<="1001"; sub<='1';c0 <= '0';
	WAIT;
END PROCESS;
END;
	
	