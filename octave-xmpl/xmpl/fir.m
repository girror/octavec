## Copyright (C) 2002 IfN, TU-Dresden

## Author: GC <cichon@ifn.et.tu-dresden.de>
## Created: 4. February 2002
## Adapted-By: gc

function y = fir (c, x, m, n)

  for i = 1:1:n
    y(i) = 0.0;
  end

  for i = 1:1:(n-m)
    for k = 1:1:m
      y(i+k) = c(k) * x(i) + y(i+k);
    end
  end

end
