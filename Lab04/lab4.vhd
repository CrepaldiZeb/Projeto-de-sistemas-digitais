entity lab04 is 
port(x1, x2, x3, x4 : in BIT;
f1, f2: out BIT );
end lab04;

architecture ex of lab04 is 
begin 
f1 <= (( x1 AND x3) OR (NOT x1 AND NOT x3)) AND ((x2 AND x4) OR (NOT x2 AND NOT x4));
f2 <= (x1 AND x2 AND NOT x3 AND NOT x4) OR ( NOT x1 AND NOT x2 AND x3 AND x4) OR (x1 AND NOT x2 AND NOT x3 AND X4 ) OR (NOT x1 AND x2 AND x3 AND NOT x4);
end ex;