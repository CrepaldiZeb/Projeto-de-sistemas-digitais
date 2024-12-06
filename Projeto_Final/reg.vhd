-- Antonio Crepaldi 21012485
-- Carlos Eduardo 21003900
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY reg IS
PORT (  D : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) ;
enable, clk : IN  STD_LOGIC ;
Q  : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
END reg ;
ARCHITECTURE Behavior OF reg IS
BEGIN
PROCESS (enable, clk)
BEGIN
	IF (clk'EVENT AND clk = '1' AND enable ='1') THEN
	Q <= D ;
	else 
END if ;
END PROCESS ;
END Behavior ;
