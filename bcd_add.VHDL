LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY bcd_add IS
 PORT(
 sub : IN STD_LOGIC;
 c0 : IN STD_LOGIC;
a, b : IN STD_LOGIC_VECTOR (4 downto 1);
c4 : OUT STD_LOGIC;
sum : OUT STD_LOGIC_VECTOR (4 downto 1));
END bcd_add;
ARCHITECTURE adder OF bcd_add IS
SIGNAL binary : STD_LOGIC_VECTOR (5 downto 1);
SIGNAL c4_bin : STD_LOGIC;
SIGNAL c4_bcd : STD_LOGIC;
SIGNAL sum_bin : STD_LOGIC_VECTOR (4 downto 1);
SIGNAL a_bcd : STD_LOGIC_VECTOR (4 downto 1);
SIGNAL c0_bcd : STD_LOGIC;

 COMPONENT addsub4g
PORT(
sub : IN STD_LOGIC;
c_in : IN STD_LOGIC;
a, b : IN STD_LOGIC_VECTOR (4 downto 1);
c4 : OUT STD_LOGIC;
sum : OUT STD_LOGIC_VECTOR (4 downto 1));
END COMPONENT;

BEGIN
add_bin: addsub4g
PORT MAP( sub => sub,
			c_in=> c0,
			a => a,
			b => b,
			c4 => c4_bin,
			sum => sum_bin);
converter: addsub4g
PORT MAP ( sub => c0_bcd,
			c_in => c0_bcd,
			a => a_bcd,
			b => sum_bin,
			sum => sum);

c0_bcd <= '0';
 binary <= c4_bin & sum_bin;
 PROCESS (binary)


 BEGIN
 IF (sub <= '0') THEN 
 IF (binary >= "01010" and binary <= "10011") THEN
 c4_bcd <= '1';
 a_bcd <= "0110";
 ELSE
 c4_bcd <= '0';
 a_bcd <= "0000";
 END IF;
ELSE 
 c4_bcd <= '0';
 a_bcd <= "0000";
 END IF;

 
 END PROCESS;
 c4 <= c4_bcd;
END adder;