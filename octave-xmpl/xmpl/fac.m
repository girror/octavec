function x = fac(n,m)
  if (n>0)
    x = n * fac(n-1,m) 
  else
    x = m;
  endif
endfunction
