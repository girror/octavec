function res = constant_propagation
z = 2;
x = 1;
y = x + 3;
x = z;
a = x + y;

constantprop_test_1 = a == 6;

x = 1;
y = z;
z = 3;
a = 4;
x = x + z;
a = 5;
if y 
  y = y + 5;
  z = 8;
else
  x = a + 21;
  z = a + z ;
end
b = a + z;
z = z + x ; 

constantprop_test_2 = a == 5 && b == 13 && z == 12 && x == 4;

x = 1;
y = z;
z = 3;
a = 4;
C = 0;
c = 0;
x = x + z;
a = 5;
i = 0;
while i < 100 + y 
  y = a + 5;
  c = y + 3 + z;
  i = i + 1;
end
j = i + 3;
b = a + z;
z = z + x;
C = c ;

constantprop_test_3 = j == 113 && b == 8 && z == 7 && C == 16;


t1 = 10;
t2 = 1;
t3 = 0;
t4 = 0;
while t2
  if t1==10
    t3 = t3 + 1 ;
    t2 = t2 -1 ;
  else
    t4 = t4 + 1 ;
    t1 = 100;
  end
end

t2 = t1 ;

constantprop_test_4 = t1 == 10 && t2 == 10 && t3 == 1 && t4 == 0 ; 

res = constantprop_test_1 && constantprop_test_2 && constantprop_test_3 && constantprop_test_4;
