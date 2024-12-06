LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY ex7 IS
PORT ( D0, D1, Sel, Clock : IN  STD_LOGIC ;
Q  : OUT  STD_LOGIC ) ;
END ex7 ;
ARCHITECTURE Behavior OF ex7 IS
BEGIN
PROCESS
BEGIN
WAIT UNTIL Clock'EVENT AND Clock = '1' ;
IF Sel = '0' THEN
Q <= D0 ;
ELSE
Q <= D1 ;
END IF ;
END PROCESS ;
END Behavior ;