## Copyright (C) 2002 IfN, TU-Dresden

## Author: GC <cichon@ifn.et.tu-dresden.de>
## Created: 4. February 2002
## Adapted-By: gc

function y = iir (b, c, x, l, m, n)
 
  #f = m + n

  for i = 1:1:n
    y(i) = 0.0;
  end

  for i = 1:1:(n-m)
    for k = 1:1:m
      y(i+k) = c(k) * x(i) + y(i+k);
    end
  end

  for i = 1:1:(n-l)
    for j = 1:1:l
      y(j+i) = b(j) * y(i) + y(j+i);
    end
  end



end
