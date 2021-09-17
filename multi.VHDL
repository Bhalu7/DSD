LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY multi IS
PORT(
		sub: IN STD_LOGIC;
		c0: IN STD_LOGIC;
		c4:OUT STD_LOGIC;
		a,b,c,d : IN STD_LOGIC_VECTOR (4 downto 1);
		minus : OUT STD_LOGIC;
		sumR, sumL : Buffer STD_LOGIC_VECTOR(4 downto 1);
		top : OUT STD_LOGIC_VECtoR(8 DOWNTO 1);
		bottom : OUT STD_LOGIC_VECtoR(8 DOWNTO 1);
		answer : OUT STD_LOGIC_VECtoR(8 DOWNTO 1));
END multi;
architecture multiAdder of multi is
		SIGNAL c_pass : STD_LOGIC;
		SIGNAL cfinal : STD_LOGIC;
COMPONENT bcd_add
PORT(
		sub : IN STD_LOGIC;
		c0 : IN STD_LOGIC;
		a, b : IN STD_LOGIC_VECTOR (4 downto 1);
		c4 : OUT STD_LOGIC;
		sum : OUT STD_LOGIC_VECTOR (4 downto 1));
END COMPONENT;
BEGIN
	add_right:bcd_add
	PORT MAP(
				sub => sub,
				c0 =>c0,
				a => a,
				b => b,
				c4 => c_pass,
				sum => sumR);
	add_left:bcd_add
	PORT MAP(
				sub => sub,
				c0 => c_pass,
				a => c,
				b => d,
				c4 => cfinal,
				sum => sumL);
c4 <= cfinal;
PROCESS (a,b,c,d)
BEGIN
	IF (sub = '1') AND(c+a < d+b) THEN
		minus <= '1';
	ELSE
		minus <= '0';
	END IF;
END PROCESS;
top <= c&"0000" + a;
bottom <= d&"0000"+ b;
answer <= sumL & "0000"+ sumR;
end multiAdder;


