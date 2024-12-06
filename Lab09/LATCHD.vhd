LIBRARY ieee ; 
USE ieee.std_logic_1164.all ; 

ENTITY latchD IS 
PORT (  D, Clk : IN  STD_LOGIC ; 
Q  : OUT  STD_LOGIC) ; 
END latchD;
ARCHITECTURE FUNC OF latchD IS    
BEGIN
PROCESS (D, Clk ) 
BEGIN
IF Clk = '1' THEN 
Q <= D ; 
END IF ; 
END PROCESS ; 
END FUNC ; 