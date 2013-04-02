function ret = cat_matrix
  m = [1 2];
  m1 = [m ; m];
  m2 = [m 0 ; 0 m];
  m3 = [m ; length(m):-1:1 ];
  m4 = [m m ; length(m):-1:1 length(m):-1:1 ];

  ret = true;
end
