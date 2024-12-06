LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity lab07_3 is 
	port(en,w1,w0,w2,w3: in std_logic;
		y: out std_logic_Vector(15 downto 0));	
	end lab07_3;

architecture ex2 of lab07_3 is
	signal en1, en2, en3, en4: std_logic;

	COMPONENT lab07
		port(en,w1,w0: in std_logic;
				y0,y1,y2,y3: out std_logic);
END COMPONENT ;

begin

	stage0: lab07 port map(en,w3,w2,en1, en2, en3, en4);
	stage1: lab07 port map(en1, w0, w1, y(0), y(1), y(2), y(3));
	stage2: lab07 port map(en2, w0, w1, y(4), y(5), y(6), y(7));
	stage3: lab07 port map(en3, w0, w1, y(8), y(9), y(10), y(11));
	stage4: lab07 port map(en4, w0, w1, y(12), y(13), y(14), y(15));
end ex2;
