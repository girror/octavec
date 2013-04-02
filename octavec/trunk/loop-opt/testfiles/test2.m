function test2
a = [12,23,34,45,56;12,23,34,45,56];
b = [2,4,6,8,10];
c = [12,23,34,45,56,67;12,23,34,45,56,67;12,23,34,45];

for i = 1:1:2
  v = a(i,1)
  a(i+1,i) = a(i,i-1)
  b(2) = a(i,1)
  for z = 1:1:2
    b(z) = a(z,i)
    a(i+z,z) = a(2,i)
    a(i,1) = 2
    v = b(z)
  endfor
  a(2,2) = a(2,3)
  a(i,i) = b(i)
  for g = 1:1:2
    c(g,z,i) = c(g-1,1,1)
  endfor
endfor
