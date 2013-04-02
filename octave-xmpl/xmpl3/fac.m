function x = fac(n)
     if n > 1
       x = n * fac(n-1);
     else
       x =1;
     end
end
