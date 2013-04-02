function ret = structs
  s.a = 3;
  s.b = 2;
  s.c = s.a ;
  s.a = 1;
  s.d = s;
  s.d.d = 4;
  t = s.d.b;
  ret = t == 2;
end

