LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY full_add IS
PORT(
a, b, c_in : IN STD_LOGIC;
c_out, sum : OUT STD_LOGIC);
END full_add;
ARCHITECTURE adder OF full_add IS
BEGIN
c_out <= ((a xor b) and c_in) or (a and b);
sum <= (a xor b) xor c_in;
END adder; 

