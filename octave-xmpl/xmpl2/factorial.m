function x = factorial(n)
  if (n>0)
    x = n * factorial(n-1)
  else
    x = 1;
  endif
endfunction