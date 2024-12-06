-- Antonio Crepaldi 21012485
-- Carlos Eduardo 21003900
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ula IS
	PORT ( A, B				: in  	STD_LOGIC_VECTOR(7 DOWNTO 0);
	       add_sub       : in 		std_logic;
			 S					: out  	STD_LOGIC_VECTOR(7 DOWNTO 0));
END ula;

ARCHITECTURE logicfunc OF ula IS
BEGIN

		S <= A + B when add_sub = '0'
		           else A + not B + 1;
	
	
END logicfunc;
