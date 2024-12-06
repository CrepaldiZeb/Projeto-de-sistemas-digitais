entity lab07 is 
port(en,w1,w0: in BIT;
y0,y1,y2,y3: out BIT );
end lab07;

architecture ex1 of lab07 is
begin 
y0<=(en AND not w1 and not w0);
y1<=(en and not w1 and w0);
y2<=(en and w1 and not w0);
y3<=(en and w1 and w0);
end ex1;
