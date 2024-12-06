entity ex4 is 
port(x1,x2,x3,x4 : in BIT;
f: out BIT );
end ex4;

architecture ex of ex4 is
begin 
f <= (not x1 and not x2 and not x4) or (not x1 and not x2 and x3) or (x1 and not x3 and not x4) or (x1 and x2 and x3 and x4);
end ex;