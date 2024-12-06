entity lab05 is 
port(x1, y1, x0, y0, c0 : in BIT;
s0,s1,c2 : out BIT );
end lab05;

architecture ex of lab05 is
signal c1:BIT; 
begin 
s0 <= (x0 XOR y0 XOR c0);
c1 <= ((x0 AND y0) OR (x0 AND c0) OR (y0 AND c0));
s1 <= (x1 XOR y1 XOR c1);
c2 <= ((x1 AND y1) OR (x1 AND c1) OR (y1 AND c1));
end ex;