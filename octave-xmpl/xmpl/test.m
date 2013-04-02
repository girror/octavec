function x = test (i)    
  i = 7;
  x = 5;
  do
        x = i;
	disp(x);
        --i;
  until (i<=3)
endfunction   