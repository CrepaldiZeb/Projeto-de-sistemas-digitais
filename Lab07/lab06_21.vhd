LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity lab07_2 is 
	port(en,w1,w0,w2: in std_logic;
		y: out std_logic_Vector(7 downto 0));	
	end lab07_2;

architecture ex2 of lab07_2 is
	signal en1, en2: std_logic;

	COMPONENT lab07
		port(en,w1,w0: in std_logic;
				y0,y1,y2,y3: out std_logic);
END COMPONENT ;

begin

	en1 <= (not w2 and en); 
	en2 <= (en and w2);
	stage0: lab07 port map(en1,w1,w0,y(0),y(1),y(2),y(3));
	stage1: lab07 port map(en2,w1,w0,y(4),y(5),y(6),y(7));
	
end ex2;
