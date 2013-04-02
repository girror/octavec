## Copyright (C) 2002 IfN, TU-Dresden

## Author: GC <cichon@ifn.et.tu-dresden.de>
## Created: 4. February 2002
## Adapted-By: gc

function x = syntax (i)

  x = 1;
## break testloop
  while (i > 0)
  	x = x * i;
	#break;
	i = i - 1;
  end  
## continue testloop
  while (i > 0)
  	x = x * i;
	i = i - 1;
	continue;
	i = i - 1;
  end
  i = 4;
  x = 4;
## dec (--x) and (x++)  ; testloop
  i = 4;
  while (i>3)
  	x = x * i;
	--i;
	x++;
  end
## decl test
  a = 4;
  d = 6;
  global a;
  global b = 2;
  global c = 3 e = 5 d;
## do until testloop
  i = 7;
  x = 5;
  do
  	x = x * i;
	--i;
  until (i<3)
##if test
  i = 7;
  x = 5;
  if (i==1)
    x = 1;
  elseif (i==2)
    x = 2;
  elseif (i==3)
    x = 3;
  else
    x = 4;
  endif
## switch test
  a = 2;
  switch a
    case (1)
      x = 1;
    case (2)
      x = 2;
    case (3)
      x = 4;
    otherwise
      x = 5;
  endswitch
# return testloop
  while (i>3)
    	x = x * i;
	return;
	i = i - 1;
  end
# endfunction
end




