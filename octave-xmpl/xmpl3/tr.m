for n = 1:1000
   b = factorial(n);
end
if (b==0)
  a=12
else
  a=13
end
result = factorial(n) + 8*a 
disp(result);
