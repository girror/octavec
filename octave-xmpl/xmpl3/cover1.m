function c = cover(n)
  c = 1;
  a = [1 1 0 0; 0 1 1 0; 0 0 1 1; 0 1 0 1];
  i = 1
  while ( i++ <= n )
    c = c * a;
  endwhile
endfunction
							
