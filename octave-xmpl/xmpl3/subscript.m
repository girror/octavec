function subscript 
a(2) = 10
a(1) = 10
for x = 1:10
  a(x+1) = a(x);
end
a
