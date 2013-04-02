function test
a = [1,2,3,5,6,7]
b = [1,2,3,4,5,6,7]
for i = 1:1:8
   a(2) = 88
   b(i) = a(2)
endfor
