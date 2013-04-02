 
function x = if_test(i) 
   i = i- 7;
   x = 5;

  if (i==1)
    x = 1;
  elseif (i==2)
     x = 2;
  elseif (i==3)
    x = 3;
  else
    x = 4;
    break
  endif

 if (i==1)
    disp(x) 
  else disp(i+2)
 endif
 x = 6

end