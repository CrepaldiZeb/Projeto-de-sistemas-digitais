LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY ex8 IS
PORT (  R  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0) ;
L, w, Clock  : IN  STD_LOGIC ;
Q : BUFFER  STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END ex8 ;
ARCHITECTURE Structure OF ex8 IS
COMPONENT ex7
PORT (  D0, D1, Sel, Clock : IN STD_LOGIC ;
Q  : OUT  STD_LOGIC ) ;
END COMPONENT ;
BEGIN
Stage3: ex7 PORT MAP ( w, R(3), L, Clock, Q(3) ) ;
Stage2: ex7 PORT MAP ( Q(3), R(2), L, Clock, Q(2) ) ;
Stage1: ex7 PORT MAP ( Q(2), R(1), L, Clock, Q(1) ) ;
Stage0: ex7 PORT MAP ( Q(1), R(0), L, Clock, Q(0) ) ;
END Structure ;
