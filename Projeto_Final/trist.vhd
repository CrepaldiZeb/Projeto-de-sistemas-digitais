-- Antonio Crepaldi 21012485
-- Carlos Eduardo 21003900
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trist is
    Port ( x    : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           e   : in  STD_LOGIC;                                        
           y    : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end trist;

architecture func of trist is

begin 

    y <= x when (e = '1') else "ZZZZZZZZ";               

end func;