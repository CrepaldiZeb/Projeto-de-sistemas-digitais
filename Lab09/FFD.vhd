LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 

ENTITY ffd IS 
PORT (  D, Clock : IN STD_LOGIC ; 
Q : OUT STD_LOGIC) ; 
END ffd ;
ARCHITECTURE func OF ffd IS    
BEGIN
PROCESS (Clock ) 
BEGIN 
IF Clock'EVENT AND Clock = '1' THEN 
Q <= D ; 
END IF ; 
END PROCESS ; 
END func ;