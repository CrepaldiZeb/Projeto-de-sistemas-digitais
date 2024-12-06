library ieee;
use ieee.std_logic_1164.all;
entity q1 is
port(s1,s0: in std_logic;
		x1,x2,x3,x4: out std_logic);
	end q1;
architecture func of q1 is 
begin
x1<=(not s1 and not s0);
x2<=(not s1 and s0);
x3<=(s1 and not s0);
x4<=(s1 and s0);

end func;