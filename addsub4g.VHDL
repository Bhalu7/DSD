LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY addsub4g IS
PORT(
sub : IN STD_LOGIC;
c_in : IN STD_LOGIC;
a,b : IN STD_LOGIC_VECTOR (4 downto 1);
c4 : OUT STD_LOGIC;
sum : OUT STD_LOGIC_VECTOR (4 downto 1));
END addsub4g; 
ARCHITECTURE adder OF addsub4g IS
COMPONENT full_add
PORT(
a, b, c_in : IN STD_LOGIC;
c_out,sum : OUT STD_LOGIC);
END COMPONENT;
	SIGNAL addsub : STD_LOGIC;
	SIGNAL c : STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL b_comp : STD_LOGIC_VECTOR (4 downto 1);
	SIGNAL a_comp : STD_LOGIC_VECTOR (4 downto 1);
	SIGNAL comp : STD_LOGIC_VECTOR(4 downto 1);
	BEGIN
addsub <=  sub ;
c(0) <= sub XOR c_in;
PROCESS(a,b)
BEGIN
IF (sub <= '1') then
	
	if (a < b) then
	a_comp <= b;
	b_comp <= a;
	else
	a_comp <= a;
	b_comp <= b;
	end if;
END IF;
END PROCESS;
adders:
FOR i IN 1 to 4 GENERATE
comp(i) <= (b_comp(i) xor addsub);
adder: full_add PORT MAP (a_comp(i), comp(i), c(i -1), c(i), sum (i));
END GENERATE;
C4 <= c(4);
END adder; 
