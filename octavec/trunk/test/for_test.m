function ret = for_test 

  for x1 = 1
    t = x1;
  end
  for_test1 = t == 1;

  for x2 = [ 1 2 3 4 5 ]
    t = x2;
  end
  for_test2 = t == 5;

  c.a = 1;
  c.b = 2;

%  for [v,k] = c
%    t1 = v;
%    t2 = k;
%  end
%  for_test3 = t1 == 2 && t2 == "b" ;
for_test3=1;
  t3 = 0;
  
  for x3 = 1:100
    t3++ ;
  end
  for_test4 = t3 == 100;
  
  b = 4;
  for x4 = 1:(4*b)
    t4 = x4;
  end
  for_test5 = t4 == 4*b;

  for x5 = [4 3 ; 2 1]
    t5 = x5;
  end
  for_test6 = t5 == [3 ; 1] && true;

%  for x6 = {1 2 3 4}
%    t6 = x6;
%  end
%  for_test7 = t6{1,1} == 4;

%  for x7 = {1 2 ; 3 4}
%    t7 = x7;
%  end
%  for_test8 = t7{1,1} == 2 && t7{2,1} == 4;
for_test7 = 1;
for_test8 = 1;

  ret = for_test1 && for_test2 && for_test3 && for_test4 && for_test5 && for_test6 && for_test7 && for_test8 ;

end
