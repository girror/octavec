function c = simple (a, b)

  [c1,c2] = complex_func(a, b + 1)
 
  c = c1 + c2
  n = ~(a<b) 
end



