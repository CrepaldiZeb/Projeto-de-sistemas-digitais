LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 

ENTITY FFRA IS 
PORT (  D, Resetn, Clock  : IN  STD_LOGIC ; 
Q  : OUT  STD_LOGIC) ; 
END FFRA ;
ARCHITECTURE Behavior OF FFRA IS    
BEGIN
PROCESS ( Resetn, Clock ) 
BEGIN 
IF Resetn = '1' THEN 
Q <= '0' ; 
ELSIF Clock'EVENT AND Clock = '1' THEN 
Q <= D ; 
END IF ; 
END PROCESS ;
END Behavior ;