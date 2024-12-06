LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 
ENTITY FFRS IS 
PORT (  D, Resetn, Clock  : IN  STD_LOGIC ; 
Q  : OUT  STD_LOGIC) ; 
END FFRS ;
ARCHITECTURE Behavior OF FFRS IS    
BEGIN
PROCESS
BEGIN 
WAIT UNTIL Clock'EVENT AND Clock = '1' ;
IF Resetn = '1' THEN 
Q <= '0'; 
ELSE 
Q <= D; 
END IF; 
END PROCESS;
END Behavior;