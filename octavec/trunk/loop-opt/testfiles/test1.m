function test2
a = [12,23,34,45,56;12,23,34,45,56];
b = [2,4,6,8,10];
c = [12,23,34,45,56,67;12,23,34,45,56,67;12,23,34,45];

for i = 1:1:2
  a(i) = b(i) * c(i)
endfor