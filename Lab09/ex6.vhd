LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY ex6 IS
PORT (  D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) ;
Resetn, Clock : IN  STD_LOGIC ;
Q  : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
END ex6 ;
ARCHITECTURE Behavior OF ex6 IS
BEGIN
PROCESS ( Resetn, Clock )
BEGIN
IF Resetn = '0' THEN
Q <= "00000000" ;
ELSIF Clock'EVENT AND Clock = '1' THEN
Q <= D ;
END IF ;
END PROCESS ;
END Behavior ;