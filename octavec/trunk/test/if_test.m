function ret = if_test

  a = 1;
  if a>0 
    b = 1;
  else
    b = 0;
  end

  if_test1 = b == 1;

  c = 0;
  
  if [1 0]
  else
    c = 1;
  end
  if_test2 = c == 1;

  d = { 0 } ;
  if d
    e = 1;
  else
    e = 0;
  end
  if_test3 = e == 1;

  e = { } ;
  if e
    f = 0;
  else
    f = 1;
  end
  if_test4 = f == 1;

  ret = if_test1 && if_test2 && if_test3 && if_test4; 
end
