function ret = multiple_assignment
  t = [1 2 ; 3 4];
  [a,b] = size(t);
  ma_test2 = a==2 && b==2;
  
  c = size(t);
  ma_test1 = c == [ 2 2 ] && true ; 

  d = 0 ;
  e = 0 ;
  [d,e] += size(t);

  ma_test3 = d==2 && e==2;

  ret = ma_test1 && ma_test2 && ma_test3;
end
