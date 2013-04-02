function ret = subscript
  % initialization
  m = [1 2 ; 3 4];
  
  % access
  t1 = m(2);
  t2 = m(2,1);
  subscript_test1 = t1 == 3 && t2 == 3; 

  % colon
  t3 = m(:);
  t4 = m(:,:);
  subscript_test2 = t3 == [1;3;2;4] && t4 == [1 2 ; 3 4];
  
  % lvalue
  m(2,1) = 0;
  subscript_test3 = m == [1 2 ; 0 4] && true;
  
  % growing
  % m(6) = 10, not allowed if dim > 1
  m(3,3) = 5;
  subscript_test4 = m == [1 2 0 ; 0 4 0 ; 0 0 5] && true ;

  t5 = m(1:length(m));
  t6 = m(1:2,1:2);
  subscript_test5 = t5 == [1 0 0] && t6 == [1 2 ; 0 4] ;

  % growing of vectors
  v1 = [1 2 3];
  v1(4) = 4;
  v2 = [1 ; 2 ; 3];
  v2(4) = 4;
  subscript_test6 = v1 == [1 2 3 4] && v2 == [1;2;3;4] ;

  ret = subscript_test1 && subscript_test2 && subscript_test3 && subscript_test4 && subscript_test5 && subscript_test6 ;
end
