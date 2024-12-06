library ieee;
use ieee.std_logic_1164.all;
entity q2 is
port(s3,s2,s1,s0: in std_logic;
		x: out std_logic_vector(15 downto 0);
	end q2;
architecture func of q1 is
 component q1 is 
 port 
	(		s0,s1: in std_logic;
		x1,x2,x3,x4 : out std_logic);
		end component;
 port
begin
stage0: q1 port map(); 

end func;