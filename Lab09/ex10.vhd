LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY ex10 IS
PORT ( R  : IN  INTEGER RANGE 0 TO 15 ;
Clock, Resetn, L  : IN  STD_LOGIC ;
Q  : BUFFER  INTEGER RANGE 0 TO 15 ) ; 
END ex10 ;
ARCHITECTURE Behavior OF ex10 IS
BEGIN
PROCESS ( Clock, Resetn )
BEGIN
IF Resetn = '0' THEN
Q <= 0 ;
ELSIF (Clock'EVENT AND Clock = '1') THEN
IF L = '1' THEN
Q <= R ;
ELSE
Q <= Q + 1 ;
END IF;
END IF;
END PROCESS;
END Behavior;