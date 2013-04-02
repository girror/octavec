function test3
a = [12,23,34,45,56];
b = [2,4,6,8,10];
c = [12,23,34,45,56,67];

for i = 1:1:2
  for z = 1:1:2
    a(i+z) = a(2)
  endfor
  a(2) = a(3)
endfor
